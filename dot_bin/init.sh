echo "Installing brew stuffs ..."
if ["$(uname)" != "Darwin"]; then
    echo "This machine is not macOS!"
    exit 1
fi

brew bundle

echo "Installing Rust ..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Add Java versions to jenv"
jenv add /opt/homebrew/Cellar/openjdk/18.0.1/libexec/openjdk.jdk/Contents/Home/
jenv add /opt/homebrew/Cellar/openjdk@17/17.0.3/libexec/openjdk.jdk/Contents/Home/
jenv add /opt/homebrew/Cellar/openjdk@11/11.0.15/libexec/openjdk.jdk/Contents/Home/
jenv global 18
