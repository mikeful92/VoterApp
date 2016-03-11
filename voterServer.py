from bottle import route, run, template, post, request, static_file
import sqlite3, json, os

def setConnection():
    databaseName = "../Data/DB.sqlite"
    connection = sqlite3.Connection(databaseName)
    connection.row_factory = dict_factory

    return connection

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

@route('/')
@route('/voterapp')
@route('/voterApp')
@route('/VoterApp')
def home():
    templateUsed = "index.tpl"
    return template(templateUsed)

@post('/listVoter')
def listVoter():
    cursor = connection.cursor()

    resultsQuery = """SELECT * FROM VOTERS WHERE """
    countQuery = "SELECT COUNT(*) FROM VOTERS WHERE "

    firstName = request.forms.get('firstName').upper()
    lastName = request.forms.get('lastName').upper()
    middleName = request.forms.get('middleName').upper()
    countyCode = request.forms.get('countyCode')
    voterID = request.forms.get('voterID')
    zipCode = request.forms.get('zipCode')
    birthMonth = request.forms.get('birthMonth')
    birthYear = request.forms.get('birthYear')
    queryFields = []

    if firstName != "":
        if "*" in firstName:
            queryFields.append('FirstName LIKE "' + firstName.replace("*", "%") + '"')
        else:
            queryFields.append('FirstName = "' + firstName + '"')

    if lastName != "":
        if "*" in lastName:
            queryFields.append('LastName LIKE "' + lastName.replace("*", "%") + '"')
        else:
            queryFields.append('LastName = "' + lastName + '"')

    if middleName != "":
        queryFields.append('MiddleName = "' + middleName + '"')

    if countyCode:
        queryFields.append('CountyCode = "' + countyCode + '"')

    if voterID != "":
        queryFields.append('VoterID = "' + voterID + '"')

    if zipCode != "":
        if "*" in zipCode:
            queryFields.append('ZipCode LIKE "' + zipCode.replace("*", "%") + '"')
        else:
            queryFields.append('ZipCode = "' + zipCode + '"')

    if birthMonth != "" and birthYear != "":
        queryFields.append('BirthDate Like "' + birthMonth + '/_%_%/' + birthYear +'"')

    if len(queryFields) == 0:
        error = "Please fill in at least one field"
        return template("index.tpl", error=error)
        
    resultsQuery = resultsQuery + """ AND """.join(queryFields) + """;"""
    countQuery = countQuery + " AND ".join(queryFields) + ";"

    cursor.execute(countQuery)
    count = cursor.fetchone()

    cursor.execute(resultsQuery)
    results = cursor.fetchall()
    
    cursor.close()
    print(count['COUNT(*)'])
    if count['COUNT(*)'] <= 50:
        output = template("response.tpl", rows = results, firstName=firstName, lastName=lastName, middleName=middleName, voterID=voterID, zipCode=zipCode, count=count)
    else:
        output = template("response.tpl", rows = results, firstName=firstName, lastName=lastName, middleName=middleName, voterID=voterID, zipCode=zipCode, count=count)
    return output

@route('/voter/<voterID>')
def listVoter(voterID):
    cursor = connection.cursor()

    query = """SELECT * FROM VOTERS WHERE VoterID = ?"""
    cursor.execute(query, [str(voterID)])
    results = cursor.fetchone()
    cursor.close()

    if len(results) == 0:
        output = template("index.tpl")
    else:
        output = template("voter.tpl", **results)
    return output

@route('/address/<address>')
def listAddress(address):
    cursor = connection.cursor()
    resultsQuery = ("SELECT FirstName, MiddleName, LastName, Suffix, " +
            "AddressLine1, AddressLine2, City, CountyCode, Zipcode, "+
            "VoterID, BirthDate, PartyAffiliation " + 
            "FROM VOTERS " +
            "WHERE AddressLine1 = ?")
    countQuery = "SELECT COUNT(*) FROM VOTERS WHERE AddressLine1 = ?"
    cursor.execute(countQuery, [address])
    count = cursor.fetchone()

    cursor.execute(resultsQuery, [address])
    results = cursor.fetchmany(25)

    if len(results) == 0:
        output = template("index.tpl")
    else:
        output = template("response.tpl", rows = results, count=count)
    return output


@route('/static/<directory>/<filename>')
def send_static(directory, filename):
    return static_file(os.path.join(directory, filename), root='./static/')

@route('/api/v1/voter/<voterID>')
def voterShow(voterID):
    cursor = connection.cursor()
    query = "SELECT * FROM VOTERS WHERE VoterID = ?;"

    cursor.execute(query, [voterID])

    data = cursor.fetchone()
    cursor.close()
    jsonResponse = json.dumps(data)

    if len(data) == 0:
        return { "success" : False, "error" : "None or more than one voter returned" }
    else:
        return jsonResponse

global connection 
connection = setConnection()
run(host='0.0.0.0', port=8080, debug=True)

