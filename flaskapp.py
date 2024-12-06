from flask import Flask, render_template, request, redirect, url_for
import mysql.connector

app = Flask(__name__)

# Login to Database
conn = mysql.connector.connect(
    host="localhost",
    user="privateuser",
    password="PrivateUser111",
    database="holytrinity"
)

@app.route('/') # Retrieves Infromation from Database
def index():
    cursor = conn.cursor()
    
    # Fetching Miracles
    cursor.execute("SELECT Testament, Book, Verse, MiracleType, Summary FROM Miracles")
    miracles = cursor.fetchall()
    
    # Fetching Teachings
    cursor.execute("SELECT Testament, Book, Verse, MainMessage, Summary FROM Teachings")
    teachings = cursor.fetchall()
    
    return render_template('index.html', miracles=miracles, teachings=teachings, results=[])

@app.route('/add_miracle', methods=['POST']) # Adding a miracle to the web app
def add_miracle():
    testament = request.form['testament']
    book = request.form['book']
    verse = request.form['verse']
    miracle_type = request.form['miracle_type']
    summary = request.form['summary']

    if not testament or not miracle_type:
        return "Testament and Miracle Type are required", 400

    cursor = conn.cursor()
    cursor.execute("INSERT INTO Miracles (Testament, Book, Verse, MiracleType, Summary) VALUES (%s, %s, %s, %s, %s)", 
                   (testament, book, verse, miracle_type, summary))
    conn.commit()
    return redirect(url_for('index'))

@app.route('/add_teaching', methods=['POST']) # Adding a Teaching to the Web App
def add_teaching():
    testament = request.form['testament']
    book = request.form['book']
    verse = request.form['verse']
    main_message = request.form['main_message']
    summary = request.form['summary']

    if not testament or not main_message:
        return "Testament and Main Message are required", 400

    cursor = conn.cursor()
    cursor.execute("INSERT INTO Teachings (Testament, Book, Verse, MainMessage, Summary) VALUES (%s, %s, %s, %s, %s)", 
                   (testament, book, verse, main_message, summary))
    conn.commit()
    return redirect(url_for('index'))

@app.route('/search', methods=['GET']) #Search Code for Miracles or Teachings
def search():
    testament = request.args.get('testament')
    book = request.args.get('book')
    verse = request.args.get('verse')

    cursor = conn.cursor()
    
    # Search Miracles
    cursor.execute("SELECT MiracleType, Verse, Summary FROM Miracles WHERE Testament=%s AND Book=%s AND Verse=%s",
                   (testament, book, verse))
    miracles = cursor.fetchall()
    
    # Search Teachings
    cursor.execute("SELECT MainMessage, Verse, Summary FROM Teachings WHERE Testament=%s AND Book=%s AND Verse=%s",
                   (testament, book, verse))
    teachings = cursor.fetchall()
    
    # Format results to include type/message and summary
    formatted_results = []
    for miracle in miracles:
        if len(miracle) >= 3:
            formatted_results.append({
                'type_message': miracle[0],
                'verse': miracle[1],
                'summary': miracle[2],
                'testament': testament,
                'book': book
            })
    for teaching in teachings:
        if len(teaching) >= 3:
            formatted_results.append({
                'type_message': teaching[0],
                'verse': teaching[1],
                'summary': teaching[2],
                'testament': testament,
                'book': book
            })
    
    return render_template('index.html', miracles=[], teachings=[], results=formatted_results)

if __name__ == '__main__':
    app.run(debug=True)
