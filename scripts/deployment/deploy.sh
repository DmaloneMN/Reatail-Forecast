#!/bin/bash

# Initialize Terraform
terraform init -input=false

# Plan and apply
terraform plan -out=tfplan -input=false
terraform apply -input=false tfplan

# Run data ingestion
az synapse pipeline create --workspace-name retail-synapse --file @pipelines/data_ingestion/order_ingestion.json
az synapse pipeline run --workspace-name retail-synapse --name Order_Data_Ingestion

# Deploy ML endpoint
az ml online-endpoint create --name forecast-endpoint --file ml/endpoint.yml
