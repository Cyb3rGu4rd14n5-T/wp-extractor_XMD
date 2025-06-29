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

- 🔍 Auto-detects `/wp-json` even from full paths like `/blog/`
- 📧 Extracts **usernames**, **emails**, and **post titles**
- 💾 Saves to `usernames.txt`, `emails.txt`, `post_titles.txt`
- 🧼 Clears old data before each run

Works on Kali Linux, Parrot, Ubuntu, WSL, etc.




## 🚀 How to Use

### 📦 Clone the Repository

git clone https://github.com/Cyb3rGu4rd14n5-T/wp-extractor_XMD.git

cd wp-extractor_XMD

chmod +x wp-extractor.sh

▶️ Run the Tool

./wp-extractor.sh

💡 Example

Enter WordPress site URL (e.g. https://example.com/blog/): https://example.com/blog/

[*] Scanning https://example.com/wp-json for exposed API data...
[+] Extracted 3 emails, 5 usernames, and 10 post titles.

🗂️ Output
emails.txt → Extracted emails

usernames.txt → WordPress usernames

post_titles.txt → Titles of public blog posts

⚠️ Disclaimer
This tool is for educational and authorized testing only.
Always follow bug bounty scope and rules.














