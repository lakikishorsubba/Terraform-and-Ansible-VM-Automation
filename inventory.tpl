[webservers]
%{~ for vm_name, vm_config in vms ~}
${vm_config.hostname} ansible_host=${vm_config.ip} ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/${vm_name}/virtualbox/private_key ansible_ssh_common_args='-o StrictHostKeyChecking=no'
%{~ endfor ~}

[webservers:vars]
ansible_python_interpreter=/usr/bin/python3