from flask import Flask, render_template
import os
from flask import request
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

student_name = ""
result = None
error = None
KommerIn = None
Sparris = None
real_name = ""

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
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    result_args = None
    personnumber = request.args.get("pid")
    cur.execute("SELECT student_name FROM students WHERE person_nr = %s", (personnumber,))
    real_name = cur.fetchone()
    result_args = cur.callproc("get_student", (personnumber, result_args))
    if personnumber != None and result_args[1] != None:
        student_name = personnumber
        cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (personnumber,))
        result = [[x[1], x[2], 0] for x in cur.fetchall()]
        for i in result:
            cur.execute("SELECT course_hp FROM courses WHERE course_code = %s", (i[0],))
            course = cur.fetchall()
            i[2] = course[0][0]
        cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 1", (student_name,))
        KommerIn = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
        cnx.commit()
        cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 0", (student_name,))
        Sparris = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
        cnx.commit()
    else:
        error = "Please enter a valid person number."
        return render_template('index.html', current_name = student_name, Registered=result, error= error, Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
        
@app.route('/add_student', methods=['post'])
def add_student():
    personnumber = request.form.get("pid")
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    if not personnumber:
        error = "Please enter a valid person number."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    name = request.form.get("name")
    cur.callproc("add_student", (personnumber, name))
    cnx.commit()
    
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/remove_student', methods=['POST'])
def remove_student():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    personnumber = request.form.get("pid")
    if not personnumber:
        error = "Please enter a valid person number."
        return render_template('index.html', current_name = student_name, Registered=result, error=error, Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    cur.callproc("remove_student", (personnumber,))
    cnx.commit()
    if student_name == personnumber:
        student_name = ""
        result = None
        error = None
        KommerIn = None
        Sparris = None
        real_name = ""
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/update_student_name', methods=['POST'])
def update_student_name():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    personnumber = request.form.get("pid")
    if not personnumber:
        error = "Please enter a valid person number."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    name = request.form.get("name")
    cur.callproc("update_student_name", (personnumber, name))
    cnx.commit()
    cur.execute("SELECT student_name FROM students WHERE person_nr = %s", (personnumber,))
    real_name = cur.fetchone()
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/update_student_personnumber', methods=['POST'])
def update_student_personnumber():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    personnumber = request.form.get("pid")
    if not personnumber:
        error = "Please enter a valid person number."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    new = request.form.get("newpid")
    cur.callproc("update_student_personnumber", (personnumber, new))
    cnx.commit()
    student_name = new
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/add_registrations', methods=['POST'])
def add_registrations():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    personnumber = request.form.get("pid")
    if not personnumber:
        error = "Please enter a valid person number."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    course = request.form.get("course")
    #eli, på course. om det returnar 0 så är det en sparrad kurs
    if (course in Sparris) and (course not in KommerIn):
        error = "You cannot register for a sparrad course."
        return render_template('index.html', current_name = student_name, Registered=result, error=error, Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    cur.callproc("add_registrations", (personnumber, course))
    cnx.commit()
    cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (student_name,))
    result = [[x[1], x[2], 0] for x in cur.fetchall()]
    for i in result:
        cur.execute("SELECT course_hp FROM courses WHERE course_code = %s", (i[0],))
        course = cur.fetchall()
        i[2] = course[0][0]
    cnx.commit()
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 1", (student_name,))
    KommerIn = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 0", (student_name,))
    Sparris = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/update_registrations_hp', methods=['POST'])
def update_registrations_hp():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    personnumber = request.form.get("pid")
    if not personnumber:
        error = "Please enter a valid person number."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    course = request.form.get("course")
    hp = request.form.get("hp")
    cur.callproc("update_registrations_hp", (personnumber, course, hp))
    cnx.commit()
    cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (student_name,))
    result = [[x[1], x[2], 0] for x in cur.fetchall()]
    for i in result:
        cur.execute("SELECT course_hp FROM courses WHERE course_code = %s", (i[0],))
        course = cur.fetchall()
        i[2] = course[0][0]
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 1", (student_name,))
    KommerIn = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 0", (student_name,))
    Sparris = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    if course in Sparris:
        error = "You cannot register for a sparrad course."
        return render_template('index.html', current_name = student_name, Registered=result, error=error, Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    else:
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/remove_registrations', methods=['POST'])
def remove_registrations():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    personnumber = request.form.get("pid")
    if not personnumber:
        error = "Please enter a valid person number."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    course = request.form.get("course")
    cur.callproc("remove_registrations", (personnumber, course))
    cnx.commit()
    cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (student_name,))
    result = [[x[1], x[2], 0] for x in cur.fetchall()]
    for i in result:
        cur.execute("SELECT course_hp FROM courses WHERE course_code = %s", (i[0],))
        course = cur.fetchall()
        i[2] = course[0][0]
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 1", (student_name,))
    KommerIn = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 0", (student_name,))
    Sparris = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/add_course', methods=['POST'])
def add_course():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    course = request.form.get("course")
    if not course:
        error = "Please enter a valid course code."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    hp = int(request.form.get("hp"))
    type = request.form.get("type")
    cur.callproc("add_course", (course, hp, type))
    cnx.commit()
    cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (student_name,))
    result = [[x[1], x[2], 0] for x in cur.fetchall()]
    for i in result:
        cur.execute("SELECT course_hp FROM courses WHERE course_code = %s", (i[0],))
        course = cur.fetchall()
        i[2] = course[0][0]
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 1", (student_name,))
    KommerIn = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 0", (student_name,))
    Sparris = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/remove_course', methods=['POST'])
def remove_course():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    course = request.form.get("course")
    global error
    if not course:
        error = "Please enter a valid course code."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    cur.callproc("remove_course", (course,))
    cnx.commit()
    cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (student_name,))
    result = [[x[1], x[2], 0] for x in cur.fetchall()]
    for i in result:
        cur.execute("SELECT course_hp FROM courses WHERE course_code = %s", (i[0],))
        course = cur.fetchall()
        i[2] = course[0][0]
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 1", (student_name,))
    KommerIn = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 0", (student_name,))
    Sparris = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()    
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/update_course_code', methods=['POST'])
def update_course_code():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    course = request.form.get("course")
    if not course:
        error = "Please enter a valid course code."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    new = request.form.get("new")
    cur.callproc("update_course_code", (course, new))
    cnx.commit()
    cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (student_name,))
    result = [[x[1], x[2], 0] for x in cur.fetchall()]
    for i in result:
        cur.execute("SELECT course_hp FROM courses WHERE course_code = %s", (i[0],))
        course = cur.fetchall()
        i[2] = course[0][0]
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 1", (student_name,))
    KommerIn = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 0", (student_name,))
    Sparris = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()    
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/update_course_hp', methods=['POST'])
def update_course_hp():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    course = request.form.get("course")
    if not course:
        error = "Please enter a valid course code."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    hp = request.form.get("hp")
    cur.callproc("update_course_hp", (course, hp))
    cnx.commit()
    cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (student_name,))
    result = [[x[1], x[2], 0] for x in cur.fetchall()]
    for i in result:
        cur.execute("SELECT course_hp FROM courses WHERE course_code = %s", (i[0],))
        course = cur.fetchall()
        i[2] = course[0][0]
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 1", (student_name,))
    KommerIn = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 0", (student_name,))
    Sparris = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()    
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/update_course_type', methods=['POST'])
def update_course_type():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    course = request.form.get("course")
    if not course:
        error = "Please enter a valid course code."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    type = request.form.get("type")
    cur.callproc("update_course_type", (course, type))
    cnx.commit()
    cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (student_name,))
    result = [[x[1], x[2], 0] for x in cur.fetchall()]
    for i in result:
        cur.execute("SELECT course_hp FROM courses WHERE course_code = %s", (i[0],))
        course = cur.fetchall()
        i[2] = course[0][0]
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 1", (student_name,))
    KommerIn = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 0", (student_name,))
    Sparris = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()    
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

@app.route('/update_course_requirements', methods=['POST'])
def update_course_requirements():
    global student_name
    global result
    global error
    global KommerIn
    global Sparris
    global real_name
    course = request.form.get("course")
    if not course:
        error = "Please enter a valid course code."
        return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)
    hp = request.form.get("hp")
    requirement = request.form.get("requirement")
    cur.callproc("add_requirements", (course,hp,requirement))
    cnx.commit()
    cur.execute("SELECT * FROM registrations WHERE person_nr = %s", (student_name,))
    result = [[x[1], x[2], 0] for x in cur.fetchall()]
    for i in result:
        cur.execute("SELECT course_hp FROM courses WHERE course_code = %s", (i[0],))
        course = cur.fetchall()
        i[2] = course[0][0]
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 1", (student_name,))
    KommerIn = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()
    cur.execute("SELECT * FROM courses WHERE eli(courses.course_code, %s) = 0", (student_name,))
    Sparris = [x[0] for x in cur.fetchall() if x[0] not in [i[0] for i in result]]
    cnx.commit()    
    return render_template('index.html', current_name = student_name, Registered=result, error="", Possible=KommerIn, Sparrad=Sparris, current_real_name=real_name)

if __name__ == '__main__':
   app.run(debug=True) 
   
            