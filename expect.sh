#!/usr/bin/expect -f

set timeout 300

# Update and upgrade system
spawn sudo apt-get update
expect eof

# Install necessary virtualization packages
spawn sudo apt-get install -y qemu-kvm libvirt-daemon-system virt-manager bridge-utils cloud-image-utils docker.io
expect eof
