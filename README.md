# Versioned-Deployment
# Project Requirements
1. Write a simple restful api to display its current version
2. Containerize the application using docker
3. Create infrastructure and deployment process with terraform on AWS
# Project Architecture
![Blank diagram](https://user-images.githubusercontent.com/49628483/97487257-a46d4700-1982-11eb-975f-6e1ba4866d25.jpeg)
# Setup
The framework comprises of a main folder called terraform/ecs_fargate. Please navigate to this folder and you will see that the framework is further sub-divided into 3 layers:
1. **1-infrastructure**
   * This folder defines the vpc and other basic network configurations for our public and private subnets
     * **infrastructure-prod.config**: This file defines our remote state configuration for the infrastructure which we are creating
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
     * **platform-prod.config**: This file defines our remote state configuration for the platform which we are creating
     * **ecs.tf**: This file defines the following resources for our platform:
       * Creating the ECS cluster
       * Creating Application Load Balancer with security group referenced from 
       ** securitygroups.tf ** for our ECS cluster
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
# Installation
