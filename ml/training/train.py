from prophet import Prophet
import pandas as pd
import mlflow

def train_forecast(train_data_path: str, model_output_path: str):
    """Train Prophet model and log with MLflow"""
    df = pd.read_parquet(train_data_path)
    
    with mlflow.start_run():
        model = Prophet(
            seasonality_mode='multiplicative',
            yearly_seasonality=True,
            weekly_seasonality=True
        )
        model.fit(df)
        
        # Log metrics/params
        mlflow.prophet.log_model(model, "model")
        mlflow.log_artifact(model_output_path)
