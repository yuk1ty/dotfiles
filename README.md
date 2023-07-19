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

## Install apps via homebrew

I'm using `Brewfile` to manage what apps will be installed. Run the following command:

```
brew bundle
```
