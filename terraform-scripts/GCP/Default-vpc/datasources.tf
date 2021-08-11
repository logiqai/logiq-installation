data "google_iam_policy" "sa-policy"{
    binding {
        role="roles/iam.serviceAccountUser"
        members=[
            "serviceAccount: ${google_service_account.service_account.email}",
        ]
    }

    binding {
        role = "roles/storage.admin"
        members=[
            "serviceAccount: ${google_service_account.service_account.email}"
        ]
    }

    binding {
      role="roles/compute.instanceAdmin.v1"
      members=[
          "serviceAccount: ${google_service_account.service_account.email}"
      ]
    }

}