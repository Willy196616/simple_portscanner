# my-port-scanner 🔍

Hey! This is my first little project messing around with Bash and networking stuff. It's a super simple port scanner that doesn't use `nmap` or any external tool — just pure Bash, using a trick called `/dev/tcp`.

I built it mostly to understand how port scanning works under the hood. It's definitely not as fast or as fancy as real tools out there, but hey, I learned a lot doing it, so I wanted to share it :)

## What does it do?

It goes through a range of ports on a target IP and tells you which ones are open, by trying to open a TCP connection to each one.

## How to use it

```bash
chmod +x my_port_scanner.sh
./my_port_scanner.sh -t <IP> [-r <MAX_PORT>] [-o <results_file.txt>]
```

### Options

| Flag | What it does | Required? |
|------|---------------|-----------|
| `-t`, `--target` | The IP you want to scan | Yes |
| `-r`, `--range` | Max port to scan up to (default is 1024) | No |
| `-o`, `--output` | Save the open ports to a text file | No |

### Example

```bash
./my_port_scanner.sh -t 10.10.10.10 -r 5000 -o results.txt
```

This scans ports 1 to 5000 on `10.10.10.10` and saves the open ones to `results.txt`.

## How it works (kind of)

Bash has this neat feature where you can "open" a file like `/dev/tcp/IP/PORT` and it actually tries to make a TCP connection. If it works, the port's open. If it fails, it's closed (or filtered, or whatever — I'm still learning the nuances here 😅).

## ⚠️ Heads up

Only use this on IPs/networks you own or have permission to test. Scanning stuff you don't have permission for is not cool (and often illegal). I made this for learning purposes / CTFs / my own lab.

## Things I might add later

- [ ] Multi-threading / faster scanning (right now it's pretty slow, one port at a time)
- [ ] Common service name next to each open port
- [ ] Colored output
- [ ] A timeout option, some networks are just slow to respond

## License

Do whatever you want with it, just don't blame me if it breaks something 😄
