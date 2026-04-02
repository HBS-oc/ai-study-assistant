from flask import Flask
from routes.main_routes import main

app = Flask(__name__)

# Register routes
app.register_blueprint(main)

if __name__ == "__main__":
    app.run(debug=True)