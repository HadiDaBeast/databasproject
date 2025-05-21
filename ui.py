from flask import Flask, render_template
import os
from flask import request
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

cnx = mysql.connector.connect(
    host="localhost",
    port=3306,
    user="root",
    password="Abouzahra123!",
    database="course_overview"
)

cur = cnx.cursor()


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/get_student', methods=['GET'])
def get_registered_courses():
    personnumber = request.args.get("pid")
    result = None
    if personnumber:
        cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (personnumber,))
        result = [x[1] for x in cur.fetchall()]
    return render_template('index.html', Registered=result)
        
@app.route('/add_student', methods=['post'])
def add_student():
    personnumber = request.form.get("pid")
    name = request.form.get("name")
    program = request.form.get("prgm")
    cur.callproc("add_student", (personnumber, name, program))
    cnx.commit()
    return render_template('index.html')

@app.route('/remove_student', methods=['POST'])
def remove_student():
    personnumber = request.form.get("pid")
    cur.callproc("remove_student", (personnumber))
    cnx.commit()
    return render_template('index.html')

@app.route('/update_student_hp', methods=['POST'])
def update_student_hp():
    personnumber = request.form.get("pid")
    hp = request.form.get("hp")
    cur.callproc("update_student_hp", (personnumber, hp))
    cnx.commit()
    return render_template('index.html')

@app.route('/update_student_program', methods=['POST'])
def update_student_program():
    personnumber = request.form.get("pid")
    program = request.form.get("prgm")
    cur.callproc("update_student_program", (personnumber, program))
    cnx.commit()
    return render_template('index.html')

@app.route('/update_student_name', methods=['POST'])
def update_student_name():
    personnumber = request.form.get("pid")
    name = request.form.get("name")
    cur.callproc("update_student_name", (personnumber, name))
    cnx.commit()
    return render_template('index.html')

@app.route('/update_student_personnumber', methods=['POST'])
def update_student_personnumber():
    personnumber = request.form.get("pid")
    new = request.form.get("newpid")
    cur.callproc("update_student_personnumber", (personnumber, new))
    cnx.commit()
    return render_template('index.html')

@app.route('/add_registrations', methods=['POST'])
def add_registrations():
    personnumber = request.form.get("pid")
    course = request.form.get("course")
    cur.callproc("add_registrations", (personnumber, course))
    cnx.commit()
    return render_template('index.html')

if __name__ == '__main__':
   app.run(debug=True) 