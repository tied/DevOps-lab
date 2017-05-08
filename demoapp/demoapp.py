# Test Flask App for StreamCo
# By: Rory Chatterton
# Purpose: 1 Page application that returns AWS Instance ID & random data from self deployed db.

# Imports
from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from werkzeug.contrib.fixers import ProxyFix
import requests

app = Flask(__name__)

# DB Config
db = SQLAlchemy(app)
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://streamco_test:streamco!23@db.stan.rorychatterton.com/flaskapp"


# Data Model
class Result(db.Model):
    __tablename__ = 'results'

    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String())

    def __init__(self, text):
        self.text = text

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def store_to_db(self):
        db.session.add(self)
        db.session.commit()


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
    results = Result.query.order_by('id')
    return render_template('homepage.html', instance_id=instance_id, Results=results)


# Custom 404 error handler
@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


@app.route('/additems/')
def addItems():
    for i in range(0, 10):
        r = Result(text="some sample text")
        r.store_to_db()

    instance_id = get_instance_id()  # Get AWS Instance ID
    return render_template('homepage.html', instance_id=instance_id, Results=Result.query.order_by('id'))


# Start App
if __name__ == "__main__":
    app.run()
