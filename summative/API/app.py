# e_clinic/backend/app.py
from flask import Flask, request, jsonify
from flask_cors import CORS
import pickle

app = Flask(__name__)
CORS(app)

model = pickle.load(open('disease_model.pkl', 'rb'))

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    # Preprocess and predict logic here
    return jsonify({'prediction': 'Some Disease'})

if __name__ == '__main__':
    app.run(debug=True)
