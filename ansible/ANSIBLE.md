## `➜ ansible-playbook playbooks/dev/main.yml --diff` output

```bash
PLAY [Prepare docker] *************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************
ok: [vk-cloud]

TASK [docker : Ensure old versions of Docker are not installed.] ******************************************************
ok: [vk-cloud]

TASK [docker : Ensure dependencies are installed.] ********************************************************************
The following additional packages will be installed:
  python3-wheel
Recommended packages:
  build-essential python3-dev
The following NEW packages will be installed:
  python3-pip python3-wheel
0 upgraded, 2 newly installed, 0 to remove and 0 not upgraded.
changed: [vk-cloud]

TASK [docker : include_tasks] *****************************************************************************************
included: /Users/kitt/Study/DevOps/core-course-labs/ansible/roles/docker/tasks/install_docker.yml for vk-cloud

TASK [docker : Add Docker apt key.] ***********************************************************************************
changed: [vk-cloud]

TASK [docker : Add Docker repository.] ********************************************************************************
--- before: /dev/null
+++ after: /etc/apt/sources.list.d/docker.list
@@ -0,0 +1 @@
+deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/docker.asc] https://download.docker.com/linux/ubuntu jammy stable

changed: [vk-cloud]

TASK [docker : Install Docker packages.] ******************************************************************************
skipping: [vk-cloud]

TASK [docker : include_tasks] *****************************************************************************************
included: /Users/kitt/Study/DevOps/core-course-labs/ansible/roles/docker/tasks/install_compose.yml for vk-cloud

TASK [docker : Install docker-compose using pip.] *********************************************************************
changed: [vk-cloud]

PLAY RECAP ************************************************************************************************************
vk-cloud                   : ok=8    changed=4    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```

## `➜ ansible-inventory -i inventory/default.yml --list` output

```bash
{
    "_meta": {
        "hostvars": {
            "vk-cloud": {
                "ansible_host": "2##.###.##.##7",
                "ansible_ssh_private_key_file": "~/.ssh/key.pem",
                "ansible_user": "ubuntu"
            }
        }
    },
    "all": {
        "children": [
            "ungrouped"
        ]
    },
    "ungrouped": {
        "hosts": [
            "vk-cloud"
        ]
    }
}
```

# Dynamic inventory

I've implemented dynamic inventory using [terraform-inventory](https://github.com/adammck/terraform-inventory), this tool simply creates ansible inventory from terraform state. So, I create my infrastructure with terraform and then using its state to create ansible inventory.

Here is `➜ ansible-inventory --list` output:

```bash
    {
    "_meta": {
        "hostvars": {
            "1##.###.###.#8": {
                "ansible_host": "1##.###.###.#8",
                "ansible_ssh_private_key_file": "~/.ssh/devops-terraform.pem",
                "ansible_user": "ubuntu",
                "fixed_ip": "",
                "floating_ip": "1##.###.###.#8",
                "id": "1##.###.###.#8/273c63f0-8f63-474e-b080-a28182d9b3d8/",
                "instance_fip": "1##.###.###.#8",
                "instance_id": "273c63f0-8f63-474e-b080-a28182d9b3d8",
                "region": "RegionOne",
                "timeouts": "<error>",
                "wait_until_associated": "<error>"
            },
            "1##.###.###.#5": {
                "access_ip_v4": "1##.###.###.#5",
                "admin_pass": "<error>",
                "all_metadata.#": "0",
                "all_tags.#": "0",
                "ansible_host": "1##.###.###.#5",
                "availability_zone": "MS1",
                "block_device.#": "1",
                "block_device.0.boot_index": "<error>",
                "block_device.0.delete_on_termination": "<error>",
                "block_device.0.destination_type": "volume",
                "block_device.0.device_type": "",
                "block_device.0.disk_bus": "",
                "block_device.0.guest_format": "",
                "block_device.0.source_type": "image",
                "block_device.0.uuid": "b75595ca-4e1d-47e0-8e95-7a02edc0e242",
                "block_device.0.volume_size": "<error>",
                "block_device.0.volume_type": "ceph-ssd",
                "config_drive": "<error>",
                "flavor_id": "25ae869c-be29-4840-8e12-99e046d2dbd4",
                "flavor_name": "Basic-1-2-20",
                "force_delete": "<error>",
                "id": "273c63f0-8f63-474e-b080-a28182d9b3d8",
                "image_id": "Attempt to boot from volume - no image supplied",
                "image_name": "<error>",
                "instance_fip": "1##.###.###.#8",
                "key_pair": "devops-terraform",
                "metadata": "<error>",
                "name": "compute-instance",
                "network.#": "1",
                "network.0.access_network": "<error>",
                "network.0.fixed_ip_v4": "1##.###.###.#5",
                "network.0.mac": "fa:16:3e:64:ac:c0",
                "network.0.name": "net",
                "network.0.port": "",
                "network.0.uuid": "789679e8-56d1-4b1a-b2c9-915e34748f92",
                "network_mode": "<error>",
                "personality.#": "0",
                "power_state": "active",
                "region": "RegionOne",
                "scheduler_hints.#": "0",
                "security_groups.#": "2",
                "security_groups.0": "d9606041-6dbd-43fb-b20f-4b9c2cd0ad36",
                "security_groups.1": "default",
                "stop_before_destroy": "<error>",
                "tags": "<error>",
                "timeouts": "<error>",
                "user_data": "<error>",
                "vendor_options.#": "0"
            }
        }
    },
    "all": {
        "children": [
            "ungrouped",
            "vkc",
            "compute",
            "compute_0",
            "fip_0",
            "type_vkcs_compute_floatingip_associate",
            "type_vkcs_compute_instance"
        ]
    },
    "compute": {
        "hosts": [
            "1##.###.###.#5"
        ]
    },
    "compute_0": {
        "hosts": [
            "1##.###.###.#5"
        ]
    },
    "fip": {
        "hosts": [
            "1##.###.###.#8"
        ]
    },
    "fip_0": {
        "hosts": [
            "1##.###.###.#8"
        ]
    },
    "type_vkcs_compute_floatingip_associate": {
        "hosts": [
            "1##.###.###.#8"
        ]
    },
    "type_vkcs_compute_instance": {
        "hosts": [
            "1##.###.###.#5"
        ]
    },
    "vkc": {
        "children": [
            "fip"
        ]
    }
}
```
