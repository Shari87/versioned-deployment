#!/bin/sh

SERVICE_NAME="app"
SERVICE_TAG="v1"
ECR_REPO_URL="AMAZON_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/${SERVICE_NAME}" # Please add your respective aws account id in place of AMAZON_ACCOUNT_ID


if [ "$1" = "dockerize" ];then
    sudo docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) AMAZON_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com # Please add your respective aws account id in place of AMAZON_ACCOUNT_ID
    sudo aws ecr create-repository --repository-name ${SERVICE_NAME:?} || true
    sudo docker image build -t ${SERVICE_NAME}:${SERVICE_TAG} .
    sudo docker tag ${SERVICE_NAME}:${SERVICE_TAG} ${ECR_REPO_URL}:${SERVICE_TAG}
    sudo docker push ${ECR_REPO_URL}:${SERVICE_TAG}
elif [ "$1" = "plan" ];then
    terraform init -backend-config="app-prod.config"
    terraform plan -var-file="production.tfvars" -var "docker_image_url=${ECR_REPO_URL}:${SERVICE_TAG}"
elif [ "$1" = "deploy" ];then
    terraform init -backend-config="app-prod.config"
    terraform taint -allow-missing aws_ecs_task_definition.flaskapp-task-definition
    terraform apply -var-file="production.tfvars" -var "docker_image_url=${ECR_REPO_URL}:${SERVICE_TAG}" -auto-approve
elif [ "$1" = "destroy" ];then
    terraform init -backend-config="app-prod.config"
    terraform destroy -var-file="production.tfvars" -var "docker_image_url=${ECR_REPO_URL}:${SERVICE_TAG}" -auto-approve
fi