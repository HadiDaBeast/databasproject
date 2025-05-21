from flask import Flask, render_template
import os
from flask import request

app = Flask(__name__)

current_chosen_course = None

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/add_student', methods=['POST'])
def add():
    print("Add button was pressed.")
    return render_template('index.html')



if __name__ == '__main__':
   app.run(debug=True)  # Enable debug mode to see detailed error messages