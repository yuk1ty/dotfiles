echo "Installing brew stuffs ..."
brew bundle

echo "Installing Rust ..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
