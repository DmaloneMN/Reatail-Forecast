from prophet import Prophet
import pandas as pd

def train_model(data_path: str):
    df = pd.read_parquet(data_path)
    model = Prophet(seasonality_mode='multiplicative')
    model.fit(df)
    return model
