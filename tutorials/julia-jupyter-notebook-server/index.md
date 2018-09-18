# Julia Jupyter Notebook Server on Google Cloud Platform
This tutorial shows you how to run a secure [Jupyter Notebook server](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html) with a [Juila](https://julialang.org/) kernel installed on the Google Cloud Platform. It uses HashiCorp's [Terraform](https://www.terraform.io/) to acquire a [Let's Encrypt certificate](https://letsencrypt.org/), create a Google Compute Engine instance, and configure the necessary firewall rules and Cloud DNS entries for the server.

Julia is a relatively new language that has emerged from MIT to address the ["two-language problem"](https://www.quora.com/What-is-the-2-language-problem-in-data-science) in HPC, data science, ML and other compute intensive fields. The tagline "looks like Python, feels like Lisp, runs like C" sums up Julia's goals of being simultaneously addressing *productivity*, *generality*, and *performance* concerns in compute intensive problem domains. Jupyter notebooks are an increasingly common mechanism for collaboration around and delivery of scientific information processing solutions. While originally constructed around Python, Jupyter now supports the installation of additional "kernels", *e.g.* R, Scala, and Julia. While this tutorial is specifc to Julia it would be easy to modify to add a different kernel to the resulting notebook server.

## Objectives
* Create a secure Jupyter notebook server with a Juila kernel installed
* Demonstrate acquiring a Let's Encrypt certificate via Terraform
* Make it easy to provide valuable tooling to researchers and developers in compute intensive fields

## Before you begin

## Costs
## Configuration
## Terraforming
