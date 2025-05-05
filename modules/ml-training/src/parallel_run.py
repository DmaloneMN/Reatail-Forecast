from azureml.core import Run
from prophet import Prophet
import pandas as pd

def init():
    global model
    model = Prophet(
        seasonality_mode='multiplicative',
        yearly_seasonality=True,
        weekly_seasonality=True
    )

def run(mini_batch):
    results = []
    
    for file_path in mini_batch:
        data = pd.read_parquet(file_path)
        
        # Train per-SKU model
        sku_model = Prophet().fit(data)
        
        # Make 30-day forecast
        future = sku_model.make_future_dataframe(periods=30)
        forecast = sku_model.predict(future)
        
        results.append(forecast[['ds', 'yhat']].tail(30))
    
    return pd.concat(results)
