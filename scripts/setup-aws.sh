#!/bin/zsh

set -e

printf "🚀 Start to set up to access AWS!\n"

printf "\e[38;5;245m"
saml2aws login -a conv-dev
printf "\e[m"

printf "\e[31m"
printf "🙋🏻‍♀️ saml authorisation done!\n"
printf "\e[m"

printf "\e[38;5;245m"
cd /Users/a14926/github/yytyd/dynalyst-mgmt-fw-tool/bin
./dynalyst-mgmt-fw-tool allow-my-ip
printf "\e[m"

printf "\e[31m"
printf "🙋🏻‍♀️ My IP address is authorised!\n"
printf "\e[m"
