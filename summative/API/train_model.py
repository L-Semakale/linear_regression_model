import pandas as pd
import pickle
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder

# Load dataset
df = pd.read_csv("OHAS Dataset.csv")

# Drop unnecessary columns
df = df.drop(['Disease_CUI', 'Symptom_CUI'], axis=1)

# Encode all categorical columns
label_encoders = {}
for column in df.columns:
    if df[column].dtype == 'object':  # text column
        le = LabelEncoder()
        df[column] = le.fit_transform(df[column].astype(str))
        label_encoders[column] = le

# Features and label
X = df.drop('Disease', axis=1)
y = df['Disease']

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train model
model = RandomForestClassifier()
model.fit(X_train, y_train)

# Save model
with open("disease_model.pkl", "wb") as f:
    pickle.dump(model, f)

# Save encoders (to be used later during prediction)
with open("label_encoders.pkl", "wb") as f:
    pickle.dump(label_encoders, f)

print("✅ Model and encoders saved successfully.")
