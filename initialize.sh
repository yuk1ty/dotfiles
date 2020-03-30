# rust
curl https://sh.rustup.rs -sSf | sh

# java
dir=~/.jenv/versions; [ ! -e $dir ] && mkdir -p $dir
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-14.jdk/Contents/Home/