Terraform script to deploy Logiq on GCP on default VPC.

This script will create the below resources on GCP default-vpc, you may charged for the resources created.
- Service account with access/ secret keys
- Bucket
- Instance with 8 VCPU/32GB
- SSD Disk 100GB 

In order to make resource requests against the GCP API, you need to authenticate. The preferred method of provisioning resources with Terraform is to use Google Cloud SDK or you can use Google Cloud service account with Terraform, follow the below steps.

Navigate to you GCP project
Go to IAM section and choose service account key page in cloud console as shown below
![image](https://user-images.githubusercontent.com/67860971/125415145-c326aebc-99b0-49e7-b32e-c827f1c2d66b.png)

Choose an existing account or create a new one.
Download the JSON key file
Move the file the Default-vpc folder.
You can also supply the key to Terraform using the environment variable as the below.
 ```
    export GOOGLE_APPLICATION_CREDENTIALS={{path}}
 ```
or
Another way to authenticate is to run the below command, if you already have gcloud installed. If you don't already have it, you can install it from here(https://cloud.google.com/sdk/docs/install).
```
    gcloud auth application-default login
```


Once you have authenticated, Follow the below steps.
- Variables.tf have the below parameters, which can be modified according to your project.
    - Zone (modify the zone where the stack will be deployed, by default it is set to us-central1-a)
    - bucket (Key in the unique bucket name where the logs will be stored)
    - project-id (Enter GCP Project-id which will be used)
    - region (Enter the GCP Region where the stack will be spun up, by default, set to us-central1)
    - machine (Machine configuration, minimum e2-standard-8 is required, you can modify this parameter if you need a bigger instance)
- Once the variables have been modified, please run the below commands.
  ```
     terraform init
  ```
- Run the below command, it will give a preview of the resources created.
  ``` 
     terraform plan 
  ```
- Run the below command, the resources will be created on GCP
  ```
     terraform apply --auto-approve
  ```
-  Once the terraform successfully creates the resources, the end point will be displayed in the outputs section.
```
Outputs:
access_key = <sensitive>
bucket_name = "logiq-test-poc"
logiq_endpoint = "X.X.X.X"
secret_key = <sensitive>
```
- Navigate to the logiq_endpoint link displayed in the outputs and you should be able to load Logiq.
![image](https://user-images.githubusercontent.com/67860971/125321249-1e4f3000-e35a-11eb-819b-3d55bce68624.png)

To bring the stack down, please run the below command.
```
terraform destroy
```
