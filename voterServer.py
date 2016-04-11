from bottle import route, run, template, request, static_file, response, get, post, redirect
import sqlite3, json, os, sys, re, time

#Returns a connection to the sqlite DB
#row_factory is set to dict_factory so that results are returned as a list of dictionaries
#This makes it easier for the response view to display the results
def setConnection(databasePath):
    connection = sqlite3.Connection(databasePath)
    connection.row_factory = dict_factory

    return connection

#Defines how query results from the DB will be returned as mentioned above
def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

#Tracking time of query execution and fetch to better understand indices
def timeit(startTime, phrase="Stage time"):
    print("{}: {}".format(phrase, (time.time() - startTime)))
    return time.time()


#This function creates the queries, one for results and one for count
#The function takes the formData as input and captures all the information from the fields
#If the field was not empty or None it follows an algorithm to create the WHERE statement matching that search
#Last it joins all the possible WHERE statementes and attaches it to the query Base
def queryGeneration(formData):
    fieldDictionary = dict(formData)

    fieldDictionary.pop('SearchName')

    countBase = "SELECT COUNT(LastName)"
    conditions = []
    queryType = fieldDictionary.pop('type')

    if queryType == 'Lookup':
        resultsBase = ("SELECT FirstName, MiddleName, LastName, " +
                        "AddressLine1, AddressLine2, City, CountyCode, ZipCode, "+
                        "BirthDate, Party, RegistrationDate, VoterID")
    else:
        resultsBase = "SELECT *"

    if fieldDictionary['CountyCode'] != 'PAL' and fieldDictionary['CountyCode'] != 'STATE':
        fromQuery = "FROM STATE" + fieldDictionary['DataYear']
        conditions.append('CountyCode = "' + fieldDictionary['CountyCode'] + '"')
    else:
        fromQuery = "FROM " + fieldDictionary['CountyCode'] + fieldDictionary['DataYear']

    del fieldDictionary['CountyCode']
    del fieldDictionary['DataYear']

    birthYear = fieldDictionary.pop('BirthYear')
    birthMonth = fieldDictionary.pop('BirthMonth')
    regYear = fieldDictionary.pop('RegYear')
    regMonth = fieldDictionary.pop('RegMonth')

    #User can submit more than one zip code at time, separated by a comma(,)
    if "," in birthYear:
        #split by comma, and replace for SQL appropriate wildcard character
        years = birthYear.replace("*","%").split(',')
        yearQuery = []
        if birthMonth != "":
            month = birthMonth
        else:
            month = "_%_%"
        for year in years:
            yearQuery.append('BirthDate LIKE "' + month + '/_%_%/' + year + '"')
        conditions.append('(' + ' OR '.join(yearQuery) + ')')

    else:
        if birthMonth != "" and birthYear != "":
            conditions.append('BirthDate Like "' + birthMonth + '/_%_%/' + birthYear.replace("*","%") +'"')
        elif birthMonth == "" and birthYear != "":
            conditions.append('BirthDate LIKE "_%_%/_%_%/' + birthYear.replace("*","%") + '"')
        elif birthMonth != "" and birthYear == "":
            conditions.append('BirthDate LIKE "' + birthMonth + '/_%_%/_%_%_%_%"')


    #Condition if both Registration Month and Registration Year are provided
    if regMonth != "" and regYear != "":
        conditions.append('RegistrationDate Like "' + regMonth + '/_%_%/' + regYear +'"')
    #Condition if only Registration Year is provided
    elif regMonth == "" and regYear != "":
        conditions.append('RegistrationDate LIKE "_%_%/_%_%/' + regYear + '"')
    #Condition if only Registration Month is provided
    elif regMonth != "" and regYear == "":
        conditions.append('RegistrationDate LIKE "' + regMonth + '/_%_%/_%_%_%_%"')


    if 'PhoneNumber' in fieldDictionary:
        if fieldDictionary['PhoneNumber'] != '':
            phoneNumber = fieldDictionary.pop("PhoneNumber")
            if phoneNumber == "*":
                conditions.append('PhoneNumber <> ""')
            else:
                numeric = re.compile(r'[^\d*]+')
                cleanNumber = numeric.sub('',phoneNumber)
                print(cleanNumber)
                if len(cleanNumber) <= 7:
                    conditions.append('PhoneNumber LIKE "' + cleanNumber.replace("*","%") + '"')
                else:
                    conditions.append('PhoneAreaCode = "' + cleanNumber[:3] + '"')
                    conditions.append('PhoneNumber LIKE"' + cleanNumber[3:].replace("*","%") + '"')


    for key, value in fieldDictionary.items():
        if value:
            if value == "*":
                conditions.append("{} <> ''".format(key))
            else:
                queryFields = value.upper().split(',')
                subconditions = []
                for field in queryFields:                    
                    if "*" in field:
                        subconditions.append("{} LIKE '{}'".format(key, field.replace("*","%")))
                    else:
                        subconditions.append("{} = '{}'".format(key, field))
                conditions.append('(' + ' OR '.join(subconditions) + ')')

    whereCondition = ''

    if len(conditions) > 0:
        whereCondition = 'WHERE ' + ' AND '.join(conditions)

    resultsQuery = ' '.join([resultsBase, fromQuery, whereCondition, ";"])
    countQuery = ' '.join([countBase, fromQuery, whereCondition, ";"])

    return resultsQuery, countQuery


def sqlSearch(formData, full=False):
    #Start timer for performance tracking
    startTime = time.time()
    #Create connectiont to DB and assign cursor
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()   

    #Generate the results and count query conditions
    resultsQuery, countQuery = queryGeneration(formData)

    print(resultsQuery)

    #Execute the count first and fetch results
    cursor.execute(countQuery)
    countResults = cursor.fetchone()

    #Second execute the results and time it
    cursor.execute(resultsQuery)

    startTime = timeit(startTime, "Query execute")

    if full:
        #Fetch all results if full search (exporting)
        results = cursor.fetchall()
    else:
        #Fetch 15000 records if not full (list voters)
        #More than 15,000 will cause a bottle neck in the browser displayng >15000 rows
        results = cursor.fetchmany(15000)

    startTime = timeit(startTime, "Query fetch")

    cursor.close()
    connection.close()

    count = countResults['COUNT(LastName)']

    return results, count

def saveSearch(formData):
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()

    resultsQuery, countQuery = queryGeneration(formData)

    cursor.execute(countQuery)
    countResults = cursor.fetchone()
    count = countResults['COUNT(LastName)']

    fields = dict(formData)
    print(fields['DataYear'])
    cursor.execute('INSERT INTO SEARCHES(SearchName, Count, LastName, FirstName, MiddleName, AddressLine1, AddressLine2, City, CountyCode, DataYear, ZipCode, Gender, Race, BirthMonth, BirthYear, RegMonth, RegYear, Party, PhoneNumber, Email)'+
                    ' VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);', [fields['SearchName'], count, fields['LastName'], fields['FirstName'], fields['MiddleName'], fields['AddressLine1'], fields['AddressLine2'], fields['City'], fields['CountyCode'], fields['DataYear'], fields['ZipCode'], fields['Gender'], fields['Race'], fields['BirthMonth'], fields['BirthYear'], fields['RegMonth'], fields['RegYear'], fields['Party'], fields['PhoneNumber'], fields['Email']])
    cursor.close()
    connection.commit()
    connection.close()


def selectSearches():
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()

    searchQuery = "SELECT * FROM SEARCHES"
    cursor.execute(searchQuery)
    results = cursor.fetchall()

    cursor.close()
    connection.close()

    return results

@route('/')
def home():
    templateUsed = "index.tpl"
    return template(templateUsed)

@post('/listVoter')
def listVoter():
    print(dict(request.forms))
    startTime = time.time()
    formData = request.forms
    print("Received request")
    if formData.get('type') == 'Export':
        results, count = sqlSearch(formData, True)
        data = []
        headers = ['VoterID', 'LastName', 'Suffix', 'FirstName', 'MiddleName', 'AddressLine1', 'AddressLine2', 'City', 'CountyCode', 'ZipCode', 'MailingAddressLine1', 
                'MailingAddressLine2', 'MailingAddressLine3', 'MailingCity', 'MailingState', 'MailingZipcode', 'MailingCountry', 'Gender', 'Race', 'BirthDate', 'RegistrationDate',
                'Party', 'VoterStatus', 'PhoneAreaCode', 'PhoneNumber', 'PhoneExtension', 'Email']
        data.append('\t'.join(headers))

        if count > 0:
            for row in results:
                print(row)
                rowData = []
                for col in headers:
                    rowData.append(str(row[col]))
                data.append('\t'.join(rowData))
        else:
            data.append("NO RESULTS FOUND")
        output = '\n'.join(data)
        response.headers['Content-Type'] = 'application/csv; charset=UTF-8'
        response.headers['Content-Disposition'] = 'attachment; filename=export.txt'

    elif formData.get('type') == 'Lookup':
        results, count = sqlSearch(formData)
        if count > 0:
            totalTime = "%.5f" % (time.time() - startTime)
            output = template("response.tpl", rows = results, firstName= formData.get('FirstName'), lastName=formData.get('LastName'), middleName=formData.get('MiddleName'),
                voterID=formData.get('VoterID'), zipCode=formData.get('ZipCode'), birthMonth=formData.get('BirthMonth'), birthYear=formData.get('BirthYear'), residenceAddress= formData.get('AddressLine1'),
                residenceAddress2= formData.get('AddressLine2'), city=formData.get('City'), gender=formData.get('Gender'), race=formData.get('Race'), party=formData.get('Party'),
                phoneNumber=formData.get('PhoneNumber'), email=formData.get('Email'), regMonth=formData.get('RegMonth'), regYear=formData.get('RegYear'), count=count, time= totalTime)
        else:
            output = template("response.tpl", rows = [], firstName= formData.get('FirstName'), lastName=formData.get('LastName'), middleName=formData.get('MiddleName'),
                voterID=formData.get('VoterID'), zipCode=formData.get('ZipCode'), birthMonth=formData.get('BirthMonth'), birthYear=formData.get('BirthYear'), residenceAddress= formData.get('AddressLine1'),
                residenceAddress2= formData.get('AddressLine2'), city=formData.get('City'), gender=formData.get('Gender'), race=formData.get('Race'), party=formData.get('Party'),
                phoneNumber=formData.get('PhoneNumber'), email=formData.get('Email'), regMonth=formData.get('RegMonth'), regYear=formData.get('RegYear'), count=count)

    elif formData.get('type') == 'SaveSearch':
        saveSearch(formData)
        return redirect('/searches')
    else:
        output = "Error"

    return output



@route('/voter/<voterID>')
def listVoter(voterID):
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()

    query = """SELECT * FROM STATE2016 WHERE VoterID = ?"""
    cursor.execute(query, [str(voterID)])
    results = cursor.fetchone()
    cursor.close()
    connection.close()

    if len(results) == 0:
        output = template("index.tpl")
    else:
        output = template("voter.tpl", results)
    return output

@route('/address/<address>')
def listAddress(address):
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()
    resultsQuery = ("SELECT FirstName, MiddleName, LastName, Suffix, " +
            "AddressLine1, AddressLine2, City, CountyCode, ZipCode, "+
            "VoterID, BirthDate, Party, RegistrationDate " + 
            "FROM STATE2016 " +
            "WHERE AddressLine1 = ?")
    countQuery = "SELECT COUNT(LastName) FROM STATE2016 WHERE AddressLine1 = ?"
    cursor.execute(countQuery, [address])
    countResults = cursor.fetchone()
    print(resultsQuery)
    cursor.execute(resultsQuery, [address])
    results = cursor.fetchmany(25)
    #TODO fix count results and over all results returned
    cursor.close()
    connection.close()

    count = countResults['COUNT(LastName)']
    
    if len(results) == 0:
        output = template("index.tpl")
    else:
        output = template("response.tpl", rows = results, count=count, residenceAddress1=address)
    return output


@route('/static/<directory>/<filename>')
def send_static(directory, filename):
    return static_file(os.path.join(directory, filename), root='./static/')

@route('/api/v1/voter/<voterID>')
def voterShow(voterID):
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()
    query = "SELECT * FROM STATE2016 WHERE VoterID = ?;"

    cursor.execute(query, [voterID])

    data = cursor.fetchone()
    cursor.close()
    connection.close()

    jsonResponse = json.dumps(data)

    if len(data) == 0:
        return { "success" : False, "error" : "None or more than one voter returned" }
    else:
        return jsonResponse

@get('/searches')
def listSearches():
    results = selectSearches()
    output = template("searches.tpl", searches=results)

    return output

@post('/searches')
def deleteSearch():
    searchID = request.forms.get('SearchID')
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()

    cursor.execute('DELETE FROM SEARCHES WHERE ID = ?', [searchID])
    cursor.close()
    connection.commit()
    connection.close()
    return redirect('/searches')

args = sys.argv
if len(args) == 2:
    port = int(os.path.join(args[1]))
else:
    port = 8080

if __name__ == '__main__':
    run(host='0.0.0.0', port=port, debug=True)
