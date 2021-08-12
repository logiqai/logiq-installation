# Ansible playbook for installing LOGIQ on Ubuntu using MicroK8s

This repository contains the Ansible playbook that helps you install LOGIQ on Ubuntu using MicroK8s. This playbook will help you deploy LOGIQ faster on your Ubuntu machines than the traditional way of using Helm charts.  

## Prerequisites

In order to use this playbook, you'll need:

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Ensure that no application is running on port 80. To check this, run the following command to find and kill the application running on port 80. 
  
  ```
  netstat -tnlp|grep :80
  ```

## Installing LOGIQ

To install LOGIQ using this playbook, do the following.

1. Clone this repository. 
2. Download the `values.microk8s.yaml` file from this [values.microk8s.yaml](https://github.com/logiqai/logiq-installation/blob/main/values/values.microk8s.yaml).
3. In the `values.microk8s.yaml` file, add the below fields global-> environment section with your own values. 
   - `s3_bucket`: `<your-s3-bucket>`
   - `AWS_ACCESS_KEY_ID`: `<your-aws-access-key-id>`
   - `AWS_SECRET_ACCESS_KEY`: `<your-aws-secret-access-key-id>`
   
   In the global -> chart section, change S3gateway to false.
   - `s3gateway`: `false`
  
4. Run the following command.
    ```
    ansible-playbook logiq-playbook.yaml
    ```
5. Once the Ansible script has been executed, find your IP by running the following command. 
    ```
    ifconfig
    ```
6. Navigate to `http://<your-ip>/` or `http://localhost` to access the LOGIQ UI. 


![image](https://user-images.githubusercontent.com/67860971/129042112-8748275a-697e-4faa-9db1-cb515bb6ec6c.png)

Your LOGIQ deployment is now ready for use! You can log into your LOGIQ instance using the following default credentials.

- Username: `flash-admin@foo.com`
- Password: `flash-password`

You can change these crednetials from the Admin panel on the LOGIQ UI after you log in. You can also override the default credentials before installation by editing the `admin_name` and `admin_password` fields in the `values-microk8s.yaml` file. 

