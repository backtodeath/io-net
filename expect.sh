#!/usr/bin/expect -f

exp_internal 1  ;# Turn on expect internal debugging
set timeout 300

# Start the update process
spawn sudo apt-get update && sudo apt-get upgrade -y -o Dpkg::Options::="--force-confold" --force-confdef --allow-downgrades --allow-remove-essential --allow-change-held-packages
expect {
    "What do you want to do about modified configuration file sshd_config?" {
        send "2\r"
        exp_continue
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
spawn sudo apt-get install -y -o Dpkg::Options::="--force-confold" --force-confdef --allow-downgrades --allow-remove-essential --allow-change-held-packages qemu-kvm libvirt-daemon-system virt-manager bridge-utils cloud-image-utils docker.io
expect {
    timeout {
        puts "Installation of packages timed out or failed."
        exit 1
    }
    eof {
        puts "Installation of packages completed successfully."
    }
}
