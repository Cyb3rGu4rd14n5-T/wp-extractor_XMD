#!/bin/bash

# 🔱 cyberguardians-T WP Extractor XMD
# WordPress REST API Scanner for Recon and Bug Bounty

# Colors
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
CYAN="\e[1;36m"
RESET="\e[0m"

clear

# Check for figlet
if ! command -v figlet &> /dev/null; then
  echo -e "${RED}[!] 'figlet' not found. Please install it: sudo apt install figlet${RESET}"
  exit 1
fi

# Banner
echo -e "${CYAN}"
figlet -f slant "cyberguardians-T"
echo -e "${YELLOW}🔱 WP Extractor XMD | WordPress API Recon Tool 🔱"
echo -e "${CYAN}Author: Cyb3rGu4rd14n5-T${RESET}"
echo

# Ask for input
read -p "🌐 Enter WordPress site URL (e.g. https://example.com/blog): " input
base_url=$(echo "$input" | sed -E 's#(https?://[^/]+).*#\1#')

echo -e "\n${YELLOW}[*] Target base URL:${RESET} $base_url"
echo -e "${YELLOW}[*] Scanning $base_url/wp-json for exposed API data...${RESET}"

# Clear previous output
> emails.txt
> usernames.txt
> post_titles.txt
> endpoints.txt

# --- Discover All Available API Endpoints ---
echo -e "${CYAN}[+] Discovering all available API endpoints...${RESET}"
all_routes=$(curl -s "$base_url/wp-json" | jq -r '.routes | keys[]' 2>/dev/null)

if [ -z "$all_routes" ]; then
  echo -e "${RED}[!] No endpoints found or not a WordPress site with REST API.${RESET}"
  exit 1
fi

echo "$all_routes" | tee endpoints.txt > /dev/null
endpoint_count=$(wc -l < endpoints.txt)

echo -e "${GREEN}[+] Found $endpoint_count API endpoints.${RESET}"
echo -e "${CYAN}All endpoints saved to endpoints.txt${RESET}"

# --- Extract Usernames & Emails from /users ---
if grep -q "^/wp/v2/users" endpoints.txt; then
  echo -e "${CYAN}[+] Extracting usernames and emails from /wp/v2/users...${RESET}"
  users_json=$(curl -s "$base_url/wp-json/wp/v2/users")
  echo "$users_json" | jq -r '.[].name' 2>/dev/null | tee usernames.txt > /dev/null
  echo "$users_json" | grep -E -o "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" | tee emails.txt > /dev/null
else
  echo -e "${YELLOW}[-] /wp/v2/users not exposed.${RESET}"
fi

# --- Extract Post Titles from /posts ---
if grep -q "^/wp/v2/posts" endpoints.txt; then
  echo -e "${CYAN}[+] Extracting post titles from /wp/v2/posts...${RESET}"
  curl -s "$base_url/wp-json/wp/v2/posts" | jq -r '.[].title.rendered' 2>/dev/null | tee post_titles.txt > /dev/null
else
  echo -e "${YELLOW}[-] /wp/v2/posts not exposed.${RESET}"
fi

# --- Final Summary ---
echo -e "\n${GREEN}✅ Extraction complete!${RESET}"
echo -e "📁 ${CYAN}endpoints.txt${RESET}   → $endpoint_count total API endpoints"
echo -e "📁 ${CYAN}usernames.txt${RESET}   → $(wc -l < usernames.txt) usernames"
echo -e "📁 ${CYAN}emails.txt${RESET}      → $(wc -l < emails.txt) emails"
echo -e "📁 ${CYAN}post_titles.txt${RESET} → $(wc -l < post_titles.txt) titles"

