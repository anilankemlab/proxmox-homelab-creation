# Proxmox Homelab Creation

This project uses Terraform to create and manage Proxmox virtual machines using a GitHub Actions workflow.

## Usage

To use this project, you need to have a Proxmox server and a GitHub repository.

1.  **Clone this repository**

2.  **Create the following secrets in your GitHub repository:**
    *   `PROXMOX_API_URL`: The URL of the Proxmox API (e.g., `https://proxmox.example.com:8006/api2/json`).
    *   `PROXMOX_TOKEN_ID`: The ID of the Proxmox API token.
    *   `PROXMOX_TOKEN_SECRET`: The secret of the Proxmox API token.

3.  **Run the `Proxmox VM create/destroy` workflow:**
    *   Go to the "Actions" tab of your GitHub repository.
    *   Select the `Proxmox VM create/destroy` workflow.
    *   Click on the "Run workflow" button.
    *   Select the action you want to perform (`create` or `destroy`).
    *   Fill in the required input parameters.
    *   Click on the "Run workflow" button.

## Terraform Variables

The following Terraform variables can be customized:

| Variable | Description | Default |
| --- | --- | --- |
| `proxmox_api_url` | The URL of the Proxmox API. | |
| `proxmox_token_id` | The ID of the Proxmox API token. | |
| `proxmox_token_secret` | The secret of the Proxmox API token. | |
| `node_name` | The name of the Proxmox node. | `proxmox` |
| `vm_name` | The name of the virtual machine. | |
| `template_name` | The name of the template to clone. | |
| `vm_memory_mb` | The amount of RAM in MB. | `2048` |
| `disk_size_gb` | The size of the disk in GB. | `20` |

**Note:** The `proxmox_api_url`, `proxmox_token_id`, and `proxmox_token_secret` variables are set using GitHub secrets.
