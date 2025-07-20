# main.py

from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
from prediction import predict_diabetes

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
    features = [
        data.Pregnancies, data.Glucose, data.BloodPressure,
        data.SkinThickness, data.Insulin, data.BMI,
        data.DiabetesPedigreeFunction, data.Age
    ]
    return predict_diabetes(features)
