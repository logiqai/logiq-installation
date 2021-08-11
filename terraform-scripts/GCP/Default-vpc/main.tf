
resource "google_service_account" "service_account" {
        account_id = "logiq-terraform"
        display_name = "logiq-terraform"
        description = "Logiqai account for test"
}

resource "google_storage_bucket" "logiq-test-poc"{
    name=var.bucket

}


resource "google_storage_hmac_key" "terraform_key" {
        service_account_email = google_service_account.service_account.email
}

resource "google_compute_firewall" "logiq-firewall" {
    name="logiq-firewall"
    network = "default"
   allow {
    protocol = "tcp"
    ports    = ["80", "514", "24224","24225","20514","9998","9999","8081","443","3000","514","7514","2514"]
  }
   target_tags = ["terraform-test"]

}
 
 

resource "google_compute_instance" "vm_instance"{
        name="terraform-test"
        machine_type=var.machine
        tags=["terraform-test"]

    boot_disk{
        initialize_params{
            image="https://www.googleapis.com/compute/v1/projects/gcp-customer-3/global/images/logiqai--ubuntu-1804-bionic-v20210623-1625919457"
            size = 100
            type = "pd-ssd"
        }
    }
    metadata_startup_script =<<-EOF
            #! /bin/bash
            echo "starting up microk8s"
            sudo microk8s start
            echo "wow did microk8s startup, lets start helm deployment"
            sed -i s:\$AWS_S3_BUCKET:${google_storage_bucket.logiq-test-poc.name}:g /home/ubuntu/deploy.sh > /dev/null
            sed -i s:\$AWS_ACCESS_KEY:${google_storage_hmac_key.terraform_key.access_id}:g /home/ubuntu/deploy.sh > /dev/null
            sed -i s:\$AWS_SECRET_KEY:${google_storage_hmac_key.terraform_key.secret}:g /home/ubuntu/deploy.sh > /dev/null
            sed -i s/\$S3_REGION/us-central1-a/g /home/ubuntu/deploy.sh > /dev/null
            chmod +x /home/ubuntu/deploy.sh
            cat <<EOF1 >> /etc/systemd/system/logiq.service
            [Unit]
            Description=LOGIQ helm service
            [Service]
            Type=simple
            ExecStart=/usr/bin/sudo /home/ubuntu/deploy.sh
            [Install]
            WantedBy=multi-user.target
            EOF1
            systemctl enable logiq.service
            systemctl start logiq.service
            EOF

    network_interface{

        network="default"
        access_config{

        }
    }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [google_compute_instance.vm_instance]

  create_duration = "450s"
}




