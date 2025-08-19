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
<img width="762" height="288" alt="image" src="https://github.com/user-attachments/assets/88a06d4b-9c83-4a40-be68-71d0fecef615" />


### Screenshots of instances running state 
<img width="1386" height="710" alt="image" src="https://github.com/user-attachments/assets/f34cbcd3-29dd-49a2-9c0f-532cbd0e90c5" />
<img width="1337" height="597" alt="image" src="https://github.com/user-attachments/assets/62481d5e-e461-4b14-bc78-158733e5d06c" />



## 🚀 Next Steps (Phase 2)
In the next phase, we will configure the servers using **Ansible**:
- Setup Node.js, NPM, MongoDB
- Clone the MERN app repo
- Install dependencies
- Configure `.env` files
- Start the application services

---

📌 **Note:** Replace placeholders (`<YOUR_AMI_ID>`, `<YOUR_SUBNET_ID>`, `<YOUR_VPN_ID>`, `<YOUR_S3_BUCKET_NAME>`) before running Terraform.

