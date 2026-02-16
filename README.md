# Proxmox Homelab Creation using Terraform and Ansible

This project provides a comprehensive solution for automating the creation and configuration of virtual machines in a Proxmox VE environment. It leverages Terraform for infrastructure provisioning and Ansible for initial system bootstrapping. The entire process is orchestrated through GitHub Actions for a streamlined, CI/CD-driven workflow.

## Architecture Diagram

```
+-------------------+      +----------------------+      +-----------------+
|                   |      |                      |      |                 |
|   GitHub Actions  |----->|  Terraform Cloud/CLI |----->|  Proxmox Server |
| (Workflows)       |      |                      |      | (VM Creation)   |
|                   |      +----------------------+      |                 |
+-------------------+             ^                      +-----------------+
        |                         |                              |
        | (Triggers)              | (Provisions)                 | (Ansible runs on)
        |                         |                              v
+-------------------+      +----------------------+      +-----------------+
|                   |      |                      |      |                 |
|   User Push/Click |----->|  Ansible Playbooks   |----->|   Provisioned   |
|                   |      | (Bootstrap.yml)      |      |   VMs           |
+-------------------+      +----------------------+      +-----------------+

```

## Features

-   **Automated VM Provisioning:** Use Terraform to create Proxmox VMs from templates.
-   **Configuration as Code:** Define your infrastructure in HCL (HashiCorp Configuration Language).
-   **Dynamic IP Configuration:** Supports both static IP and DHCP addressing for created VMs.
-   **Automated Bootstrapping:** An Ansible playbook installs essential packages on new VMs.
-   **CI/CD Integration:** GitHub Actions workflows to create and destroy VMs and Kubernetes clusters.
-   **Kubernetes Cluster Deployment:** A dedicated workflow to quickly spin up a multi-node Kubernetes cluster.

## Prerequisites

Before you begin, ensure you have the following:

-   A Proxmox VE server.
-   A VM template in Proxmox (e.g., Ubuntu 24.04 Cloud-Init).
-   A Proxmox API token and secret.
-   Terraform installed locally (for local execution).
-   Ansible installed locally (for local execution).
-   A GitHub repository with the secrets configured for the workflows.

### Required GitHub Secrets

-   `PROXMOX_API_URL`: The URL for your Proxmox API (e.g., `https://proxmox.example.com:8006/api2/json`).
-   `PROXMOX_API_TOKEN`: Your Proxmox API token.
-   `PROXMOX_HOST`: The hostname or IP of your Proxmox server.
-   `PROXMOX_SSH_KEY`: The private SSH key to connect to the Proxmox host.
-   `PROXMOX_SSH_USER`: The user for SSHing into the Proxmox host.

## How to Use

### Local Execution with Terraform

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/proxmox-homelab-creation.git
    cd proxmox-homelab-creation/proxmox/terraform
    ```

2.  **Configure your backend:**
    Update `backend.tf` if you are using a remote backend like Terraform Cloud.

3.  **Set your variables:**
    Create a `terraform.tfvars` file to provide values for the variables defined in `variables.tf`. At a minimum, you'll need `proxmox_api_url`, `vm_name`, etc.

4.  **Initialize and Apply:**
    ```bash
    terraform init
    terraform apply
    ```

### GitHub Actions Workflows

This project includes two main workflows in the `.github/workflows` directory:

#### 1. `proxmox-vm.yml`

This workflow allows you to create or destroy a single Proxmox VM.

-   **To Create a VM:**
    1.  Go to the "Actions" tab in your GitHub repository.
    2.  Select the "Proxmox VM create/destroy" workflow.
    3.  Click "Run workflow".
    4.  Choose `create` as the action and fill in the required parameters like `vm_name`, `template`, `ram_mb`, `disk_gb`, and an optional `ip_address`.
    5.  The workflow will provision the VM with Terraform and then run the Ansible bootstrap playbook.

-   **To Destroy a VM:**
    1.  Run the same workflow, but choose `destroy` as the action and provide the `vm_name`.

#### 2. `cluster.yml`

This workflow is designed to create or destroy a Kubernetes cluster with one master and two worker nodes.

-   **To Create the Cluster:**
    1.  Go to the "Actions" tab.
    2.  Select the "Kubernetes Cluster create/destroy" workflow.
    3.  Click "Run workflow" and choose the `create` action.
    4.  The workflow will run `terraform apply` for each node (master, worker1, worker2).

-   **To Destroy the Cluster:**
    1.  Run the same workflow, but choose the `destroy` action. This will safely stop and purge all cluster VMs.

## Ansible Bootstrap

The `proxmox/terraform/ansible/bootstrap.yml` playbook is automatically run by the `proxmox-vm.yml` workflow after a VM is created. Its primary function is to install a set of essential packages to make the new VM immediately useful.

### Installed Packages

The playbook installs the following tools:

-   `unzip`, `tar`
-   `dnsutils` (for `nslookup`)
-   `iputils-ping`
-   `traceroute`
-   `curl`, `wget`
-   `vim`
-   `net-tools`

It automatically detects the OS family (Debian/Ubuntu or RedHat-based) and uses the appropriate package manager (`apt` or `dnf`).
