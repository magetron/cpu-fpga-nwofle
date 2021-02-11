#include <sys/socket.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <netinet/ip.h>
#include <netinet/udp.h>
#include <arpa/inet.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <errno.h>
#include <unistd.h>

#include <cstdio>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <type_traits>

#include "rawsockinit/config.hh"

static const uint64_t SEC_IN_USEC = 1e6;
static const uint64_t MS_IN_USEC = 1e3;

enum class packet_mode_t {
  UDP_TEST,
  DNS_TEST
};

enum class send_mode_t {
  DAEMON,
  ONCE
};

packet_mode_t PACKET_MODE = packet_mode_t::UDP_TEST;
send_mode_t SEND_MODE = send_mode_t::ONCE;
uint64_t SEND_TIME = SEC_IN_USEC;

uint16_t checksum(uint16_t *buff, int32_t _16bitword) {
  uint32_t sum;
  for (sum = 0; _16bitword > 0; _16bitword--)
    sum += htons(*(buff)++);
  sum = ((sum >> 16) + (sum & 0xFFFF));
  sum += (sum >> 16);
  return (uint16_t)(~sum);
}

void trigger_send (ifreq ifreq_i, int32_t sock_raw, uint8_t *sendbuf) {
  sockaddr_ll sadr_ll;
  sadr_ll.sll_ifindex = ifreq_i.ifr_ifindex;
  sadr_ll.sll_halen = ETH_ALEN;
  sadr_ll.sll_addr[0] = 0x00;
  sadr_ll.sll_addr[0] = 0x0A;
  sadr_ll.sll_addr[0] = 0x35;
  sadr_ll.sll_addr[0] = 0x00;
  sadr_ll.sll_addr[0] = 0x00;
  sadr_ll.sll_addr[0] = 0x00;

  int32_t send_len = sendto(sock_raw, sendbuf, 7 + sizeof(udphdr) + sizeof(iphdr) + sizeof(ethhdr), 0,
                            reinterpret_cast<const sockaddr *>(&sadr_ll), sizeof(sockaddr_ll));
  if (send_len < 0)
  {
    printf("ERROR in sending, sendlen=%d, errno=%d\n", send_len, errno);
    perror("Socket:");
    exit(-1);
  }

  usleep(SEND_TIME);
}

int main (int argc, char **argv) {

  int c;
  opterr = 0;
  while ((c = getopt(argc, argv, "p:t:d")) != -1) {
    switch (c) {
      case 'p':
        if (!strncmp(optarg, "UDP", 4)) {
          PACKET_MODE = packet_mode_t::UDP_TEST;
        } else if (!strncmp(optarg, "DNS", 4)) {
          PACKET_MODE = packet_mode_t::DNS_TEST;
        }
        break;
      case 't':
        SEND_TIME = atoi(optarg) * MS_IN_USEC;
        break;
      case 'd':
        SEND_MODE = send_mode_t::DAEMON;
        break;
      default:
        printf("Unrecognised argument\n");
    }
  }

  int32_t sock_raw = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
  if (sock_raw == -1)
  {
    printf("ERROR in socket\n");
  }

  ifreq ifreq_i;
  memset(&ifreq_i, 0, sizeof(ifreq_i));
  strncpy(ifreq_i.ifr_name, "ens37", 6);
  if ((ioctl(sock_raw, SIOCGIFINDEX, &ifreq_i)) < 0)
  {
    printf("ERROR in index ioctl reading");
  }

  ifreq ifreq_c;
  memset(&ifreq_c, 0, sizeof(ifreq_c));
  strncpy(ifreq_c.ifr_name, "ens37", 6);
  if ((ioctl(sock_raw, SIOCGIFHWADDR, &ifreq_c)) < 0)
  {
    printf("ERROR in SIOCGIFHWADDR ioctl reading\n");
  }

  uint8_t *sendbuf = new uint8_t[BUFFER_SIZE];

  ethhdr *eth = reinterpret_cast<ethhdr *>(sendbuf);
  eth->h_source[0] = (uint8_t)(ifreq_c.ifr_hwaddr.sa_data[0]);
  eth->h_source[1] = (uint8_t)(ifreq_c.ifr_hwaddr.sa_data[1]);
  eth->h_source[2] = (uint8_t)(ifreq_c.ifr_hwaddr.sa_data[2]);
  eth->h_source[3] = (uint8_t)(ifreq_c.ifr_hwaddr.sa_data[3]);
  eth->h_source[4] = (uint8_t)(ifreq_c.ifr_hwaddr.sa_data[4]);
  eth->h_source[5] = (uint8_t)(ifreq_c.ifr_hwaddr.sa_data[5]);
  printf("%02X.%02X.%02X.%02X.%02X.%02X\n", eth->h_source[0], eth->h_source[1],
         eth->h_source[2], eth->h_source[3],
         eth->h_source[4], eth->h_source[5]);
  eth->h_dest[0] = 0x00;
  eth->h_dest[1] = 0x0A;
  eth->h_dest[2] = 0x35;
  eth->h_dest[3] = 0x00;
  eth->h_dest[4] = 0x00;
  eth->h_dest[6] = 0x00;
  eth->h_proto = htons(static_cast<uint16_t>(e_ethertype::IPv4));
  iphdr *ip = reinterpret_cast<iphdr *>(eth + 1);
  ip->ihl = 5;
  ip->version = 4;
  ip->tos = 16;
  ip->id = htons(10201);
  ip->ttl = 64;
  ip->protocol = 17;
  ip->saddr = inet_addr(inet_ntoa((((sockaddr_in *)&(ifreq_i.ifr_addr))->sin_addr)));
  char ipstr[INET_ADDRSTRLEN];
  printf("%s\n", inet_ntop(AF_INET, &(ip->saddr), ipstr, INET_ADDRSTRLEN));
  ip->daddr = htonl((192 << 24) + (168 << 16) + (5 << 8) + 1);

  udphdr *udp = reinterpret_cast<udphdr *>(ip + 1);
  udp->source = htons(12345);
  udp->dest = htons(23456);
  udp->check = 0;

  if (PACKET_MODE == packet_mode_t::DNS_TEST) {
    char *payload = reinterpret_cast<char *>(udp + 1);
    payload[0] = 'i';
    payload[1] = 't';
    payload[2] = 's';
    payload[3] = 'd';
    payload[4] = 'n';
    payload[5] = 's';
    payload[6] = '\0';
  } else {
    char *payload = reinterpret_cast<char *>(udp + 1);
    payload[0] = 't';
    payload[1] = 'e';
    payload[2] = 's';
    payload[3] = 't';
    payload[4] = '1';
    payload[5] = '2';
    payload[6] = '\0';
  }

  udp->len = htons(7 + sizeof(udphdr));
  ip->tot_len = htons(7 + sizeof(udphdr) + sizeof(iphdr));
  ip->check = htons(checksum(reinterpret_cast<uint16_t *>(ip), (sizeof(iphdr) / 2)));

  if (SEND_MODE == send_mode_t::DAEMON) {
    while (true) {
      trigger_send(ifreq_i, sock_raw, sendbuf);
    }
  } else {
    trigger_send(ifreq_i, sock_raw, sendbuf);
  }

  delete[] sendbuf;

  return 0;
}