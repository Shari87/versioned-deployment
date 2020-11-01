# remote state
remote_state_key = "PROD/infrastructure.tfstate"
remote_state_bucket = "ecs-fargate-rem-state"   # Please use the name of your S3 bucket

ecs_domain_name = "shariharan.org"      # Please use the domain name of your configured route 53 DNSS
ecs_cluster_name = "Production-ECS-Cluster"
internet_cidr_blocks = "0.0.0.0/0"