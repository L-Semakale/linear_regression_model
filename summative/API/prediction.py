# prediction.py

import joblib
import numpy as np

# Load model and scaler
model = joblib.load("diabetes_model.pkl")
scaler = joblib.load("scaler.pkl")

def predict_diabetes(features: list) -> dict:
    """
    Predict diabetes based on input features.
    :param features: List of 8 numerical features
    :return: Dictionary with prediction result
    """
    scaled_features = scaler.transform([features])
    prediction = model.predict(scaled_features)[0]
    result = "Positive (Diabetic)" if prediction == 1 else "Negative (Non-Diabetic)"
    
    return {
        "prediction": int(prediction),
        "result": result
    }
