# Gobuster + Wordlists - Docker Bundle

Docker deployment of Gobuster with wordlists for web enumeration and directory brute-forcing.

## Description

Containerized [Gobuster](https://github.com/OJ/gobuster) with wordlist collections for penetration testing and CTF challenges.

## Prerequisites

- Docker
- Docker Compose

## Installation

```bash
# Build and start
docker compose up -d --build
```

## Wordlists Included

| File | Description |
|------|-------------|
| `wordlist/common.txt` | Common paths and directories (~4600 entries) |
| `wordlist/possible_words.txt` | Additional possible words |

> **Note**: For larger wordlists, consider mounting [SecLists](https://github.com/danielmiessler/SecLists) as a volume.

## Usage

### Directory Brute-forcing

```bash
# Basic directory scan
docker compose run --rm gobuster gobuster dir \
  -u http://target.com \
  -w /app/wordlist/common.txt

# With extensions
docker compose run --rm gobuster gobuster dir \
  -u http://target.com \
  -w /app/wordlist/common.txt \
  -x php,html,txt

# With status codes
docker compose run --rm gobuster gobuster dir \
  -u http://target.com \
  -w /app/wordlist/common.txt \
  -s "200,204,301,302,307,401,403"
```

### DNS Subdomain Enumeration

```bash
docker compose run --rm gobuster gobuster dns \
  -d target.com \
  -w /app/wordlist/common.txt
```

### VHost Discovery

```bash
docker compose run --rm gobuster gobuster vhost \
  -u http://target.com \
  -w /app/wordlist/common.txt
```

## Configuration

### docker-compose.yml

The compose file mounts the local `wordlist/` directory to `/app/wordlist` in the container:

```yaml
services:
  gobuster:
    build: .
    volumes:
      - ./wordlist:/app/wordlist:ro
      - ./results:/app/results
```

### Adding Custom Wordlists

Place additional wordlist files in the `wordlist/` directory:
```bash
# Add your own wordlist
cp my_custom_wordlist.txt wordlist/

# Or mount SecLists
git clone https://github.com/danielmiessler/SecLists.git
# Then add to docker-compose.yml: - ./SecLists:/app/SecLists:ro
```

## Advanced Usage

### Save Results

```bash
docker compose run --rm gobuster gobuster dir \
  -u http://target.com \
  -w /app/wordlist/common.txt \
  -o /app/results/scan_results.txt
```

### Threads Configuration

```bash
# Use 50 concurrent threads
docker compose run --rm gobuster gobuster dir \
  -u http://target.com \
  -w /app/wordlist/common.txt \
  -t 50
```

### Follow Redirects

```bash
docker compose run --rm gobuster gobuster dir \
  -u http://target.com \
  -w /app/wordlist/common.txt \
  -r
```

### Authentication

```bash
# Basic auth
docker compose run --rm gobuster gobuster dir \
  -u http://target.com \
  -w /app/wordlist/common.txt \
  -U username -P password

# Cookie-based
docker compose run --rm gobuster gobuster dir \
  -u http://target.com \
  -w /app/wordlist/common.txt \
  -c "session=abc123"
```

## Performance Tips

- Start with smaller wordlists
- Increase threads gradually (-t option)
- Use specific extensions (-x)
- Filter by status codes (-s)

## Troubleshooting

### Slow Scans

```bash
# Increase threads
-t 100

# Use smaller wordlist
-w /app/wordlist/possible_words.txt
```

### Rate Limiting

```bash
# Add delay between requests
--delay 100ms
```

### Certificate Errors

```bash
# Skip SSL verification
-k
```

## Security Notes

**CRITICAL**:
- **Authorized testing only** - Only scan systems you own or have written permission to test
- **Legal compliance** - Ensure compliance with laws and regulations
- **Ethical use** - Follow responsible disclosure
- **Rate limiting** - Don't overwhelm target servers
- **No malicious use** - For authorized security testing and CTFs only

## Use Cases

- Web application enumeration
- Directory discovery
- Subdomain enumeration
- Virtual host discovery
- API endpoint discovery
- CTF competitions
- Bug bounty hunting
- Penetration testing

## Resources

- [Gobuster GitHub](https://github.com/OJ/gobuster)
- [SecLists](https://github.com/danielmiessler/SecLists)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)

## License

Personal project - Authorized testing only

---

**Disclaimer**: This tool is for authorized security testing only. Unauthorized scanning is illegal.

**Note**: Gobuster is developed by OJ Reeves. This is a deployment configuration.
