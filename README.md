# dotfiles

yuk1ty's dotfiles, managed with [chezmoi](https://www.chezmoi.io/) + [Nix](https://nixos.org/) (nix-darwin + home-manager).

## Prerequisites

- Nix (installed via [Determinate Nix](https://determinate.systems/posts/determinate-nix/)):

```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

- chezmoi. If you're using macOS, hit the following command:

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yuk1ty
```

- Or using other OS, visit this site for more details: https://www.chezmoi.io/install/

## Set up GitHub access

Firstly, generate a new SSH key ([Guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)):

```
ssh-keygen -t ed25519 -f ~/.ssh/<filename>
```

Next, I should register the key to GitHub and my machine ([Guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)):

Copy the pub key for pasting GitHub page:

```
pbcopy < ~/.ssh/<filename>.pub
```

And add the key to my machine

```
ssh-add ~/.ssh/<filename>
ssh-add -l
<show the list>
```

Finally, check if it works:

```
ssh -T git@github.com
```

## Spinning up my environment

First `chezmoi init`.

```
chezmoi init git@github.com:yuk1ty/dotfiles.git
```

Apply my settings.

```
chezmoi apply
```

`chezmoi apply` also runs the `run_once_*` scripts, which do the rest of the setup:

- Install rustup and Xcode Command Line Tools
- Build and switch the nix-darwin system (see below)
- Install mise-managed toolchains
- Install `gh` extensions

## How my environment is managed by Nix

The Nix configuration lives in [`nix/`](./nix) as a flake:

| What | Where |
| --- | --- |
| Per-machine username & config name (`work` / `private`) | `nix/flake.nix` (`darwinConfigurations`, `mkMac` factory) |
| CLI tools (bat, fzf, neovim, mise, starship, ...) | `nix/home/default.nix` (home-manager) |
| Global runtimes (Java 21, Go, Node LTS, Python, Gleam) & cargo plugins | `nix/home/default.nix` (home-manager) |
| GUI apps & tools not in nixpkgs (casks, aerospace, sketchybar, ...) | `nix/darwin/default.nix` (`homebrew` module) |
| macOS system settings (Dock, Finder, keyboard, ...) | `nix/darwin/default.nix` (`system.defaults`) |
| Dotfiles themselves | This repository (chezmoi) |

### mise: project-specific tool versions only

[mise](https://mise.jdx.dev/) is kept for **per-project tool version switching** (e.g. Java 21.0.2 in a repo, pinned Node versions in frontend repos). Global tools and runtimes are managed by Nix; `~/.config/mise/config.toml` intentionally has no `[tools]` section. Since `mise activate` takes precedence over the Nix profile in PATH, project settings win over the Nix-installed global versions.

`headroom-ai` (not in nixpkgs) is packaged with [uv2nix](https://github.com/pyproject-nix/uv2nix) from the lock file in [`nix/packages/headroom/`](./nix/packages/headroom). To upgrade it:

```
cd ~/.local/share/chezmoi/nix/packages/headroom
uv lock --upgrade
# then darwin-rebuild switch (see "Updating the system")
```

A few things are intentionally kept outside of Nix:

- macOS settings that nix-darwin cannot manage (DNS servers, etc.) live in `run_once_setup-mac.sh.tmpl`
- Self-updating version managers (ghcup) stay on Homebrew

Note: Homebrew itself is managed by nix-darwin, so there is no `Brewfile` to run `brew bundle` with anymore.

### Updating the system

After changing the Nix configuration (or updating dependencies), apply it with:

```
sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/.local/share/chezmoi/nix#work
```

Use `#private` on the private machine (`/Users/helloyuki`). To update nixpkgs and other flake inputs:

```
cd ~/.local/share/chezmoi/nix
nix flake update
sudo /run/current-system/sw/bin/darwin-rebuild switch --flake .#work
```

## Install tpm and tmux theme

In this repository, I use `tpm` to set up the colour and visual theme of tmux. Reloading `.tmux.conf` automatically every time you run `chezmoi apply` with some changes, but sometimes it doesn't update the configuration correctly.

You might find an error with `signal 9` when you source `.tmux.conf`. In this case, you need to rerun tmux server with `(tmux) kill-server` and press `<prefix> + I` command. `<prefix>` is `Ctrl + t` in this repo.
