# dotfiles

I keep my Mac clear by doing development in a Debian VM. The Mac has the apps I use every day. Language runtimes, databases, project dependencies and coding agents all live in the VM, which [Lima](https://lima-vm.io) builds from `vm.yaml`. When the VM gathers too much crud, I delete it and build a fresh one.

My SSH keys stay in 1Password on the Mac. Git in the VM uses them through 1Password's agent, forwarded into the VM, and programs there read other secrets through [keyhole](https://github.com/carldaws/keyhole).

The files are stowed in three packages:

- `common`: both machines (Neovim, ripgrep, starship, mise, aliases)
- `mac`: the Mac (zsh, Ghostty, Brewfile)
- `vm`: the Lima VM (zsh, Brewfile, mise tasks, Postgres helpers, AGENTS.md)

Files at the top level aren't stowed.

## Mac

On a new Mac, run `setup.zsh`. It installs Homebrew, stows `common` and `mac`, and runs `brew bundle --global`.

## VM

Install keyhole for each 1Password account before the VM first starts. Then:

```sh
limactl start --name=vm --timeout 30m ~/dotfiles/vm.yaml
limactl restart vm
infocmp -x xterm-ghostty | limactl shell vm tic -x -
```

The restart gives shells zsh. The last line teaches the VM about Ghostty. After that, `vm` opens a shell in the VM.

`vm.yaml` installs Homebrew, clones these dotfiles, stows `common` and `vm`, and runs `brew bundle --global`.

For Postgres, run once:

```sh
brew services start postgresql@18
createuser -s postgres
```

For Tailscale, run once and sign in:

```sh
sudo --preserve-env=HOME "$(command -v brew)" services start tailscale
sudo "$(command -v tailscale)" up --operator=$USER --hostname=carls-vm
```

Before deleting the VM, sign it out of Tailscale so it leaves the device list:

```sh
limactl shell --shell /usr/bin/zsh vm tailscale logout
limactl delete vm
```
