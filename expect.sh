#!/usr/bin/expect -f

set timeout 300

# Update and upgrade system
spawn sudo apt-get update
expect eof

spawn sudo apt-get upgrade -y -o Dpkg::Options::="--force-confold" -o Dpkg::Options::="--force-confdef"
expect {
    "What do you want to do about modified configuration file sshd_config?" {
        send "2\r"
        exp_continue
    }
    eof {
        # Catch end of file, which means the command finished
    }
}

# Install necessary virtualization packages
spawn sudo apt-get install -y qemu-kvm libvirt-daemon-system virt-manager bridge-utils cloud-image-utils docker.io
expect eof
