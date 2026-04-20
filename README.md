# dotfiles

yuk1ty's dotfiles.

## Prerequisites

- Using chezmoi. Please install it in advance.
- If you're using macOS, hit the following command.

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

## Install CLI tools via devbox (Nix)

CLI tools are managed globally by [devbox](https://www.jetify.com/devbox) (backed by Nix). The `chezmoi apply` hook installs devbox and syncs the global package set automatically. To re-sync manually:

```
devbox global install
```

The source of truth is `~/.local/share/devbox/global/default/devbox.json`, which is managed by chezmoi.

## Install GUI apps, fonts, and macOS-specific tools via Homebrew

GUI applications, fonts, and macOS-only / system-level tooling stay on Homebrew. Run:

```
brew bundle
```

### One-time cleanup after migrating to devbox

If you are migrating an existing machine from the old Homebrew-only setup, CLI tools that have been moved to devbox (`eza`, `ripgrep`, `neovim`, etc.) will still be installed via Homebrew. They won't break anything because devbox's PATH takes precedence, but they waste disk space and keep getting upgraded by `brew upgrade`.

Run the following **once** to uninstall any Homebrew formulae/casks that are no longer declared in the `Brewfile`:

```
brew bundle cleanup --global --force
```

This is intentionally not automated — run it only after you have verified that `devbox global install` succeeded and the devbox-provided tools are working as expected.

## Install tpm and tmux theme

In this repository, I use `tpm` to set up the colour and visual theme of tmux. Reloading `.tmux.conf` automatically every time you run `chezmoi apply` with some changes, but sometimes it doesn't update the configuration correctly.

You might find an error with `signal 9` when you source `.tmux.conf`. In this case, you need to rerun tmux server with `(tmux) kill-server` and press `<prefix> + I` command. `<prefix>` is `Ctrl + t` in this repo.
