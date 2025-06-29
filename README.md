# wp-extractor_XMD
🔱 wp-extractor.sh — by cyberguardians-T
A lightweight bash-based WordPress reconnaissance tool designed for bug bounty hunters and security researchers.

It scans a WordPress site’s exposed REST API (/wp-json) to extract:

✅ Usernames from /wp-json/wp/v2/users

✅ Emails (if publicly exposed)

✅ Post titles from /wp-json/wp/v2/posts

The tool is interactive, bannered, and saves output to three separate files:

emails.txt

usernames.txt

post_titles.txt

This helps researchers quickly identify misconfigured WordPress sites that may expose internal or sensitive user data — a common bug bounty finding.

📦 Features:
Fully bash-based, no Python or setup needed.

Automatically sanitizes URLs (even if full paths like /blog/ are given).

Clears old output each time for clean results.

Stylish ASCII banner for branding.

Works on Kali Linux, Parrot, Ubuntu, WSL, etc.


💻 How to Use

git clone https://github.com/YOUR_USERNAME/wp-extractor.git
cd wp-extractor
chmod +x wp-extractor.sh
./wp-extractor.sh


📌 Example Input:
Enter WordPress site URL: https://example.com/blog/

The tool auto-corrects this to scan https://example.com/wp-json.

⚠️ Disclaimer
This tool is for educational and authorized testing only.
Always follow bug bounty scope and rules.














