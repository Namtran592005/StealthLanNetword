
from scapy.all import ARP, sniff, send, get_if_hwaddr, conf, Ether, srp
import subprocess, re

def get_gateway_ip():
    try:
        result = subprocess.check_output("ipconfig", shell=True).decode()
        match = re.search(r"Default Gateway[ .:]*([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)", result)
        if match:
            return match.group(1)
    except: pass
    return None

def get_mac(ip):
    ans, _ = srp(Ether(dst="ff:ff:ff:ff:ff:ff")/ARP(pdst=ip), timeout=2, verbose=0)
    for _, rcv in ans:
        return rcv[Ether].src
    return None

def arp_filter(pkt):
    if pkt.haslayer(ARP) and pkt[ARP].op == 1:  # who-has (request)
        if pkt[ARP].pdst == my_ip:
            sender_ip = pkt[ARP].psrc
            sender_mac = pkt[ARP].hwsrc
            if sender_ip == router_ip and sender_mac.lower() == router_mac.lower():
                arp_reply = ARP(op=2, hwsrc=my_mac, psrc=my_ip,
                                hwdst=sender_mac, pdst=sender_ip)
                send(arp_reply, verbose=0)

router_ip = get_gateway_ip()
router_mac = get_mac(router_ip) if router_ip else None
my_ip = conf.route.route("0.0.0.0")[1]
my_mac = get_if_hwaddr(conf.iface)

if router_ip and router_mac:
    sniff(filter="arp", prn=arp_filter, store=0)
