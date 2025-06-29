#!/bin/bash

# 🔱 cyberguardians-T WP Extractor XMD (with colors)
# WordPress REST API Scanner for Bug Bounty Recon

# Colors
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
CYAN="\e[1;36m"
RESET="\e[0m"

clear
echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════╗"
echo "║     🔱 cyberguardians-T - WP Extractor XMD         ║"
echo "╚════════════════════════════════════════════════════╝"
echo -e "${RESET}"

read -p "🌐 Enter WordPress site URL (e.g. https://example.com/blog): " input
base_url=$(echo "$input" | sed -E 's#(https?://[^/]+).*#\1#')

echo -e "\n${YELLOW}[*] Target base URL:${RESET} $base_url"
echo -e "${YELLOW}[*] Scanning $base_url/wp-json for exposed API data...${RESET}"

# Clear previous output
> emails.txt
> usernames.txt
> post_titles.txt

# --- Users Endpoint ---
echo -e "${CYAN}[+] Checking /wp-json/wp/v2/users for usernames and emails...${RESET}"
users_json=$(curl -s "$base_url/wp-json/wp/v2/users")

echo "$users_json" | jq -r '.[].name' 2>/dev/null | tee usernames.txt > /dev/null
echo "$users_json" | grep -E -o "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" | tee emails.txt > /dev/null

# --- Posts Endpoint ---
echo -e "${CYAN}[+] Checking /wp-json/wp/v2/posts for post titles...${RESET}"
curl -s "$base_url/wp-json/wp/v2/posts" | jq -r '.[].title.rendered' 2>/dev/null | tee post_titles.txt > /dev/null

# --- Output Summary ---
echo -e "\n${GREEN}✅ Extraction complete!${RESET}"
echo -e "📁 ${CYAN}usernames.txt${RESET}   → ${GREEN}$(wc -l < usernames.txt) usernames${RESET}"
echo -e "📁 ${CYAN}emails.txt${RESET}      → ${GREEN}$(wc -l < emails.txt) emails${RESET}"
echo -e "📁 ${CYAN}post_titles.txt${RESET} → ${GREEN}$(wc -l < post_titles.txt) titles${RESET}"
