## Best practices

-

## Docker

- Initial apply

```bash
➜ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "my_tf_created_docker_container"
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + ports {
          + external = 8000
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id           = (known after apply)
      + image_id     = (known after apply)
      + keep_locally = false
      + name         = "nginx"
      + repo_digest  = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_image.nginx: Creating...
docker_image.nginx: Still creating... [10s elapsed]
docker_image.nginx: Creation complete after 13s [id=sha256:2a4fbb36e96607b16e5af2e24dc6a1025a4795520c98c6b9ead9c4113617cb73nginx]
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 0s [id=10a4a6e6881bd8ce7947a681302b541345f7ae19c6f7601b95040c75fde13159]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

- State

```bash
➜ terraform state list
docker_container.nginx
docker_image.nginx
```

```bash
➜ terraform state show docker_container.nginx
# docker_container.nginx:
resource "docker_container" "nginx" {
    attach                                      = false
    command                                     = [
        "nginx",
        "-g",
        "daemon off;",
    ]
    container_read_refresh_timeout_milliseconds = 15000
    cpu_shares                                  = 0
    entrypoint                                  = [
        "/docker-entrypoint.sh",
    ]
    env                                         = []
    hostname                                    = "9e04af3bd3a0"
    id                                          = "9e04af3bd3a0567ecba2147c2b74bcf3912e086a123bf759467fd623c5b73409"
    image                                       = "sha256:2a4fbb36e96607b16e5af2e24dc6a1025a4795520c98c6b9ead9c4113617cb73"
    init                                        = false
    ipc_mode                                    = "private"
    log_driver                                  = "json-file"
    logs                                        = false
    max_retry_count                             = 0
    memory                                      = 0
    memory_swap                                 = 0
    must_run                                    = true
    name                                        = "my_tf_created_docker_container"
    network_data                                = [
        {
            gateway                   = "172.17.0.1"
            global_ipv6_address       = ""
            global_ipv6_prefix_length = 0
            ip_address                = "172.17.0.3"
            ip_prefix_length          = 16
            ipv6_gateway              = ""
            mac_address               = "02:42:ac:11:00:03"
            network_name              = "bridge"
        },
    ]
    network_mode                                = "default"
    privileged                                  = false
    publish_all_ports                           = false
    read_only                                   = false
    remove_volumes                              = true
    restart                                     = "no"
    rm                                          = false
    runtime                                     = "runc"
    security_opts                               = []
    shm_size                                    = 64
    start                                       = true
    stdin_open                                  = false
    stop_signal                                 = "SIGQUIT"
    stop_timeout                                = 0
    tty                                         = false
    wait                                        = false
    wait_timeout                                = 60

    ports {
        external = 8000
        internal = 80
        ip       = "0.0.0.0"
        protocol = "tcp"
    }
}

core-course-labs/terraform/docker on  lab4 [$?] via 💠 default
➜ terraform state show docker_image.nginx
# docker_image.nginx:
resource "docker_image" "nginx" {
    id           = "sha256:2a4fbb36e96607b16e5af2e24dc6a1025a4795520c98c6b9ead9c4113617cb73nginx"
    image_id     = "sha256:2a4fbb36e96607b16e5af2e24dc6a1025a4795520c98c6b9ead9c4113617cb73"
    keep_locally = false
    name         = "nginx"
    repo_digest  = "nginx@sha256:32da30332506740a2f7c34d5dc70467b7f14ec67d912703568daff790ab3f755"
}
```

- Name change

```bash
➜ TF_VAR_nginx_container_name=name_from_env terraform apply
docker_image.nginx: Refreshing state... [id=sha256:2a4fbb36e96607b16e5af2e24dc6a1025a4795520c98c6b9ead9c4113617cb73nginx]
docker_container.nginx: Refreshing state... [id=10a4a6e6881bd8ce7947a681302b541345f7ae19c6f7601b95040c75fde13159]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # docker_container.nginx must be replaced
-/+ resource "docker_container" "nginx" {
      + bridge                                      = (known after apply)
      ~ command                                     = [
          - "nginx",
          - "-g",
          - "daemon off;",
        ] -> (known after apply)
      + container_logs                              = (known after apply)
      - cpu_shares                                  = 0 -> null
      - dns                                         = [] -> null
      - dns_opts                                    = [] -> null
      - dns_search                                  = [] -> null
      ~ entrypoint                                  = [
          - "/docker-entrypoint.sh",
        ] -> (known after apply)
      ~ env                                         = [] -> (known after apply)
      + exit_code                                   = (known after apply)
      - group_add                                   = [] -> null
      ~ hostname                                    = "10a4a6e6881b" -> (known after apply)
      ~ id                                          = "10a4a6e6881bd8ce7947a681302b541345f7ae19c6f7601b95040c75fde13159" -> (known after apply)
      ~ init                                        = false -> (known after apply)
      ~ ipc_mode                                    = "private" -> (known after apply)
      ~ log_driver                                  = "json-file" -> (known after apply)
      - log_opts                                    = {} -> null
      - max_retry_count                             = 0 -> null
      - memory                                      = 0 -> null
      - memory_swap                                 = 0 -> null
      ~ name                                        = "my_tf_created_docker_container" -> "name_from_env" # forces replacement
      ~ network_data                                = [
          - {
              - gateway                   = "172.17.0.1"
              - global_ipv6_address       = ""
              - global_ipv6_prefix_length = 0
              - ip_address                = "172.17.0.3"
              - ip_prefix_length          = 16
              - ipv6_gateway              = ""
              - mac_address               = "02:42:ac:11:00:03"
              - network_name              = "bridge"
            },
        ] -> (known after apply)
      - network_mode                                = "default" -> null
      - privileged                                  = false -> null
      - publish_all_ports                           = false -> null
      ~ runtime                                     = "runc" -> (known after apply)
      ~ security_opts                               = [] -> (known after apply)
      ~ shm_size                                    = 64 -> (known after apply)
      ~ stop_signal                                 = "SIGQUIT" -> (known after apply)
      ~ stop_timeout                                = 0 -> (known after apply)
      - storage_opts                                = {} -> null
      - sysctls                                     = {} -> null
      - tmpfs                                       = {} -> null
        # (14 unchanged attributes hidden)

        # (1 unchanged block hidden)
    }

Plan: 1 to add, 0 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_container.nginx: Destroying... [id=10a4a6e6881bd8ce7947a681302b541345f7ae19c6f7601b95040c75fde13159]
docker_container.nginx: Destruction complete after 0s
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 0s [id=9e04af3bd3a0567ecba2147c2b74bcf3912e086a123bf759467fd623c5b73409]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
```

## Infrastructure using VK Cloud

- State

```bash
➜ terraform state list
data.vkcs_compute_flavor.compute
data.vkcs_images_image.compute
data.vkcs_networking_network.extnet
vkcs_compute_floatingip_associate.fip
vkcs_compute_instance.compute
vkcs_networking_floatingip.fip
vkcs_networking_network.network
vkcs_networking_port.port
vkcs_networking_port_secgroup_associate.port
vkcs_networking_router.router
vkcs_networking_router_interface.db
vkcs_networking_secgroup.secgroup
vkcs_networking_secgroup_rule.secgroup_rule_1
vkcs_networking_secgroup_rule.secgroup_rule_2
vkcs_networking_subnet.subnetwork
```

```bash
➜ terraform state show data.vkcs_compute_flavor.compute
# data.vkcs_compute_flavor.compute:
data "vkcs_compute_flavor" "compute" {
    disk         = 20
    extra_specs  = {
        "agg_common"     = "true"
        "hw:cpu_sockets" = "1"
        "mcs:cpu_type"   = "standard"
    }
    flavor_id    = "25ae869c-be29-4840-8e12-99e046d2dbd4"
    id           = "25ae869c-be29-4840-8e12-99e046d2dbd4"
    is_public    = true
    name         = "Basic-1-2-20"
    ram          = 2048
    rx_tx_factor = 1
    swap         = 0
    vcpus        = 1
}
```

```bash
➜ terraform state show vkcs_compute_instance.compute
# vkcs_compute_instance.compute:
resource "vkcs_compute_instance" "compute" {
    access_ip_v4        = "192.168.199.4"
    all_metadata        = {}
    all_tags            = []
    availability_zone   = "MS1"
    flavor_id           = "25ae869c-be29-4840-8e12-99e046d2dbd4"
    flavor_name         = "Basic-1-2-20"
    force_delete        = false
    id                  = "f781d4ad-d373-4dfc-940b-5a3f0a78a1e4"
    image_id            = "Attempt to boot from volume - no image supplied"
    key_pair            = "devops-terraform"
    name                = "compute-instance"
    power_state         = "active"
    region              = "RegionOne"
    security_groups     = [
        "84c95f79-222a-466b-ba4b-f60e26af5f93",
        "default",
    ]
    stop_before_destroy = false

    block_device {
        boot_index            = 0
        delete_on_termination = true
        destination_type      = "volume"
        source_type           = "image"
        uuid                  = "b75595ca-4e1d-47e0-8e95-7a02edc0e242"
        volume_size           = 8
        volume_type           = "ceph-ssd"
    }

    network {
        access_network = false
        fixed_ip_v4    = "192.168.199.4"
        mac            = "fa:16:3e:e7:94:09"
        name           = "net"
        uuid           = "d7fd680d-5b9c-4faa-918e-2cfaa201d1b8"
    }
}
```

- Output

```bash
➜ terraform output
instance_fip = "95.163.208.68"
```

## Github

- State

```bash
➜ terraform state list
github_branch_default.main
github_branch_protection.default
github_repository.core-course-labs
```

```bash
➜ terraform state show github_repository.core-course-labs
# github_repository.core-course-labs:
resource "github_repository" "core-course-labs" {
    allow_auto_merge            = false
    allow_merge_commit          = true
    allow_rebase_merge          = true
    allow_squash_merge          = true
    archived                    = false
    auto_init                   = false
    branches                    = [
        {
            name      = "lab1"
            protected = false
        },
        {
            name      = "lab2"
            protected = false
        },
        {
            name      = "lab3"
            protected = false
        },
        {
            name      = "lab4"
            protected = false
        },
        {
            name      = "main"
            protected = false
        },
    ]
    default_branch              = "main"
    delete_branch_on_merge      = false
    etag                        = "W/\"8dffef980459d0d49d60b40c49054e5e8df5ca27bed8b0b6faeadde309699f68\""
    full_name                   = "sl1depengwyn/core-course-labs"
    git_clone_url               = "git://github.com/sl1depengwyn/core-course-labs.git"
    has_downloads               = true
    has_issues                  = false
    has_projects                = true
    has_wiki                    = true
    html_url                    = "https://github.com/sl1depengwyn/core-course-labs"
    http_clone_url              = "https://github.com/sl1depengwyn/core-course-labs.git"
    id                          = "core-course-labs"
    is_template                 = false
    merge_commit_message        = "PR_TITLE"
    merge_commit_title          = "MERGE_MESSAGE"
    name                        = "core-course-labs"
    node_id                     = "R_kgDOKP1GRQ"
    private                     = false
    repo_id                     = 687687237
    squash_merge_commit_message = "COMMIT_MESSAGES"
    squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
    ssh_clone_url               = "git@github.com:sl1depengwyn/core-course-labs.git"
    svn_url                     = "https://github.com/sl1depengwyn/core-course-labs"
    topics                      = []
    visibility                  = "public"
    vulnerability_alerts        = false
}
```

## Github Teams

- State

```bash
➜ terraform state list
github_branch_default.main
github_repository.devops-lab4-teams
github_team.dev
github_team.devops
github_team_repository.dev_devops-lab4-teams
github_team_repository.devops_devops-lab4-teams
```

```bash
➜ terraform state show github_team_repository.dev_devops-lab4-teams
# github_team_repository.dev_devops-lab4-teams:
resource "github_team_repository" "dev_devops-lab4-teams" {
    etag       = "W/\"09273d3735e015fd736166efb7cffff969161c811e6a096737c4b98a2ca73a61\""
    id         = "8651062:devops-lab4-teams"
    permission = "push"
    repository = "devops-lab4-teams"
    team_id    = "8651062"
}
```

```bash
➜ terraform state show github_team_repository.devops_devops-lab4-teams
# github_team_repository.devops_devops-lab4-teams:
resource "github_team_repository" "devops_devops-lab4-teams" {
    etag       = "W/\"392124e853bd7bdaedf5c48889d8cfe41d0d0653d936a9ee52b23ddaef80d23e\""
    id         = "8651061:devops-lab4-teams"
    permission = "maintain"
    repository = "devops-lab4-teams"
    team_id    = "8651061"
}
```
