from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware

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

# Define request schema
class PatientData(BaseModel):
    Pregnancies: int = Field(..., ge=0, le=20)
    Glucose: int = Field(..., gt=0, lt=250)
    BloodPressure: int = Field(..., gt=0, lt=150)
    SkinThickness: int = Field(..., gt=0, lt=100)
    Insulin: int = Field(..., gt=0, lt=1000)
    BMI: float = Field(..., gt=0, lt=100)
    DiabetesPedigreeFunction: float = Field(..., gt=0.0, lt=3.0)
    Age: int = Field(..., gt=0, lt=130)

# Prediction endpoint
@app.post("/predict")
def predict(data: PatientData):
    try:
        # Simple rule-based prediction for demonstration
        prediction = "positive" if data.Glucose > 120 else "negative"
        return {"prediction": prediction}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {e}")
