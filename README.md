# Versioned-Deployment
# Project Requirements
1. Write a simple restful api to display its current version
2. Containerize the application using docker
3. Create infrastructure and deployment process with terraform on AWS
# Project Architecture
![Blank diagram](https://user-images.githubusercontent.com/49628483/97487257-a46d4700-1982-11eb-975f-6e1ba4866d25.jpeg)
# Setup
The framework comprises of a main folder called **terraform/ecs_fargate**. Please navigate to this folder and you will see that the framework is further sub-divided into 3 layers:
1. **1-infrastructure**
   * This folder defines the vpc and other basic network configurations for our public and private subnets
     * **infrastructure-prod.config**: This file defines our remote state configuration for the infrastructure we are creating on AWS
     * **vpc.tf** : This file defines our 
        - Public & Private subnets 
        - The route tables and its association with its respective public and private subnets
        - Association of NAT-Gateway with private subnet
        - Association of Internet Gateway with the VPC
     * **variables.tf**: This file defines the variable names which would be used in production.tfvars
     * **production.tfvars**: File used to pass the values for our vpc and cidr_blocks
     * **outputs.tf**: File used to output the values of the variables defined in **variables.tf** on the console
2. **2-platform**
   * This folder defines our ecs cluster, route53 domain and other related services
     * **platform-prod.config**: This file defines our remote state configuration for the platform  we are creating on AWS
     * **ecs.tf**: This file defines the following resources for our platform:
       * Creating the ECS cluster
       * Creating Application Load Balancer with security group referenced from 
       **securitygroups.tf** for our ECS cluster
       * Creating our own HTTPS Domain SSL certificate and validating the same for our ECS cluster
       * Adding Route53 record for ALB Domain Name
       * Creating a default target group for our ECS cluster
       * Creating and HTTPS ALB listener for load balancer for our ECS cluster
       * Creating IAM policy for our ECS cluster
       * Attaching IAM policy to ECS cluster role
     * **securitygroups.tf**: This file used to define the security group for ALB to route traffic to our ECS cluster
     * **domain.tf**: This file used to create our domain certificate, and also for validating the SSL certificate
     * **variables.tf**: This file defines the variable names which would be used in production.tfvars
     * **production.tfvars**: File used to pass the values for our ecs domain name, ecs cluster name and internet cidr blocks
     * **outputs.tf**: File used to output the values of the variables defined in **variables.tf** on the console 
3. **3-application**
   * This folder defines our task definition for our ecs cluster, fargate application and other related services to our flask-python application
     * **app-prod.config**: This file defines the backend and reads the remote state for layer 2 infrastructure
     * **app.tf**: This file defines the following resources for our application:
        * Creating the ECS task definition and resolving template
        * Creating IAM task and execution role and policy for ECS tasks
        * Creating security group for ECS service
        * Creating ALB target group for ECS service
        * Creating ECS service
        * Creating ALB listener rule for ECS service
        * Creating CloudWatch log group for ECS service
     * **app.py** A simple restful python application which displays the current version on copying the url 
# Installation
Following packages need to be installed in order to get the framework up and running on the local system:
1. Download Terraform for linux [terraform]https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip from the highlighted link
2. Download Docker for linux [docker] https://docs.docker.com/engine/install/ubuntu/. Please reference the installation instructions as mentioned in the link
3. Python 2.7.x or 3.x.x. [python]https://www.python.org/downloads/source/
4. Use the package manage pip to install awscli
```bash
pip install awscli
```
# Usage
To get the framework up and running on the local system. Please follow the below instructions:
1. Initially, clone the repository to your local system using the command
```bash
git clone https://github.com/Shari87/versioned-deployment.git
```
2. To run the python application **app.py** locally, navigate to the folder **/versioned-deployment/terraform/ecs_fargate/3-application/infrastructure**, then run the script using the command on CLI
```bash
python app.py or python3 app.py # depending on the python version running on the system
```
   * Post the run, please navigate to your browser and type http://0.0.0.0:5000, then the following output would be obtained if the run was successful
   ![Selection_133](https://user-images.githubusercontent.com/49628483/98024235-05d36100-1e2e-11eb-8954-901664cbc413.png)
