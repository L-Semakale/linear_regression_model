from fastapi import FastAPI
from pydantic import BaseModel, Field, conint, confloat
from fastapi.middleware.cors import CORSMiddleware
import joblib
import numpy as np

# Load model and scaler
model = joblib.load("diabetes_model.pkl")
scaler = joblib.load("scaler.pkl")

app = FastAPI(
    title="Diabetes Prediction API",
    description="Predicts diabetes using patient health metrics",
    version="1.0.0"
)

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Input Schema
class PatientData(BaseModel):
    Pregnancies: int = Field(..., ge=0, le=20)
    Glucose: int = Field(..., gt=0, lt=250)
    BloodPressure: int = Field(..., gt=0, lt=150)
    SkinThickness: int = Field(..., gt=0, lt=100)
    Insulin: int = Field(..., gt=0, lt=1000)
    BMI: float = Field(..., gt=0, lt=100)
    DiabetesPedigreeFunction: float = Field(..., gt=0.0, lt=3.0)
    Age: int = Field(..., gt=0, lt=130)

@app.post("/predict")
def predict(data: PatientData):
    features = np.array([[ 
        data.Pregnancies, data.Glucose, data.BloodPressure,
        data.SkinThickness, data.Insulin, data.BMI,
        data.DiabetesPedigreeFunction, data.Age
    ]])

    scaled_features = scaler.transform(features)
    prediction = model.predict(scaled_features)[0]
    result = "Positive (Diabetic)" if prediction == 1 else "Negative (Non-Diabetic)"
    
    return {
        "prediction": int(prediction),
        "result": result
    }
