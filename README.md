# tfe-v5-azure-mode-demo
TFE V5 Specific Azure module only demo

# Purpose 
This repository contains information and directiosn required to install TFE v5 in Azure ( https://www.terraform.io/docs/enterprise/install/cluster-azure.html ) with the usage of official modules from here : https://registry.terraform.io/modules/hashicorp/terraform-enterprise/azurerm/0.1.1


# Requirements
This repository assumes general knowledge about Terraform, if not, please get yourself accustomed first by going through [getting started guide for Terraform](https://learn.hashicorp.com/terraform?track=getting-started#getting-started). We also going to use Azure as our infrastructure provider

To learn more about the mentioned above tools and technologies -  please check section [Technologies near the end of the README](#technologies)


# How-to

## Prepare authentication credentials

## Deploy

## Test


# TODO 

- [ ] setup Azure account credentials, test
- [ ] gather all DNS / LB requiremetns, double-check
- [ ] try installation by manual
- [ ] update Readme

# DONE
- [ ] make initial readme.

# Technologies

1. **To download the content of this repository** you will need **git command-line tools**(recommended) or **Git UI Client**. To install official command-line Git tools please [find here instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for various operating systems.

2. **For managing infrastructure** we using Terraform - open-source infrastructure as a code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON. More you encouraged to [learn here](https://www.terraform.io).
    - Specifically, we going to use Terraform for creating infrastructure, and install Terraform Enterprise. TFE Overview: can be found here: https://www.terraform.io/docs/enterprise/index.html
    - Pre-Install checklist: https://www.terraform.io/docs/enterprise/before-installing/index.html

3. **This project for virtualization** uses **Azure** - Microsoft Azure is a cloud computing service created by Microsoft for building, testing, deploying, and managing applications and services through Microsoft-managed data centers. . You can read in details and create a free try-out account if you don't have one here :  [Microsoft Azure Start page](https://azure.microsoft.com/en-gb/free/)