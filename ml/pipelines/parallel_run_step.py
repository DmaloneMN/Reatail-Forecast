from azureml.pipeline.steps import ParallelRunConfig, ParallelRunStep
from azureml.core import Environment

def create_parallel_run_step(compute_target, input_dataset):
    parallel_run_config = ParallelRunConfig(
        source_directory=".",
        entry_script="batch_scoring.py",
        mini_batch_size="10",
        error_threshold=5,
        compute_target=compute_target,
        node_count=4,
        environment=Environment.get(workspace=ws, name="forecast-env"),
        output_action="append_row"
    )
    
    return ParallelRunStep(
        name="parallel-forecast",
        parallel_run_config=parallel_run_config,
        inputs=[input_dataset],
        output=output_dataset,
        arguments=["--model_type", "Prophet"],
        allow_reuse=False
    )
