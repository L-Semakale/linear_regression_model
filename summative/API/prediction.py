from flask import Flask, request, jsonify
from flask_cors import CORS
import pickle

app = Flask(__name__)
CORS(app)

with open('disease_model.pkl', 'rb') as f:
    model = pickle.load(f)

with open('symptom_columns.pkl', 'rb') as f:
    symptom_columns = pickle.load(f)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    symptoms = data.get('symptoms', [])

    if not symptoms:
        return jsonify({'error': 'No symptoms provided'}), 400

    input_vector = [1 if s in symptoms else 0 for s in symptom_columns]
    prediction = model.predict([input_vector])[0]

    return jsonify({'prediction': prediction})

if __name__ == '__main__':
    app.run(debug=True)
