#!/usr/bin/expect -f

# Set a reasonable timeout
set timeout 300

# Start the update process
spawn sudo apt-get update && sudo apt-get upgrade -y -o Dpkg::Options::="--force-confold" --force-confdef --allow-downgrades --allow-remove-essential --allow-change-held-packages

# Handle potential prompt about sshd_config
expect {
    "What do you want to do about modified configuration file sshd_config?" {
        send "2\r"
        exp_continue  # Continue expecting other interactions if needed
    }
    eof {
        # Catch end of file, which means the spawn command finished
    }
}

# Start the installation of necessary packages
spawn sudo apt-get install -y -o Dpkg::Options::="--force-confold" --force-confdef --allow-downgrades --allow-remove-essential --allow-change-held-packages qemu-kvm libvirt-daemon-system virt-manager bridge-utils cloud-image-utils docker.io
expect eof
