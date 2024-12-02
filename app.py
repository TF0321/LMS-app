from flask import Flask,render_template,request,redirect, url_for, session

from flask_mysqldb import MySQL
import MySQLdb.cursors
import MySQLdb.cursors, re, hashlib

app = Flask(__name__)

app.config['MYSQL_HOST'] = "localhost"
app.config['MYSQL_USER'] = "root"
app.config['MYSQL_PASSWORD'] = ""
app.config['MYSQL_DB'] = "project_db"

mysql = MySQL(app)


@app.route('/',methods=['GET','POST'])
def login():

    if request.method == 'POST':
        userEmail = request.form['Email']

        print(userEmail)

        cur = mysql.connection.cursor()

        # cur.execute("SELECT userEmail FROM users WHERE userEmail =?", str(userEmail))

        sql = "SELECT userEmail, roleDescription FROM users INNER JOIN roles ON roleID = userRoleID WHERE userEmail =%s"
        adr = (userEmail, )

        cur.execute(sql, adr)

        user = cur.fetchone()

        

        print(user)

        if user:

            serialisedResponse = {
            'email': user[0],
            'role': user[1]
            }

            if serialisedResponse['role'] == 'Administrator':
                return render_template('menuAdmin.html')
            else:
                return render_template('menu.html')
        else:
            return 'Incorrect email! Try another email.'

    return render_template('login.html')



@app.route('/menu',methods=['GET','POST'])
def menu():



    return render_template('menu.html')



@app.route('/menuAdmin',methods=['GET','POST'])
def menuAdmin():



    return render_template('menuAdmin.html')



@app.route('/registration',methods=['GET','POST'])
def registration():

    if request.method == 'POST':
        userFirstName = request.form['FirstName']
        userLastName = request.form['LastName']
        userEmail = request.form['Email']
        userRoleID = request.form['RoleID']

        print(userEmail)

        cur = mysql.connection.cursor()

        # cur.execute("SELECT userEmail FROM users WHERE userEmail =?", str(userEmail))

        sql = "SELECT userEmail FROM users WHERE userEmail =%s"
        adr = (userEmail, )

        cur.execute(sql, adr)

        user = cur.fetchone()

        # user = cur.fetchone()

        print(user)

        if user:
            
            return 'Account Already Exists. Try using a different email address.'
        else:
            cur.execute("INSERT INTO users (userFirstName, userLastName, userEmail, userRoleID) VALUES (%s,%s,%s,%s)", (userFirstName, userLastName, userEmail, userRoleID))

        mysql.connection.commit()

        cur.close()

        return "success"

    return render_template('registration.html')



@app.route('/addBook',methods=['GET','POST'])
def addBook():

    if request.method == 'POST':
        bookName = request.form['BookName']
        bookAuthor = request.form['BookAuthor']

        cur = mysql.connection.cursor()

        cur.execute("INSERT INTO books (bookName, bookAuthor) VALUES (%s,%s)", (bookName, bookAuthor))

        mysql.connection.commit()

        cur.close()

        return "success"

    return render_template('addBook.html')



@app.route('/users')
def users():
    cur = mysql.connection.cursor()

    users = cur.execute("SELECT userFirstName, userLastName, userEmail, roleDescription FROM users INNER JOIN roles ON roleID = userRoleID")

    if users > 0:

        print("----------------------------------")
        print(cur)
        print("----------------------------------")

        userDetails = cur.fetchall()

        serialized_data = []

        for user in userDetails: 

            # print(user['userFirstName'])

            singleUserDetails = {
                'firstName': user[0],
                'lastName': user[1],
                'email': user[2],
                'role': user[3]
            }
            
            serialized_data.append(singleUserDetails)


        print(serialized_data)
        print("----------------------------------")
        print(userDetails)
        print("----------------------------------")

        return render_template('users.html',userDetails=serialized_data)  
    


@app.route('/myBooks')
def myBooks():
    cur = mysql.connection.cursor()

    books = cur.execute("SELECT bookName, bookAuthor FROM books")

    if books > 0:

        print("----------------------------------")
        print(cur)
        print("----------------------------------")

        bookDetails = cur.fetchall()

        print("----------------------------------")
        print(bookDetails)
        print("----------------------------------")

        return render_template('myBooks.html',bookDetails=bookDetails)    

if __name__ == "__main__":
    app.run(debug=True)