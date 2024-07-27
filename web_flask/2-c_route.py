#!/usr/bin/python3
"""
starts Flask web application
"""

from flask import Flask
from markupsafe import escape

app = Flask(__name__)


@app.route('/', strict_slashes=False)
def index():
    """returns Hello HBNB!"""
    return 'Hello HBNB!'


@app.route('/hbnb', strict_slashes=False)
def hbnb():
    """returns HBNB"""
    return 'HBNB'

@app.route("/c/<text>", strict_slashes=False)
def cIsFunc(text):
    """displays c followed by text"""
    return f"C {escape(text.replace('_', ' '))}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='5000')
