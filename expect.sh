#!/usr/bin/expect -f

set timeout 300

# Update packages
spawn sudo apt-get update
expect eof

# Upgrade packages with appropriate options
spawn sudo apt-get upgrade -y -o Dpkg::Options::="--force-confold" -o Dpkg::Options::="--force-confdef"
expect {
    "What do you want to do about modified configuration file sshd_config?" {
        send "2\r"
        exp_continue  # Continue expecting other interactions if needed
    }
    timeout {
        puts "Failed to handle sshd_config prompt or command timed out."
        exit 1
    }
    eof {
        # Installation of updates completed
    }
}

# Install necessary virtualization packages
spawn sudo apt-get install -y qemu-kvm libvirt-daemon-system virt-manager bridge-utils cloud-image-utils docker.io
expect eof
