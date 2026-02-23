# TOOLS.md - Local Notes

## Host

- **Hostname:** zoidberg-crab-shell
- **OS:** Ubuntu 24.04.3 LTS (x86_64, kernel 6.8.0-90)
- **IP:** 46.225.127.41
- **Disk:** 75G total, ~68G free
- **Node:** v22.22.0
- **OpenClaw:** v2026.2.21-2 (systemd user service)

## SSH

- **Key:** ~/.ssh/id_ed25519 (ed25519, `openclaw@zoidberg`)
- **GitHub deploy key** on noahmilstein/zoidberg-vault (read/write)

## Git

- **Workspace repo:** git@github.com:noahmilstein/zoidberg-vault.git
- **Git identity:** Zoidberg <openclaw@zoidberg>

## Installed

- git, node, npm, curl, wget, python3
- **Missing:** pnpm (config references it but not installed), trash-cli

## Services

- openclaw-gateway (systemd user, active)
- gpg-agent
