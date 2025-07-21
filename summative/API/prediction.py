import joblib
import numpy as np
import logging

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

try:
    model = joblib.load("diabetes_model.pkl")
    scaler = joblib.load("scaler.pkl")
    logger.info("Model and scaler loaded successfully.")
except Exception as e:
    logger.error(f"Failed to load model or scaler: {e}")
    raise

def predict_diabetes(features: list) -> dict:
    """
    Given a list of features, return diabetes prediction result.
    """
    try:
        logger.debug(f"Received features for prediction: {features}")
        scaled_features = scaler.transform([features])
        prediction = model.predict(scaled_features)[0]
        logger.debug(f"Model prediction result: {prediction}")

        result = "Positive (Diabetic)" if prediction == 1 else "Negative (Non-Diabetic)"
        return {
            "prediction": int(prediction),
            "result": result
        }
    except Exception as e:
        logger.error(f"Prediction failed: {e}")
        raise
