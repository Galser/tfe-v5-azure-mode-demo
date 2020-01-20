# Tearraform init, full output

```bash
terraform init
Initializing modules...
Downloading hashicorp/terraform-enterprise/azurerm 0.1.1 for tfe_cluster...
- tfe_cluster in .terraform/modules/tfe_cluster
- tfe_cluster.cluster_lb in .terraform/modules/tfe_cluster/modules/cluster_lb
- tfe_cluster.common in .terraform/modules/tfe_cluster/modules/common
- tfe_cluster.configs in .terraform/modules/tfe_cluster/modules/configs
- tfe_cluster.primaries in .terraform/modules/tfe_cluster/modules/primaries
- tfe_cluster.secondaries in .terraform/modules/tfe_cluster/modules/secondaries

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "azurerm" (hashicorp/azurerm) 1.38.0...
- Downloading plugin for provider "random" (hashicorp/random) 2.2.1...
- Downloading plugin for provider "null" (hashicorp/null) 2.1.2...
- Downloading plugin for provider "tls" (hashicorp/tls) 2.1.1...
- Downloading plugin for provider "local" (hashicorp/local) 1.4.0...
- Downloading plugin for provider "template" (hashicorp/template) 2.1.2...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.local: version = "~> 1.4"
* provider.null: version = "~> 2.1"
* provider.random: version = "~> 2.2"
* provider.template: version = "~> 2.1"
* provider.tls: version = "~> 2.1"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
