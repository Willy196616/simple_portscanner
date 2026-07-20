#!/bin/bash
#
# my_port_scanner.sh
# My first port scanner made in pure Bash (no nmap, nothing fancy).
# Made this while learning about networking and /dev/tcp. Any feedback is welcome :)

# Default variables
target_ip=""
last_port=1024   # If no range is given, we scan from 1 to 1024
output_file=""   # If the user wants, we save the results here

# Reading the arguments passed in the console
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -t | --target )   target_ip="$2"; shift ;;
        -r | --range )    last_port="$2"; shift ;;
        -o | --output )   output_file="$2"; shift ;;
        * )                echo "[!] I don't know that parameter: $1"; exit 1 ;;
    esac
    shift
done

# Check that we got an IP, otherwise explain how to use it
if [[ -z "$target_ip" ]]; then
    echo "How to use it: $0 -t <IP> [-r <MAX_PORT>] [-o <results_file.txt>]"
    echo "Example: $0 -t 10.10.10.10 -r 5000 -o results.txt"
    echo "Note: if you don't pass -r, it scans the first 1024 ports by default."
    exit 1
fi

echo "[*] Starting scan on $target_ip (ports 1-$last_port)..."
echo "[*] This might take a little while, be patient ;)"
echo ""

# Here we keep track of how many open ports we found, for the final summary
open_ports=0

# The trick is using /dev/tcp, a Bash-only feature
for port in $(seq 1 "$last_port"); do
    if (echo > /dev/tcp/"$target_ip"/"$port") > /dev/null 2>&1; then
        echo "[+] Port $port OPEN"
        open_ports=$((open_ports + 1))

        # If the user asked to save results, we log them here
        if [[ -n "$output_file" ]]; then
            echo "Port $port open on $target_ip" >> "$output_file"
        fi
    fi
done

echo ""
echo "[*] Scan finished."
echo "[*] Open ports found: $open_ports"

if [[ -n "$output_file" ]]; then
    echo "[*] Results saved to: $output_file"
fi
