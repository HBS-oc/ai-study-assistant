from flask import Blueprint

main = Blueprint("main", __name__)

@main.route("/")
def home():
    return "AI Study Assistant Running"

@main.route("/health")
def health():
    return {"status": "ok"}