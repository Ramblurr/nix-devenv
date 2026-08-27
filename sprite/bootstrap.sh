#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '\n==> %s\n' "$*"
}

have_nix() {
  [[ -x /nix/var/nix/profiles/default/bin/nix ]] || command -v nix >/dev/null 2>&1
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

remove_nix_daemon_service() {
  if command -v sprite-env >/dev/null 2>&1 && \
     sprite-env services get nix-daemon >/dev/null 2>&1; then
    log "Removing persistent nix-daemon Sprite service"
    sprite-env services delete nix-daemon >/dev/null
    sleep 1
  fi
}

install_lazy_nix_wrappers() {
  local helper=/usr/local/libexec/ensure-nix-daemon
  local tool
  local tools=(
    nix nix-build nix-channel nix-collect-garbage nix-copy-closure nix-env
    nix-hash nix-instantiate nix-prefetch-url nix-shell nix-store
  )

  log "Installing lazy nix-daemon wrappers"
  sudo mkdir -p /usr/local/libexec /usr/local/bin

  sudo tee "$helper" >/dev/null <<'SH'
#!/bin/sh
set -eu

nix_daemon=/nix/var/nix/profiles/default/bin/nix-daemon
socket=/nix/var/nix/daemon-socket/socket

if pgrep -x nix-daemon >/dev/null 2>&1 && [ -S "$socket" ]; then
  exit 0
fi

if [ ! -x "$nix_daemon" ]; then
  echo "Nix daemon is not installed at $nix_daemon" >&2
  exit 1
fi

# A raw background process does not register as a Sprite service, so it will
# not keep an otherwise-idle Sprite alive. The next Nix invocation starts it
# again if the Sprite has resumed without it.
sudo -n sh -c '
  if ! pgrep -x nix-daemon >/dev/null 2>&1; then
    nohup /nix/var/nix/profiles/default/bin/nix-daemon \
      >/tmp/nix-daemon.log 2>&1 &
  fi
'

count=0
while [ "$count" -lt 30 ]; do
  if pgrep -x nix-daemon >/dev/null 2>&1 && [ -S "$socket" ]; then
    exit 0
  fi
  count=$((count + 1))
  sleep 1
done

echo "nix-daemon did not become ready; see /tmp/nix-daemon.log" >&2
exit 1
SH
  sudo chmod 755 "$helper"

  for tool in "${tools[@]}"; do
    sudo tee "/usr/local/bin/$tool" >/dev/null <<SH
#!/bin/sh
set -eu
/usr/local/libexec/ensure-nix-daemon
exec /nix/var/nix/profiles/default/bin/$tool "\$@"
SH
    sudo chmod 755 "/usr/local/bin/$tool"
  done

  # The Nix installer prepends its profile bin directory. Re-prepend
  # /usr/local/bin afterward so future shells resolve the lazy wrappers first.
  sudo tee /etc/profile.d/zz-nix-lazy.sh >/dev/null <<'SH'
case ":$PATH:" in
  *:/usr/local/bin:*) PATH="/usr/local/bin:${PATH//:\/usr\/local\/bin/}" ;;
  *) PATH="/usr/local/bin:$PATH" ;;
esac
export PATH
SH
  sudo chmod 644 /etc/profile.d/zz-nix-lazy.sh

  for shell_rc in /etc/bash.bashrc /etc/zsh/zshrc; do
    if [[ -f "$shell_rc" ]] && ! sudo grep -qF '/etc/profile.d/zz-nix-lazy.sh' "$shell_rc"; then
      printf '\n# Lazy Nix daemon wrappers\n[ -r /etc/profile.d/zz-nix-lazy.sh ] && . /etc/profile.d/zz-nix-lazy.sh\n' \
        | sudo tee -a "$shell_rc" >/dev/null
    fi
  done

  # Make wrappers take precedence for the rest of this bootstrap run.
  PATH="/usr/local/bin:$PATH"
  export PATH
  hash -r
}

install_nix_if_needed() {
  if have_nix; then
    log "Nix already installed; skipping install"
  else
    log "Installing Nix with daemon installer"
    curl -L https://nixos.org/nix/install | sh -s -- --daemon
  fi

  configure_nix
  remove_nix_daemon_service
  source_nix_profile_if_present
  install_lazy_nix_wrappers

  log "Checking lazy Nix startup"
  nix --version
  nix store info
}

install_stuff() {
  log "Installing apt stuff"
  sudo apt-get update
  sudo apt-get install -y direnv ripgrep fd-find ncurses-bin
  sed -i 's/^#force_color_prompt=yes$/force_color_prompt=yes/' "$HOME/.bashrc"
  grep -qxF 'eval "$(direnv hook bash)"' "$HOME/.bashrc" 2>/dev/null ||
     printf '\neval "$(direnv hook bash)"\n' >> "$HOME/.bashrc"
  if ! infocmp -x xterm-ghostty >/dev/null 2>&1; then
    mkdir -p "$HOME/.terminfo"
    tic -x -o "$HOME/.terminfo" - <<'TERMINFO'
#	Reconstructed via infocmp from file: /nix/store/znqms41g7lgxzxmgcvah7jvv5kcc51v0-ghostty-1.3.1/share/terminfo/./x/xterm-ghostty
xterm-ghostty|ghostty|Ghostty,
	am, bce, ccc, hs, km, mc5i, mir, msgr, npc, xenl, AX, Su, Tc, XT, fullkbd,
	colors#0x100, cols#80, it#8, lines#24, pairs#0x7fff,
	acsc=++\,\,--..00``aaffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~,
	bel=^G, blink=\E[5m, bold=\E[1m, cbt=\E[Z, civis=\E[?25l,
	clear=\E[H\E[2J, cnorm=\E[?12l\E[?25h, cr=\r,
	csr=\E[%i%p1%d;%p2%dr, cub=\E[%p1%dD, cub1=^H,
	cud=\E[%p1%dB, cud1=\n, cuf=\E[%p1%dC, cuf1=\E[C,
	cup=\E[%i%p1%d;%p2%dH, cuu=\E[%p1%dA, cuu1=\E[A,
	cvvis=\E[?12;25h, dch=\E[%p1%dP, dch1=\E[P, dim=\E[2m,
	dl=\E[%p1%dM, dl1=\E[M, dsl=\E]2;\007, ech=\E[%p1%dX,
	ed=\E[J, el=\E[K, el1=\E[1K, flash=\E[?5h$<100/>\E[?5l,
	fsl=^G, home=\E[H, hpa=\E[%i%p1%dG, ht=^I, hts=\EH,
	ich=\E[%p1%d@, ich1=\E[@, il=\E[%p1%dL, il1=\E[L, ind=\n,
	indn=\E[%p1%dS,
	initc=\E]4;%p1%d;rgb:%p2%{255}%*%{1000}%/%2.2X/%p3%{255}%*%{1000}%/%2.2X/%p4%{255}%*%{1000}%/%2.2X\E\\,
	invis=\E[8m, kDC=\E[3;2~, kEND=\E[1;2F, kHOM=\E[1;2H,
	kIC=\E[2;2~, kLFT=\E[1;2D, kNXT=\E[6;2~, kPRV=\E[5;2~,
	kRIT=\E[1;2C, kbs=^?, kcbt=\E[Z, kcub1=\EOD, kcud1=\EOB,
	kcuf1=\EOC, kcuu1=\EOA, kdch1=\E[3~, kend=\EOF, kent=\EOM,
	kf1=\EOP, kf10=\E[21~, kf11=\E[23~, kf12=\E[24~,
	kf13=\E[1;2P, kf14=\E[1;2Q, kf15=\E[1;2R, kf16=\E[1;2S,
	kf17=\E[15;2~, kf18=\E[17;2~, kf19=\E[18;2~, kf2=\EOQ,
	kf20=\E[19;2~, kf21=\E[20;2~, kf22=\E[21;2~,
	kf23=\E[23;2~, kf24=\E[24;2~, kf25=\E[1;5P, kf26=\E[1;5Q,
	kf27=\E[1;5R, kf28=\E[1;5S, kf29=\E[15;5~, kf3=\EOR,
	kf30=\E[17;5~, kf31=\E[18;5~, kf32=\E[19;5~,
	kf33=\E[20;5~, kf34=\E[21;5~, kf35=\E[23;5~,
	kf36=\E[24;5~, kf37=\E[1;6P, kf38=\E[1;6Q, kf39=\E[1;6R,
	kf4=\EOS, kf40=\E[1;6S, kf41=\E[15;6~, kf42=\E[17;6~,
	kf43=\E[18;6~, kf44=\E[19;6~, kf45=\E[20;6~,
	kf46=\E[21;6~, kf47=\E[23;6~, kf48=\E[24;6~,
	kf49=\E[1;3P, kf5=\E[15~, kf50=\E[1;3Q, kf51=\E[1;3R,
	kf52=\E[1;3S, kf53=\E[15;3~, kf54=\E[17;3~,
	kf55=\E[18;3~, kf56=\E[19;3~, kf57=\E[20;3~,
	kf58=\E[21;3~, kf59=\E[23;3~, kf6=\E[17~, kf60=\E[24;3~,
	kf61=\E[1;4P, kf62=\E[1;4Q, kf63=\E[1;4R, kf7=\E[18~,
	kf8=\E[19~, kf9=\E[20~, khome=\EOH, kich1=\E[2~,
	kind=\E[1;2B, kmous=\E[<, knp=\E[6~, kpp=\E[5~,
	kri=\E[1;2A, oc=\E]104\007, op=\E[39;49m, rc=\E8,
	rep=%p1%c\E[%p2%{1}%-%db, rev=\E[7m, ri=\EM,
	rin=\E[%p1%dT, ritm=\E[23m, rmacs=\E(B, rmam=\E[?7l,
	rmcup=\E[?1049l, rmir=\E[4l, rmkx=\E[?1l\E>, rmso=\E[27m,
	rmul=\E[24m, rs1=\E]\E\\\Ec, sc=\E7,
	setab=\E[%?%p1%{8}%<%t4%p1%d%e%p1%{16}%<%t10%p1%{8}%-%d%e48;5;%p1%d%;m,
	setaf=\E[%?%p1%{8}%<%t3%p1%d%e%p1%{16}%<%t9%p1%{8}%-%d%e38;5;%p1%d%;m,
	sgr=%?%p9%t\E(0%e\E(B%;\E[0%?%p6%t;1%;%?%p5%t;2%;%?%p2%t;4%;%?%p1%p3%|%t;7%;%?%p4%t;5%;%?%p7%t;8%;m,
	sgr0=\E(B\E[m, sitm=\E[3m, smacs=\E(0, smam=\E[?7h,
	smcup=\E[?1049h, smir=\E[4h, smkx=\E[?1h\E=, smso=\E[7m,
	smul=\E[4m, tbc=\E[3g, tsl=\E]2;, u6=\E[%i%d;%dR, u7=\E[6n,
	u8=\E[?%[;0123456789]c, u9=\E[c, vpa=\E[%i%p1%dd,
	BD=\E[?2004l, BE=\E[?2004h, Clmg=\E[s,
	Cmg=\E[%i%p1%d;%p2%ds, Dsmg=\E[?69l, E3=\E[3J,
	Enmg=\E[?69h, Ms=\E]52;%p1%s;%p2%s\007, PE=\E[201~,
	PS=\E[200~, RV=\E[>c, Se=\E[2 q,
	Setulc=\E[58:2::%p1%{65536}%/%d:%p1%{256}%/%{255}%&%d:%p1%{255}%&%d%;m,
	Smulx=\E[4:%p1%dm, Ss=\E[%p1%d q,
	Sync=\E[?2026%?%p1%{1}%-%tl%eh%;,
	XM=\E[?1006;1000%?%p1%{1}%=%th%el%;, XR=\E[>0q,
	fd=\E[?1004l, fe=\E[?1004h, kDC3=\E[3;3~, kDC4=\E[3;4~,
	kDC5=\E[3;5~, kDC6=\E[3;6~, kDC7=\E[3;7~, kDN=\E[1;2B,
	kDN3=\E[1;3B, kDN4=\E[1;4B, kDN5=\E[1;5B, kDN6=\E[1;6B,
	kDN7=\E[1;7B, kEND3=\E[1;3F, kEND4=\E[1;4F,
	kEND5=\E[1;5F, kEND6=\E[1;6F, kEND7=\E[1;7F,
	kHOM3=\E[1;3H, kHOM4=\E[1;4H, kHOM5=\E[1;5H,
	kHOM6=\E[1;6H, kHOM7=\E[1;7H, kIC3=\E[2;3~, kIC4=\E[2;4~,
	kIC5=\E[2;5~, kIC6=\E[2;6~, kIC7=\E[2;7~, kLFT3=\E[1;3D,
	kLFT4=\E[1;4D, kLFT5=\E[1;5D, kLFT6=\E[1;6D,
	kLFT7=\E[1;7D, kNXT3=\E[6;3~, kNXT4=\E[6;4~,
	kNXT5=\E[6;5~, kNXT6=\E[6;6~, kNXT7=\E[6;7~,
	kPRV3=\E[5;3~, kPRV4=\E[5;4~, kPRV5=\E[5;5~,
	kPRV6=\E[5;6~, kPRV7=\E[5;7~, kRIT3=\E[1;3C,
	kRIT4=\E[1;4C, kRIT5=\E[1;5C, kRIT6=\E[1;6C,
	kRIT7=\E[1;7C, kUP=\E[1;2A, kUP3=\E[1;3A, kUP4=\E[1;4A,
	kUP5=\E[1;5A, kUP6=\E[1;6A, kUP7=\E[1;7A, kxIN=\E[I,
	kxOUT=\E[O, rmxx=\E[29m, rv=\E\\[[0-9]+;[0-9]+;[0-9]+c,
	setrgbb=\E[48:2:%p1%d:%p2%d:%p3%dm,
	setrgbf=\E[38:2:%p1%d:%p2%d:%p3%dm, smxx=\E[9m,
	xm=\E[<%i%p3%d;%p1%d;%p2%d;%?%p4%tM%em%;,
	xr=\EP>\\|[ -~]+a\E\\,
TERMINFO
  infocmp -x xterm-ghostty >/dev/null
  fi
}

setup_git() {
  log "Configuring Git"
  git config --global user.name "Casey Link"
  git config --global user.email "casey@outskirtslabs.com"
}

setup_nix_devenv() {
  local destination="$HOME/.nix-devenv"

  if [[ -d "$destination/.git" ]]; then
    log "nix-devenv already cloned; skipping clone"
  elif [[ -e "$destination" ]]; then
    echo "$destination exists but is not a Git checkout; refusing to overwrite it." >&2
    return 1
  else
    log "Cloning nix-devenv"
    git clone https://github.com/ramblurr/nix-devenv.git "$destination"
  fi
}

install_pi_if_needed() {
  local npm_global_bin
  npm_global_bin="$(npm prefix -g)/bin"

  # The Sprite npm wrapper activates NVM only in its subprocess. Add npm's
  # global bin directory to this bootstrap process so a newly installed pi is
  # immediately available without starting a new shell.
  PATH="$npm_global_bin:$PATH"
  export PATH
  hash -r

  if command -v pi >/dev/null 2>&1; then
    log "pi already installed; skipping install"
  else
    log "Installing pi"
    npm install -g --ignore-scripts @earendil-works/pi-coding-agent
    hash -r
  fi

  log "Installing pi extensions"
  "$npm_global_bin/pi" install git:github.com/Ramblurr/pi-extensions
}

write_pi_config() {
  local pi_dir="$HOME/.pi/agent"
  local auth_file="$pi_dir/auth.json"
  local settings_file="$pi_dir/settings.json"
  local auth_tmp

  log "Writing pi auth.json"
  mkdir -p "$pi_dir"
  chmod 700 "$pi_dir"

  auth_tmp=$(mktemp "$pi_dir/.auth.json.tmp.XXXXXX")
  chmod 600 "$auth_tmp"

  if [[ -t 0 ]]; then
    if [[ ! -r /dev/tty || ! -w /dev/tty ]]; then
      rm -f "$auth_tmp"
      echo "Cannot read auth.json: this session has no usable terminal." >&2
      return 1
    fi

    printf '\nClick/focus this terminal, paste your multi-line auth.json,\nthen press Enter followed by Ctrl-D when done:\n' >/dev/tty
    if ! cat </dev/tty >"$auth_tmp"; then
      rm -f "$auth_tmp"
      echo "Failed to read auth.json from the terminal." >&2
      return 1
    fi
  else
    log "Reading pi auth.json from standard input"
    if ! cat >"$auth_tmp"; then
      rm -f "$auth_tmp"
      echo "Failed to read auth.json from standard input." >&2
      return 1
    fi
  fi

  if [[ ! -s "$auth_tmp" ]]; then
    rm -f "$auth_tmp"
    echo "No auth.json content was entered; refusing to write an empty file." >&2
    return 1
  fi

  if ! node -e 'JSON.parse(require("fs").readFileSync(process.argv[1], "utf8"))' "$auth_tmp"; then
    rm -f "$auth_tmp"
    echo "The pasted auth.json is not valid JSON; existing auth was left unchanged." >&2
    return 1
  fi

  mv -f "$auth_tmp" "$auth_file"
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
  "skills": [
    "/home/sprite/.nix-devenv/skills/pi",
    "/home/sprite/.nix-devenv/skills/mine",
    "/home/sprite/.nix-devenv/skills/engineering"
  ],
  "shellCommandPrefix": "eval \"$(DEVSHELL_NO_MOTD=1 direnv export bash 2>/dev/null)\""
}
JSON
  chmod 600 "$settings_file"
}

main() {
  install_nix_if_needed
  install_stuff
  setup_git
  setup_nix_devenv
  install_pi_if_needed
  write_pi_config
  log "Bootstrap complete"
}

main "$@"
