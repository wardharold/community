# Julia Jupyter Notebook Server on Google Cloud Platform
This tutorial shows you how to run a secure [Jupyter Notebook server](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html) with a [Juila](https://julialang.org/) kernel installed on the Google Cloud Platform. It uses HashiCorp's [Terraform](https://www.terraform.io/) to acquire a [Let's Encrypt certificate](https://letsencrypt.org/), create a Google Compute Engine instance, and configure the necessary firewall rules and Cloud DNS entries for the server.

Julia is a relatively new language that has emerged from MIT to address the ["two-language problem"](https://www.quora.com/What-is-the-2-language-problem-in-data-science) in HPC, data science, ML and other compute intensive fields. The tagline "looks like Python, feels like Lisp, runs like C" sums up Julia's goals of being simultaneously addressing *productivity*, *generality*, and *performance* concerns in compute intensive problem domains. Jupyter notebooks are an increasingly common mechanism for collaboration around and delivery of scientific information processing solutions. While originally constructed around Python, Jupyter now supports the installation of additional "kernels", *e.g.* R, Scala, and Julia. While this tutorial is specifc to Julia it would be easy to modify to add a different kernel to the resulting notebook server.

## Objectives
* Create a secure Jupyter notebook server with a Juila kernel installed
* Demonstrate acquiring a Let's Encrypt certificate via Terraform
* Make it easy to provide Julia enabled notebooks to researchers and developers in compute intensive fields

## Before you begin

## Costs
## Configure Terraform variables
The ```variables.tf``` file defines a collection of variables Terraform uses when creating a notebook server.

| Name | Default Value | Description |
| --- | --- | --- |
| acme_registration_email || Email address to be associated with the Let's Encrypt private key registration |
| manage_zone || The Cloud DNS Managed Zone that will contain the notebook server's DNS records |
| project || Name of the project that will contain the notebook server |
| servername || Name of the notebook server |
| acme_server_url | https://acme-staging-v02.api.letsencrypt.org/directory | URL for the Let's Encrypt ACME server |
| disk_size | 16 (Gigabytes) | Size of the notebook server boot disk |
| jupyter_server_port | 8089 | Port the notebook server will listen on |
| machine_type | n1-standard-2 | Notebook server machine type |
| network | default | The Google Cloud Platform network the notebook server will be attached to |
| region | us-central1 | The compute region the notebook server will run in |
| zone | us-central1-b | The compute zone the notebook server will run in |

You must provide values for all of the variables without default values: project, managed_zone, acme_registration_email, and servername.
Terraform will prompt you for required values or you can specify them in a ```terraform.tfvars``` file. For example
```terraform.tfvars
project = "my-julia-jupyter-notebook-server-project"
manage_zone = "ExampleDotCom"
servername = "my-julia-notebook-server"
acme_registration_email = "fred.c.dobbs@sierra.madre.net"
```

## Create a notebook server password
## Verify your configuration
## Create the notebook server
To create the notebook server type
```sh
terraform apply -auto-approve
```
