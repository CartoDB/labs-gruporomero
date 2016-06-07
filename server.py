#!/usr/bin/env python
import os
from flask import Flask, request, render_template, Response, send_from_directory
from functools import wraps
from jinja2 import ChoiceLoader, FileSystemLoader

def check_auth(username, password):
    """This function is called to check if a username /
    password combination is valid.
    """
    return username == os.environ.get("USERNAME", "test") and password == os.environ.get("PASSWORD", "test")

def authenticate():
    """Sends a 401 response that enables basic auth"""
    return Response(
    'Could not verify your access level for that URL.\n'
    'You have to login with proper credentials', 401,
    {'WWW-Authenticate': 'Basic realm="Login Required"'})

def requires_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        auth = request.authorization
        if not auth or not check_auth(auth.username, auth.password):
            return authenticate()
        return f(*args, **kwargs)
    return decorated


app = Flask(__name__)

if os.environ.get('DEBUG', True):
    app.debug = True

loader = ChoiceLoader([
    app.jinja_loader,
    FileSystemLoader(["./"]),
])
app.jinja_loader = loader

@app.route('/')
@requires_auth
def index():
    return render_template('index.html')

@app.route('/<path:path>')
def send_js(path):
    return send_from_directory('./',path)

if __name__ == "__main__":
    app.run()
