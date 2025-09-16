#!/usr/bin/env bash

## Aliases
# AWS profile tools
echo alias awswho=\'aws sts get-caller-identity\' >> ~/.bashrc
echo alias awsls=\'aws configure list-profiles\' >> ~/.bashrc
# Alias for exa. Pairs with modern-shell-utils devcontainer feature
echo alias l=\'eza\' >> ~/.bashrc 
echo alias la=\'eza -a\' >> ~/.bashrc 
echo alias ll=\'eza -lahg\' >> ~/.bashrc 
echo alias ls=\'eza --color=auto\' >> ~/.bashrc
# Projen
echo alias pj=\'npx projen\' >> ~/.bashrc
# CDK cli via npx
echo alias cdk=\'npx cdk\' >> ~/.bashrc
echo alias cdkls=\'npx cdk ls\' >> ~/.bashrc
echo alias cdkdiff=\'npx cdk diff\' >> ~/.bashrc
# Custom SSM tools
echo alias ssmls=\'ec2-session --list\' >> ~/.bashrc
echo alias ssmrdp=\'aws ssm start-session --document-name AWS-StartPortForwardingSession --parameters "localPortNumber=3389,portNumber=3389"  --target\' >> ~/.bashrc
echo alias ssmx=\'aws ssm start-session --target\' >> ~/.bashrc

## Install AWS Session Manager plugin and aws-ssm-tools
# Session Manager plugin as .deb package
unarc="$(uname -m)"
if [ "$unarc" == "x86_64" ]; then
  cpu="ubuntu_64bit"
elif [ "$unarc" == "aarch64" ]; then
  cpu="ubuntu_arm64"
fi
if [ $cpu != "" ]; then
url="https://s3.amazonaws.com/session-manager-downloads/plugin/latest/$cpu/session-manager-plugin.deb"
echo "Downloading $url"
curl $url \
  -o session-manager-plugin.deb \
  && sudo dpkg -i ./session-manager-plugin.deb && rm -rf ./session-manager-plugin.deb
else
  echo "Unsupported os. Session Manager plugin not installed."
  break
fi

# Disney SSM Helpers
wget https://github.com/disneystreaming/ssm-helpers/releases/download/v1.2.0/ssm-helpers_1.2.0_linux_amd64.deb
dpkg -i ssm-helpers_1.2.0_linux_amd64.deb && rm -rf ssm-helpers_1.2.0_linux_amd64.deb
ssm --version
