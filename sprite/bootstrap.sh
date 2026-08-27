#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '\n==> %s\n' "$*"
}

have_nix() {
  command -v nix >/dev/null 2>&1 || [[ -x /nix/var/nix/profiles/default/bin/nix ]]
}

source_nix_profile_if_present() {
  if [[ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
    # shellcheck disable=SC1091
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  elif [[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    # shellcheck disable=SC1091
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  fi
}

configure_nix() {
  log "Configuring persistent Nix settings"
  sudo mkdir -p /etc/nix
  sudo touch /etc/nix/nix.conf

  if ! sudo grep -q '^build-users-group = nixbld$' /etc/nix/nix.conf; then
    printf 'build-users-group = nixbld\n' | sudo tee -a /etc/nix/nix.conf >/dev/null
  fi

  if ! sudo grep -q '^experimental-features = .*nix-command.*flakes' /etc/nix/nix.conf; then
    printf 'experimental-features = nix-command flakes\n' | sudo tee -a /etc/nix/nix.conf >/dev/null
  fi
}

ensure_nix_daemon() {
  if [[ -x /nix/var/nix/profiles/default/bin/nix-daemon ]]; then
    log "Ensuring nix-daemon is running"
    if ! sudo pgrep -x nix-daemon >/dev/null 2>&1; then
      sudo sh -c 'nohup /nix/var/nix/profiles/default/bin/nix-daemon >/tmp/nix-daemon.log 2>&1 &'
    fi

    for _ in $(seq 1 30); do
      [[ -S /nix/var/nix/daemon-socket/socket ]] && return 0
      sleep 1
    done
  fi
}

install_nix_if_needed() {
  if have_nix; then
    log "Nix already installed; skipping install"
  else
    log "Installing Nix with daemon installer"
    curl -L https://nixos.org/nix/install | sh -s -- --daemon
  fi

  configure_nix
  ensure_nix_daemon
  source_nix_profile_if_present

  log "Checking Nix"
  nix --version
  nix store ping
}

install_direnv() {
  log "Installing direnv with apt"
  sudo apt-get update
  sudo apt-get install -y direnv
}

install_pi_if_needed() {
  if command -v pi >/dev/null 2>&1; then
    log "pi already installed; skipping install"
  else
    log "Installing pi"
    npm install -g --ignore-scripts @earendil-works/pi-coding-agent
  fi
}

write_pi_config() {
  local pi_dir="$HOME/.pi/agent"
  local auth_file="$pi_dir/auth.json"
  local settings_file="$pi_dir/settings.json"

  log "Writing pi auth.json"
  mkdir -p "$pi_dir"

  printf '\nPaste your auth.json now, then press Ctrl-D when done:\n'
  cat > "$auth_file"
  chmod 600 "$auth_file"

  log "Writing pi settings.json"
  cat > "$settings_file" <<'JSON'
{
  "defaultModel": "gpt-5.6-sol",
  "defaultProvider": "openai-codex",
  "defaultThinkingLevel": "high",
  "hideThinkingBlock": true,
  "steeringMode": "all",
  "theme": "dark",
  "compaction": {
    "enabled": true
  },
  "shellCommandPrefix": "eval \"$(DEVSHELL_NO_MOTD=1 direnv export bash 2>/dev/null)\""
}
JSON
  chmod 600 "$settings_file"
}

main() {
  install_nix_if_needed
  install_direnv
  install_pi_if_needed
  write_pi_config

  log "Bootstrap complete"
}

main "$@"
