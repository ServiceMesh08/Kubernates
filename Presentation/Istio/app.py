from flask import Flask, request
app = Flask(__name__)

# "Database" in memoria
exams = []

@app.route('/', methods=['POST'])
def post_exam():
    data = request.json  # richiede Content-Type: application/json
    exams.append(data)
    return f"✅ Exam received: {data}", 201

@app.route('/', methods=['GET'])
def get_exams():
    return {"exams": exams}, 200

app.run(host='0.0.0.0', port=8080)
