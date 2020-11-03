# remote state conf.
remote_state_key = "PROD/platform.tfstate"
remote_state_bucket = "ecs-fargate-rem-state"

# service variables
ecs_service_name = "flaskapp"
docker_container_port = 5000
desired_task_number = "2"
flask_profile = "default"
memory = 1024