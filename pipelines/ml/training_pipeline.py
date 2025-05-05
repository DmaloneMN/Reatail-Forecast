from azureml.core import Workspace, Experiment
from azureml.pipeline.core import Pipeline
from azureml.pipeline.steps import PythonScriptStep

# Initialize workspace
ws = Workspace.from_config()

# Training step
train_step = PythonScriptStep(
    name="train_forecast_models",
    script_name="train.py",
    source_directory="./ml/training",
    compute_target="cpu-cluster",
    environment="forecast-env",
    arguments=["--input-data", "processed/orders"]
)

# Define pipeline
pipeline = Pipeline(workspace=ws, steps=[train_step])
pipeline.validate()
pipeline.publish(name="retail_forecast_training")
