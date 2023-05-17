#!/bin/bash

# install Rust
install_rust() {
    echo "Starting to install Rust"
    curl https://sh.rustup.rs -sSf | sh
}

# install WebAssembly tools
install_webasm() {
    curl https://raw.githubusercontent.com/second-state/ssvmup/master/installer/init.sh -sSf | sh
    curl https://get.wasmer.io -sSfL | sh
}

# set paths and install multiple Java versions for jenv
install_java() {
    echo "Starting to install multiple java versions for jenv"
    dir=~/.jenv/versions
    [ ! -e $dir ] && mkdir -p $dir
    jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/
    jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/
    jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-14.jdk/Contents/Home/
}

# install package manager for Python and other tools
install_python() {
    echo "Starting to install Python tools"
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
}

# main script
select VAR in rust webasm java python all exit; do
    if [ -z $VAR ]; then
        echo "Please input a number aside word"
        break
    fi

    if [ $VAR = rust ]; then
        install_rust
        break
    elif [ $VAR = webasm ]; then
        install_webasm
        break
    elif [ $VAR = java ]; then
        install_java
        break
    elif [ $VAR = python ]; then
        install_python
        break
    elif [ $VAR = all ]; then
        install_rust
        install_webasm
        install_java
        install_python
        break
    elif [ $VAR = exit ]; then
        break
    else
        echo "Unknown choice"
        break
    fi
done

echo "Exit this shell"
