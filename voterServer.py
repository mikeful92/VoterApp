from bottle import route, run, template, post, request, static_file, response
import sqlite3, json, os, sys, csv
from io import BytesIO

def setConnection(databasePath):
    connection = sqlite3.Connection(databasePath)
    connection.row_factory = dict_factory

    return connection

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

def sqlSearch(formData, full=False):
    connection = sqlite3.Connection('../Data/DB.sqlite')
    if not full:
        connection.row_factory = dict_factory
    cursor = connection.cursor()
    error = ""

    resultsQuery = """SELECT * FROM VOTERS WHERE """
    countQuery = "SELECT COUNT(*) FROM VOTERS WHERE "

    voterID = formData.get('voterID')
    firstName = formData.get('firstName').upper()
    lastName = formData.get('lastName').upper()
    middleName = formData.get('middleName').upper()
    address = formData.get('residenceAddress1').upper()
    city = formData.get('city').upper()
    countyCode = formData.get('countyCode')
    zipCode = formData.get('zipCode')
    birthMonth = formData.get('birthMonth')
    birthYear = formData.get('birthYear')
    regMonth = formData.get('regMonth')
    regYear = formData.get('regYear')
    gender = formData.get('gender')
    race = formData.get('race')
    party = formData.get('party')
    areaCode = formData.get('areaCode')
    phoneNumber = formData.get('phoneNumber')
    email = formData.get('email')
    queryFields = []

    if voterID != "":
        queryFields.append('VoterID = "' + voterID + '"')

    if firstName != "":
        if firstName == "*":
            queryFields.append('FirstName <> ""')
        elif "*" in firstName:
            queryFields.append('FirstName LIKE "' + firstName.replace("*", "%") + '"')
        else:
            queryFields.append('FirstName = "' + firstName + '"')

    if lastName != "":
        if lastName == "*":
            queryFields.append('LastName <> ""')
        elif "*" in lastName:
            queryFields.append('LastName LIKE "' + lastName.replace("*", "%") + '"')
        else:
            queryFields.append('LastName = "' + lastName + '"')

    if middleName != "":
        if middleName == "*":
            queryFields.append('MiddleName <> ""')
        elif "*" in middleName:
            queryFields.append('MiddleName LIKE "' + middleName.replace("*", "%") + '"')
        else:
            queryFields.append('MiddleName = "' + middleName + '"')

    if address != "":
        queryFields.append('AddressLine1 = "' + address + '"')

    if city != "":
        if city == "*":
            queryFields.append('City <> ""')
        elif "*" in city:
            queryFields.append('City LIKE "' + city.replace("*", "%") + '"')
        else:
            queryFields.append('City = "' + city + '"')

    # if countyCode:
    #     if countyCode == "*":
    #         queryFields.append('CountyCode <> ""')
    #     elif "*" in countyCode:
    #         queryFields.append('CountyCode LIKE "' + countyCode.replace("*", "%") + '"')
    #     else:
    #         queryFields.append('CountyCode = "' + countyCode + '"')

    if zipCode != "":
        if zipCode == "*":
            queryFields.append('ZipCode <> ""')
        if "*" in zipCode:
            queryFields.append('ZipCode LIKE "' + zipCode.replace("*", "%") + '"')
        else:
            queryFields.append('ZipCode = "' + zipCode + '"')


    if birthMonth != "" and birthYear != "":
        queryFields.append('BirthDate Like "' + birthMonth + '/_%_%/' + birthYear +'"')
    elif birthMonth == "" and birthYear != "":
        queryFields.append('BirthDate LIKE "_%_%/_%_%/' + birthYear + '"')
    elif birthMonth != "" and birthYear == "":
        queryFields.append('BirthDate LIKE "' + birthMonth + '/_%_%/_%_%_%_%"')

    if regMonth != "" and regYear != "":
        queryFields.append('RegistrationDate Like "' + regMonth + '/_%_%/' + regYear +'"')
    elif regMonth == "" and regYear != "":
        queryFields.append('RegistrationDate LIKE "_%_%/_%_%/' + regYear + '"')
    elif regMonth != "" and regYear == "":
        queryFields.append('RegistrationDate LIKE "' + regMonth + '/_%_%/_%_%_%_%"')


    if gender != "":
        if gender == "*":
            queryFields.append('Gender <> ""')
        else:
            queryFields.append('Gender = "' + gender + '"')

    if race != "":
        queryFields.append('Race = "' + race + '"')

    if party != "":
        if party == "*":
            queryFields.append('PartyAffiliation <> ""')
        else:
            queryFields.append('PartyAffiliation = "' + party + '"')

    if areaCode != "":
        if areaCode == "*":
            queryFields.append('PhoneAreaCode <> ""')
        else:
            queryFields.append('PhoneAreaCode = "' + areaCode + '"')

    if phoneNumber != "":
        if phoneNumber == "*":
            queryFields.append('PhoneNumber <> ""')
        else:
            queryFields.append('PhoneNumber = "' + phoneNumber + '"')

    if email != "":
        if email == "*":
            queryFields.append('Email <> ""')
        elif "*" in email:
            queryFields.append('Email LIKE "' + email.replace("*","%") + '"')
        else:
            queryFields.append('Email = "' + email + '"')


    if len(queryFields) == 0:
        error = "Please fill in at least one field"
        return {}, {'COUNT(*)': 'ERROR'}, error
        
    resultsQuery = resultsQuery + """ AND """.join(queryFields) + """;"""
    countQuery = countQuery + " AND ".join(queryFields) + ";"
    
    cursor.execute(countQuery)
    count = cursor.fetchone()

    print(resultsQuery)
    cursor.execute(resultsQuery)
    if full:
        results = cursor.fetchall()
    else:
        results = cursor.fetchmany(500)

    cursor.close()

    return results, count, error



@route('/')
@route('/voterapp')
@route('/voterApp')
@route('/VoterApp')
def home():
    templateUsed = "index.tpl"
    return template(templateUsed)

@post('/listVoter')
def listVoter():
    formData = request.forms
    if formData.get('type') == 'Export':
        results, count, error = sqlSearch(formData, True)
        data = []
        headers = ['VoterID', 'LastName', 'Suffix', 'FirstName', 'MiddleName', 'AddressLine1', 'AddressLine2', 'City', 'CountyCode', 'State', 'Zipcode', 'MailingAddressLine1', 'MailingAddressLine2', 'MailingAddressLine3', 'MailingCity', 'MailingState', 'MailingZipcode', 'MailingCountry', 'Gender', 'Race', 'BirthDate', 'RegistrationDate', 'PartyAffiliation', 'VoterStatus', 'PhoneAreaCode', 'PhoneNumber', 'PhoneExtension', 'Email']
        data.append('\t'.join(headers))

        for row in results:
            data.append('\t'.join(row))

        output = '\n'.join(data)

        response.headers['Content-Type'] = 'application/csv; charset=UTF-8'
        response.headers['Content-Disposition'] = 'attachment; filename=export.txt'
        return output

    elif formData.get('type') == 'Lookup':
        results, count, error = sqlSearch(formData)
        if error != '':
            output = template("response.tpl", rows = results, firstName= formData.get('firstName'), lastName=formData.get('lastName'), middleName=formData.get('middleName'), voterID=formData.get('voterID'), zipCode=formData.get('zipCode'), birthMonth=formData.get('birthMonth'), birthYear=formData.get('birthYear'), residenceAddress= formData.get('residenceAddress1'), city=formData.get('city'), gender=formData.get('gender'), race=formData.get('race'), party=formData.get('party'), areaCode=formData.get('areaCode'), phoneNumber=formData.get('phoneNumber'), email=formData.get('email'), regMonth=formData.get('regMonth'), regYear=formData.get('regYear'), count=count, error=error)
        else:
            output = template("response.tpl", rows = results, firstName= formData.get('firstName'), lastName=formData.get('lastName'), middleName=formData.get('middleName'), voterID=formData.get('voterID'), zipCode=formData.get('zipCode'), birthMonth=formData.get('birthMonth'), birthYear=formData.get('birthYear'), residenceAddress= formData.get('residenceAddress1'), city=formData.get('city'), gender=formData.get('gender'), race=formData.get('race'), party=formData.get('party'), areaCode=formData.get('areaCode'), phoneNumber=formData.get('phoneNumber'), email=formData.get('email'), regMonth=formData.get('regMonth'), regYear=formData.get('regYear'), count=count)
    else:
        output = "Error"
    
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
connection = setConnection('../Data/DB.sqlite')
args = sys.argv
if len(args) == 2:
    port = int(os.path.join(args[1]))

else:
    port = 8080

run(host='0.0.0.0', port=port, debug=True)

