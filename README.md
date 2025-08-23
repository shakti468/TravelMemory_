# MERN Application Deployment on AWS 

## 📌 Project Overview
This project is about deploying a **MERN (MongoDB, Express, React, Node.js) stack application** on AWS using **Infrastructure as Code (Terraform)**, **Configuration Management (Ansible)**, and **Monitoring tools (Prometheus + Grafana)**.

Currently, Phase 1 has been completed, which focuses on **Infrastructure Provisioning using Terraform**.

---

## ✅ Phase 1: Infrastructure Provisioning with Terraform

### Steps Performed
1. **Installed Required Tools**
   - AWS CLI
   - Terraform (latest version)

2. **Configured AWS CLI**
   ```bash
   aws configure
   ```
   Entered AWS credentials and set default region as `ap-south-1`.

3. **Created Terraform Project Structure**
   ```
   terraform-mern/
   ├── backend.tf
   ├── provider.tf
   ├── variables.tf
   ├── main.tf
   ├── outputs.tf
   ```

4. **Configured Terraform Backend**
   - Stored Terraform state in an **S3 bucket** (created manually).
   - `backend.tf` contains:
     ```hcl
     terraform {
       backend "s3" {
         bucket = "<YOUR_S3_BUCKET_NAME>"   # Replace with your bucket name
         key    = "terraform/state.tfstate"
         region = "ap-south-1"
       }
     }
     ```

5. **Provider Configuration**
   - Defined AWS provider in `provider.tf`.

6. **Variables**
   - Created placeholders for:
     - **AMI ID**
     - **Subnet ID**
     - **VPN ID**
     - **S3 Bucket Name**
   ```hcl
   variable "ami_id" {
     default = "<YOUR_AMI_ID>"
   }
   variable "subnet_id" {
     default = "<YOUR_SUBNET_ID>"
   }
   variable "vpn_id" {
     default = "<YOUR_VPN_ID>"
   }
   ```

7. **Networking & Security Groups**
   - Internet Gateway + Route Table for internet access.
   - Security Groups:
     - **Web Server** → Allow HTTP, HTTPS, SSH.
     - **DB Server** → Allow SSH + MongoDB (27017) only from Web Server SG.

8. **EC2 Instances**
   - Provisioned **two EC2 instances** (t2.micro):
     - **Web Server** → MERN App Server
     - **DB Server** → MongoDB Server

9. **Terraform Outputs**
   - Captured Public IPs of both servers:
     ```hcl
     output "web_server_ip" {
       value = aws_instance.web.public_ip
     }

     output "db_server_ip" {
       value = aws_instance.db.public_ip
     }
     ```

10. **Terraform Commands Used**
    ```bash
    terraform init     # Initialized backend & stored state in S3 bucket
      ```
### Screenshot
<img width="1107" height="737" alt="image" src="https://github.com/user-attachments/assets/f33802e8-6405-45e4-8849-5cdc7b573da9" />
<img width="740" height="363" alt="image" src="https://github.com/user-attachments/assets/20be448f-b0c3-451c-babb-ca5f6817bfa0" />


-------
 ```bash
    terraform plan     # Reviewed infrastructure plan
 ```
### Screenshot
<img width="1043" height="428" alt="image" src="https://github.com/user-attachments/assets/ecf95312-798e-49fc-98f5-e6218605e686" />

------
```bash
terraform apply    # Provisioned infrastructure
```

### Screenshot
<img width="1057" height="437" alt="image" src="https://github.com/user-attachments/assets/7b038551-75ac-410a-a95d-52ec0c04c525" />


---


## 🔑 Outputs from Phase 1
- **Web Server Public IP** → Available after `terraform apply`
- **DB Server Public IP** → Available after `terraform apply`

---
### Screenshot
<img width="758" height="540" alt="image" src="https://github.com/user-attachments/assets/c62e6f86-7e3c-4c4b-9803-568419ded9c2" />




### Screenshots of instances running state 
<img width="1027" height="777" alt="image" src="https://github.com/user-attachments/assets/988a5fbf-2937-4e6e-bea9-9cd82aab5c7c" />

<img width="991" height="690" alt="image" src="https://github.com/user-attachments/assets/18b17696-afdd-4406-beb6-e70828e9c659" />




# Phase 2: Configuration Management with Ansible

## Installed Ansible
```bash
sudo apt update
sudo apt install python3 python3-pip -y
pip3 install ansible
```
## Verified installation
```bash
ansible --version
```
## Created Ansible Project Structure

```bash
ansible/
├── inventory.ini
├── playbook-web.yml
├── playbook-db.yml
├── roles/
│   ├── web/
│   │   └── tasks/main.yml
│   └── db/
│       └── tasks/main.yml

```

## Created Ansible Inventory File
### inventory.ini
```bash
[web]
<WEB_SERVER_PUBLIC_IP> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/Shakti-b10.pem

[db]
<DB_SERVER_PUBLIC_IP> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/Shakti-b10.pem
```

### Fixed Key Permissions
```bash
chmod 400 ~/.ssh/Shakti-b10.pem
```

## Verified Ansible Connectivity
```bash
ansible -i inventory.ini all -m ping
```

### Screenshots
<img width="1447" height="491" alt="image" src="https://github.com/user-attachments/assets/7f444187-ab2c-4bec-a798-4a8071291207" />

-------
