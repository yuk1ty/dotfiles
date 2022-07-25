echo "Installing brew stuffs ..."
if [ "$(uname)" != "Darwin" ]; then
    echo "This machine is not macOS!"
    exit 1
fi

brew bundle --file ../Brewfile

echo "Installing Rust ..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Insalling Poetry..."
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
# place virtual env results in respective local directories
poetry config virtualenvs.in-project true
