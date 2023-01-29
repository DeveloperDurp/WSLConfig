# WSL Ansible

Ansible playbook to install some default apps

# Supported Distros

- Ubuntu 22.04 LTS

# How to use

- Install Ubuntu WSL
- Run through initial config of ubuntu
- Install Ansible
- run git clone https://github.com/DeveloperDurp/WSLConfig.git
- Run the following command inside the new folder 
    - ansible-playbook main.yml -K

# How to add programs to install list

inside the variables folder open the distro you wish to modify and then add your application under required_packages. If it requires a repo you can add the key and repo url in the section below.
