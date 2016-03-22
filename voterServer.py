from bottle import route, run, template, post, request, static_file, response
import sqlite3, json, os, sys, re

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

    resultsQuery = ("SELECT FirstName, MiddleName, LastName, " +
                    "AddressLine1, AddressLine2, City, CountyCode, Zipcode, "+
                    "BirthDate, PartyAffiliation, VoterID " + 
                    "FROM VOTERS ")

    countQuery = "SELECT COUNT(LastName) FROM VOTERS "

    voterID = formData.get('voterID')
    firstName = formData.get('firstName')
    lastName = formData.get('lastName')
    middleName = formData.get('middleName')
    address1 = formData.get('residenceAddress1').upper()
    address2 = formData.get('residenceAddress2').upper()
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
    phoneNumber = formData.get('phoneNumber')
    email = formData.get('email')
    queryFields = []

    if voterID != "":
        queryFields.append('VoterID = "' + voterID + '"')

    if firstName != "":
        if firstName == "*":
            queryFields.append('FirstName <> ""')
        else:
            queryFields.append('FirstName LIKE "' + firstName.replace("*", "%") + '"')

    if lastName != "":
        if lastName == "*":
            queryFields.append('LastName <> ""')
        else:
            queryFields.append('LastName LIKE "' + lastName.replace("*", "%") + '"')

    if middleName != "":
        if middleName == "*":
            queryFields.append('MiddleName <> ""')
        else:
            queryFields.append('MiddleName LIKE "' + middleName.replace("*", "%") + '"')

    if address1 != "" and address1 != None:
        if address1 == "*":
            queryFields.append('AddressLine1 <> ""')
        elif "*" in address1:
            queryFields.append('AddressLine1 LIKE "' + address1.replace("*","%") + '"')
        else:
            addressList = address1.split()
            for word in addressList:
                queryFields.append('instr(AddressLine1, "' + word + '") >0')

    if address2 != "" and address2 != None:
        if address2 == "*":
            queryFields.append('AddressLine2 <> ""')
        elif "*" in address2:
            queryFields.append('AddressLine2 LIKE "' + address2.replace("*","%") + '"')
        else:
            addressList = address2.split()
            for word in addressList:
                queryFields.append('instr(AddressLine2, "' + word + '") >0')

    if city != "":
        if city == "*":
            queryFields.append('City <> ""')
        else:
            queryFields.append('City LIKE "' + city.replace("*", "%") + '"')


    if countyCode != "":
        queryFields.append('CountyCode = "' + countyCode + '"')

    if zipCode != "":
        if zipCode == "*":
                queryFields.append('ZipCode <> ""')
        else:
            zipCodes = zipCode.replace(' ', '').split(",")
            if len(zipCodes) == 1:
                queryFields.append('ZipCode LIKE "' + zipCode.replace("*", "%") + '"')
            else:
                zipQuery = []
                for code in zipCodes:
                    zipQuery.append('ZipCode LIKE "' + code.replace("*", "%") + '"')
                queryFields.append('(' + ' OR '.join(zipQuery) + ')')

    if "," in birthYear:
        years = birthYear.replace("*","%").split(',')
        yearQuery = []
        if birthMonth != "":
            month = birthMonth
        else:
            month = "_%_%"
        for year in years:
            yearQuery.append('BirthDate LIKE "' + month + '/_%_%/' + year + '"')
        queryFields.append('(' + ' OR '.join(yearQuery) + ')')

    else:
        if birthMonth != "" and birthYear != "":
            queryFields.append('BirthDate Like "' + birthMonth + '/_%_%/' + birthYear.replace("*","%") +'"')
        elif birthMonth == "" and birthYear != "":
            queryFields.append('BirthDate LIKE "_%_%/_%_%/' + birthYear.replace("*","%") + '"')
        elif birthMonth != "" and birthYear == "":
            queryFields.append('BirthDate LIKE "' + birthMonth + '/_%_%/_%_%_%_%"')

    if regMonth != "" and regYear != "":
        queryFields.append('RegistrationDate Like "' + regMonth + '/_%_%/' + regYear +'"')
    elif regMonth == "" and regYear != "":
        queryFields.append('RegistrationDate LIKE "_%_%/_%_%/' + regYear + '"')
    elif regMonth != "" and regYear == "":
        queryFields.append('RegistrationDate LIKE "' + regMonth + '/_%_%/_%_%_%_%"')


    if gender != "" and gender != None:
        queryFields.append('Gender = "' + gender + '"')

    if race != "" and race != None:
        queryFields.append('Race = "' + race + '"')

    if party != "" and party != None:
            queryFields.append('PartyAffiliation = "' + party + '"')


    if phoneNumber != "":
        if phoneNumber == "*":
            queryFields.append('PhoneNumber <> ""')
        else:
            numeric = re.compile(r'[^\d*]+')
            cleanNumber = numeric.sub('',phoneNumber)
            if len(cleanNumber) == 7:
                queryFields.append('PhoneNumber LIKE "' + cleanNumber + '"')
            elif len(cleanNumber) == 10:
                queryFields.append('PhoneAreaCode LIKE "' + cleanNumber[:3] + '"')
                queryFields.append('PhoneNumber LIKE "' + cleanNumber[3:] + '"')


    if email != "":
        if email == "*":
            queryFields.append('Email <> ""')
        else:
            queryFields.append('Email LIKE "' + email.replace("*","%") + '"')



    if len(queryFields) > 0:        
        resultsQuery = resultsQuery + "WHERE " + """ AND """.join(queryFields) + """;"""
        countQuery = countQuery + "WHERE " +" AND ".join(queryFields) + ";"
    
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
            output = template("response.tpl", rows = results, firstName= formData.get('firstName'), lastName=formData.get('lastName'), middleName=formData.get('middleName'), voterID=formData.get('voterID'), zipCode=formData.get('zipCode'), birthMonth=formData.get('birthMonth'), birthYear=formData.get('birthYear'), residenceAddress= formData.get('residenceAddress1'), residenceAddress2= formData.get('residenceAddress2'),city=formData.get('city'), gender=formData.get('gender'), race=formData.get('race'), party=formData.get('party'),  phoneNumber=formData.get('phoneNumber'), email=formData.get('email'), regMonth=formData.get('regMonth'), regYear=formData.get('regYear'), count=count, error=error)
        else:
            output = template("response.tpl", rows = results, firstName= formData.get('firstName'), lastName=formData.get('lastName'), middleName=formData.get('middleName'), voterID=formData.get('voterID'), zipCode=formData.get('zipCode'), birthMonth=formData.get('birthMonth'), birthYear=formData.get('birthYear'), residenceAddress= formData.get('residenceAddress1'), residenceAddress2= formData.get('residenceAddress2'), city=formData.get('city'), gender=formData.get('gender'), race=formData.get('race'), party=formData.get('party'), phoneNumber=formData.get('phoneNumber'), email=formData.get('email'), regMonth=formData.get('regMonth'), regYear=formData.get('regYear'), count=count)
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
    countQuery = "SELECT COUNT(LastName) FROM VOTERS WHERE AddressLine1 = ?"
    cursor.execute(countQuery, [address])
    count = cursor.fetchone()
    print(resultsQuery)
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

if __name__ == '__main__':
    run(host='0.0.0.0', port=port, debug=True)

