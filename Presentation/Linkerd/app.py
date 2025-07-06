from flask import Flask, request, Response
import json, random, time, os

app = Flask(__name__)

# Aura descriptions with fixed vibe scores
aura_descriptions = [
    {"text": "Your aura just entered the room before you did 🔥✨", "score": 1_000},
    {"text": "If vibes could kill, yours would be lethal 💫😎",        "score": 10_000},
    {"text": "Aura status: buffering... please try again later 😫💤",  "score": -1_000},
    {"text": "You are the CEO of GigaChads 🦅🗿",                       "score": 1_000_000},
]

# ─── Parametri regolabili via env (comodi per il laboratorio) ──────────
ERROR_RATE   = float(os.getenv("ERROR_RATE",   "0.4"))   # 0–1  -> 40 %
MIN_DELAY_S  = float(os.getenv("MIN_DELAY_S",  "0.2"))   # 200 ms
MAX_DELAY_S  = float(os.getenv("MAX_DELAY_S",  "3.0"))   #   3 s

@app.route("/aura")
def aura():
    name = request.args.get("name", "mystery being")

    # 1) ERRORE 5xx (≈40 %): fallimento immediato ⇒ Linkerd può ritentare
    if random.random() < ERROR_RATE:
        return Response(
            json.dumps({"error": "internal server error – simulated"}),
            status=500,
            mimetype="application/json",
        )

    # 2) RITARDO VARIABILE: alcune chiamate supereranno il timeout di 1 s
    time.sleep(random.uniform(MIN_DELAY_S, MAX_DELAY_S))

    aura = random.choice(aura_descriptions)
    response_data = {"Description": aura["text"], "AURA": aura["score"]}
    return Response(json.dumps(response_data, ensure_ascii=False),
                    mimetype="application/json")
    
@app.route("/slow")
def slow():
    # Simula latenza 2–4 s: oltre la soglia che avresti con timeout 1 s
    time.sleep(random.uniform(2.0, 4.0))
    return Response(json.dumps({"status": "slow but OK"}), mimetype="application/json")

@app.route("/chaos")
def chaos():
    # Sempre errore: utile per failure-accrual
    return Response(json.dumps({"error": "injected failure"}), status=500,
                    mimetype="application/json")


if __name__ == "__main__":
    # Bind all interfaces for Kubernetes pod
    app.run(host="0.0.0.0", port=8080)
