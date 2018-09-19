provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

provider "acme" {
  server_url = "${var.acme_server_url}"
}

data "google_dns_managed_zone" "notebooks" {
  name     = "${var.managed_zone}"
}

locals {
  dns_name = "${substr(data.google_dns_managed_zone.notebooks.dns_name, 0, length(data.google_dns_managed_zone.notebooks.dns_name)-1)}"
}

# Lets Encrypt snippet start
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = "${tls_private_key.private_key.private_key_pem}"
  email_address   = "${var.acme_registration_email}"
}

resource "acme_certificate" "certificate" {
  account_key_pem = "${acme_registration.reg.account_key_pem}"
  common_name     = "${var.servername}.${local.dns_name}"

  dns_challenge {
    provider = "gcloud"
    config {
      GCE_PROJECT = "${var.project}"
    }
  }
}
# Lets Encrypt snippet end

# Cloud DNS A record snippet start
resource "google_dns_record_set" "nbs" {
  name = "${var.servername}.${data.google_dns_managed_zone.notebooks.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = "${data.google_dns_managed_zone.notebooks.name}"

  rrdatas = ["${google_compute_instance.nbs.network_interface.0.access_config.0.assigned_nat_ip}"]
}
# Cloud DNS A record snippet end

# Compute instance snippet start
resource "google_compute_instance" "nbs" {
  name         = "${var.servername}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size  = "${var.disk_size}"
    }
  }

  network_interface {
    access_config = {}
    network       = "${var.network}"
  }

  metadata {
    startup-script = "${file("startup.sh")}"
  }

  metadata {
    le_cert = "${acme_certificate.certificate.certificate_pem}"
  }

  metadata {
    le_key = "${acme_certificate.certificate.private_key_pem}"
  }

  tags = ["jupyter-server-${var.servername}"]
}
# Compute instance snippet end

# Firewall snippet start
resource "google_compute_firewall" "jupyter-server" {
  name    = "allow-juypter-server-${var.servername}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["${var.jupyter_server_port}"]
  }

  target_tags = ["jupyter-server-${var.servername}"]
}
# Firewall snippet end
