resource "azurerm_machine_learning_job" "parallel_forecasting" {
  name                   = "parallel-order-forecast"
  machine_learning_workspace_id = azurerm_machine_learning_workspace.main.id
  experiment_name        = "order_forecasting"
  
  parallel_run_step {
    name = "forecast-all-skus"
    compute_target = azurerm_machine_learning_compute_cluster.training.id
    
    source_directory = "./src"
    script_name      = "parallel_run.py"
    environment_id   = azurerm_machine_learning_environment.forecast.id
    
    input_data = {
      "orders" = azurerm_machine_learning_datastore_datalake_gen2.main.path("/processed/orders")
    }
    
    output_data = {
      "predictions" = azurerm_machine_learning_datastore_datalake_gen2.main.path("/predictions")
    }
    
    instance_count = 8
    node_count     = 4
    mini_batch_size = 50
    
    environment_variables = {
      "MODEL_TYPE" = "Prophet"
    }
  }
  
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_machine_learning_environment" "forecast" {
  name                     = "forecast-env"
  machine_learning_workspace_id = azurerm_machine_learning_workspace.main.id
  docker_image             = "mcr.microsoft.com/azureml/openmpi4.1.0-ubuntu20.04"
  conda_dependencies       = file("environment.yml")
}
