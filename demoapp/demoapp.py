# Test Flask App for StreamCo
# By: Rory Chatterton
# Purpose: 1 Page application that returns AWS Instance ID & random data from self deployed db.

# Imports
from flask import Flask, render_template
from werkzeug.contrib.fixers import ProxyFix
import requests

app = Flask(__name__)

# Fixes errors associated with headers from proxied nginx
# http://werkzeug.pocoo.org/docs/0.12/contrib/fixers/#werkzeug.contrib.fixers.ProxyFix
app.wsgi_app = ProxyFix(app.wsgi_app)


# Queries the AWS Metadata endpoint for the instance_id
def get_instance_id():
    try:
        instance_id = requests.get("http://169.254.169.254/latest/meta-data/instance-id").text
    except OSError:
        instance_id = "Metadata endpoint unreachable. Are you running this on AWS?"
    return instance_id


# Homepage Template
@app.route('/')
def hello_world():

    instance_id = get_instance_id()  # Get AWS Instance ID

    return render_template('homepage.html', instance_id=instance_id)


# Custom 404 error handler
@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

# Start App
if __name__ == '__main__':
    app.run()
