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
def timeit(startTime):
    print("Stage time: {}".format(time.time() - startTime))
    return time.time()


#This function creates the queries, one for results and one for count
#The function takes the formData as input and captures all the information from the fields
#If the field was not empty or None it follows an algorithm to create the WHERE statement matching that search
#Last it joins all the possible WHERE statementes and attaches it to the query Base
def queryGeneration(formData, baseQuery):
    #    
    table = "VOTERS"

    #Count Query Base
    countQuery = "SELECT COUNT(LastName)"

    #Capture form fields
    voterID = formData.get('voterID')
    firstName = formData.get('firstName')
    lastName = formData.get('lastName')
    middleName = formData.get('middleName')
    address1 = formData.get('residenceAddress1')
    address2 = formData.get('residenceAddress2')
    city = formData.get('city')
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

    #List of possible WHERE statements
    queryFields = []

    #Perfect match search for voter
    if voterID != "" and voterID != None:
        queryFields.append('VoterID = "' + voterID + '"')


    if firstName != "":
        #If wildcard(*) is provied alone, search where field is not null
        if firstName == "*":
            queryFields.append('FirstName <> ""')
        #Else search using LIKE(case-insenstive match)
        #If user uses wildcard(*) replace for SQL appropriate wildcard character
        else:
            queryFields.append('FirstName LIKE "' + firstName.replace("*", "%") + '"')

    if lastName != "":
        #If wildcard(*) is provied alone, search where field is not null
        if lastName == "*":
            queryFields.append('LastName <> ""')
        #If user uses wildcard(*) replace for SQL appropriate wildcard character
        else:
            queryFields.append('LastName LIKE "' + lastName.replace("*", "%") + '"')

    if middleName != "":
        #If wildcard(*) is provied alone, search where field is not null
        if middleName == "*":
            queryFields.append('MiddleName <> ""')
        #If user uses wildcard(*) replace for SQL appropriate wildcard character
        else:
            queryFields.append('MiddleName LIKE "' + middleName.replace("*", "%") + '"')

    if address1 != "" and address1 != None:
        address1 = address1.upper()
        #If wildcard(*) is provied alone, search where field is not null
        if address1 == "*":
            queryFields.append('AddressLine1 <> ""')
        #If users uses wildcard search with LIKE statement and replace wildcard(*) for SQL appropriate wildcard character(%)
        elif "*" in address1:
            queryFields.append('AddressLine1 LIKE "' + address1.replace("*","%") + '"')
        #Else split the provided input of address and find fields that contain all the parts in the split address 
        else:
            addressList = address1.split()
            for word in addressList:
                queryFields.append('instr(AddressLine1, "' + word + '") >0')

    if address2 != "" and address2 != None:
        address2 = address2.upper()
        #If wildcard(*) is provied alone, search where field is not null
        if address2 == "*":
            queryFields.append('AddressLine2 <> ""')
        #If users uses wildcard search with LIKE statement and replace wildcard(*) for SQL appropriate wildcard character(%)
        elif "*" in address2:
            queryFields.append('AddressLine2 LIKE "' + address2.replace("*","%") + '"')
        #Else split the provided input of address and find fields that contain all the parts in the split address 
        else:
            addressList = address2.split()
            for word in addressList:
                queryFields.append('instr(AddressLine2, "' + word + '") >0')

    if city != "" and city != None:
        city = city.upper()
        #If wildcard(*) is provied alone, search where field is not null
        if city == "*":
            queryFields.append('City <> ""')
        #If user uses wildcard(*) replace for SQL appropriate wildcard character
        else:
            queryFields.append('City LIKE "' + city.replace("*", "%") + '"')


    #Perfect match search for County Code
    if countyCode != "":
        if countyCode == "PAL" or countyCode == None:
            table = "PALMVOTERS"
        else:
            queryFields.append('CountyCode = "' + countyCode + '"')


    if zipCode != "":
        #If wildcard(*) is provied alone, search where field is not null
        if zipCode == "*":
                queryFields.append('ZipCode <> ""')
        else:
            #User can submit more than one zip code at time, separated by a comma(,)
            zipCodes = zipCode.replace(' ', '').split(",")
            #If only one zipcode was provided, replace for SQL appropriate wildcard character
            if len(zipCodes) == 1:
                queryFields.append('ZipCode LIKE "' + zipCode.replace("*", "%") + '"')
            else:
                #If more than one zipcode is provided then add each zipcode condition individually
                zipQuery = []
                for code in zipCodes:
                    zipQuery.append('ZipCode LIKE "' + code.replace("*", "%") + '"')
                #Join all the conditions using an 'OR' and append to query Fields. 
                queryFields.append('(' + ' OR '.join(zipQuery) + ')')

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
        queryFields.append('(' + ' OR '.join(yearQuery) + ')')

    else:
        if birthMonth != "" and birthYear != "":
            queryFields.append('BirthDate Like "' + birthMonth + '/_%_%/' + birthYear.replace("*","%") +'"')
        elif birthMonth == "" and birthYear != "":
            queryFields.append('BirthDate LIKE "_%_%/_%_%/' + birthYear.replace("*","%") + '"')
        elif birthMonth != "" and birthYear == "":
            queryFields.append('BirthDate LIKE "' + birthMonth + '/_%_%/_%_%_%_%"')


    #Condition if both Registration Month and Registration Year are provided
    if regMonth != "" and regYear != "":
        queryFields.append('RegistrationDate Like "' + regMonth + '/_%_%/' + regYear +'"')
    #Condition if only Registration Year is provided
    elif regMonth == "" and regYear != "":
        queryFields.append('RegistrationDate LIKE "_%_%/_%_%/' + regYear + '"')
    #Condition if only Registration Month is provided
    elif regMonth != "" and regYear == "":
        queryFields.append('RegistrationDate LIKE "' + regMonth + '/_%_%/_%_%_%_%"')

    #Condition if gender is not empty
    if gender != "" and gender != None:
        queryFields.append('Gender = "' + gender + '"')

    #Condition if gender is not empty
    if race != "" and race != None:
        queryFields.append('Race = "' + race + '"')

    #Condition if gender is not empty
    if party != "" and party != None:
            queryFields.append('PartyAffiliation = "' + party + '"')


    if phoneNumber != "":
        #If wildcard(*) is provied alone, search where field is not null
        if phoneNumber == "*":
            queryFields.append('PhoneNumber <> ""')
        else:
            #Reg Ex search for numbers only in the phon number field
            numeric = re.compile(r'[^\d*]+')
            cleanNumber = numeric.sub('',phoneNumber)
            #if only 7 digits were provided, search only the Phone Number field
            if len(cleanNumber) == 7:
                queryFields.append('PhoneNumber LIKE "' + cleanNumber + '"')
            #If 10 digits were provided, search first 3 digits in Phone Area Code field, last 7 digits in Phone Number field 
            elif len(cleanNumber) == 10:
                queryFields.append('PhoneAreaCode LIKE "' + cleanNumber[:3] + '"')
                queryFields.append('PhoneNumber LIKE "' + cleanNumber[3:] + '"')


    if email != "":
        #If wildcard(*) is provied alone, search where field is not null
        if email == "*":
            queryFields.append('Email <> ""')
        #If user uses wildcard(*) replace for SQL appropriate wildcard character
        else:
            queryFields.append('Email LIKE "' + email.replace("*","%") + '"')


    #If at least one field was not null, then add the the query as WHERE using join
    if len(queryFields) > 0:        
        resultsQuery = baseQuery + " FROM " + table + " WHERE " + """ AND """.join(queryFields) + """;"""
        countQuery = countQuery + " FROM " + table + " WHERE " +" AND ".join(queryFields) + ";"

    return resultsQuery, countQuery


def sqlSearch(formData, full=False):
    #Start timer for performance tracking
    startTime = time.time()
    #Create connectiont to DB and assign cursor
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()

    #Search parameters are different for a full search (export) and non-full search(list voters)
    if not full:
        #Only pulling the columns needed when pulling for list voters
        baseQuery = ("SELECT FirstName, MiddleName, LastName, " +
                    "AddressLine1, AddressLine2, City, CountyCode, Zipcode, "+
                    "BirthDate, PartyAffiliation, RegistrationDate, VoterID ")
    else:
        #pull all the data when exporting
        baseQuery = "SELECT * "

    #Generate the results and count query conditions
    resultsQuery, countQuery = queryGeneration(formData, baseQuery)
    print(countQuery)
    print(resultsQuery)

    #Execute the count first and fetch results
    cursor.execute(countQuery)
    countResults = cursor.fetchone()

    #Second execute the results and time it
    cursor.execute(resultsQuery)
    startTime = timeit(startTime)
    print("Query execute")

    if full:
        #Fetch all results if full search (exporting)
        results = cursor.fetchall()
    else:
        #Fetch 15000 records if not full (list voters)
        #More than 15,000 will cause a bottle neck in the browser displayng >15000 rows
        results = cursor.fetchmany(15000)

    startTime = timeit(startTime)
    print("Query fetch")

    cursor.close()
    connection.close()
    count = countResults['COUNT(LastName)']

    return results, count

def saveSearch(formData):
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()

    resultsQuery, countQuery = queryGeneration(formData, "SELECT *")

    cursor.execute(countQuery)
    countResults = cursor.fetchone()
    count = countResults['COUNT(LastName)']

    #Capture form fields
    searchName = formData.get('searchName')
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

    cursor.execute('INSERT INTO SEARCHES(SearchName, Count, LastName, FirstName, MiddleName, AddressLine1, AddressLine2, City, CountyCode, ZipCode, Gender, Race, BirthMonth, BirthYear, RegMonth, RegYear, PartyAffiliation, PhoneNumber, Email)'+
                    ' VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);', [searchName, count, lastName, firstName, middleName, address1, address2, city, countyCode, zipCode, gender, race, birthMonth, birthYear, regMonth, regYear, party, phoneNumber, email])
    cursor.close()
    connection.commit()
    connection.close()


def selectSearches():
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()

    searchQuery = "SELECT * FROM SEARCHES"
    cursor.execute(searchQuery)
    results = cursor.fetchall()

    return results

@route('/')
def home():
    templateUsed = "index.tpl"
    return template(templateUsed)

@post('/listVoter')
def listVoter():
    startTime = time.time()
    formData = request.forms
    print("Received request")
    if formData.get('type') == 'Export':
        results, count = sqlSearch(formData, True)
        data = []
        headers = ['VoterID', 'LastName', 'Suffix', 'FirstName', 'MiddleName', 'AddressLine1', 'AddressLine2', 'City', 'CountyCode', 'State', 'Zipcode', 'MailingAddressLine1', 
                'MailingAddressLine2', 'MailingAddressLine3', 'MailingCity', 'MailingState', 'MailingZipcode', 'MailingCountry', 'Gender', 'Race', 'BirthDate', 'RegistrationDate',
                'PartyAffiliation', 'VoterStatus', 'PhoneAreaCode', 'PhoneNumber', 'PhoneExtension', 'Email']
        data.append('\t'.join(headers))

        if count > 0:
            for row in results:
                rowData = []
                for col in headers:
                    rowData.append(row[col])
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
            output = template("response.tpl", rows = results, firstName= formData.get('firstName'), lastName=formData.get('lastName'), middleName=formData.get('middleName'),
                voterID=formData.get('voterID'), zipCode=formData.get('zipCode'), birthMonth=formData.get('birthMonth'), birthYear=formData.get('birthYear'), residenceAddress= formData.get('residenceAddress1'),
                residenceAddress2= formData.get('residenceAddress2'), city=formData.get('city'), gender=formData.get('gender'), race=formData.get('race'), party=formData.get('party'),
                phoneNumber=formData.get('phoneNumber'), email=formData.get('email'), regMonth=formData.get('regMonth'), regYear=formData.get('regYear'), count=count, time= totalTime)
        else:
            output = template("response.tpl", rows = [], firstName= formData.get('firstName'), lastName=formData.get('lastName'), middleName=formData.get('middleName'),
                voterID=formData.get('voterID'), zipCode=formData.get('zipCode'), birthMonth=formData.get('birthMonth'), birthYear=formData.get('birthYear'), residenceAddress= formData.get('residenceAddress1'),
                residenceAddress2= formData.get('residenceAddress2'), city=formData.get('city'), gender=formData.get('gender'), race=formData.get('race'), party=formData.get('party'),
                phoneNumber=formData.get('phoneNumber'), email=formData.get('email'), regMonth=formData.get('regMonth'), regYear=formData.get('regYear'), count=count)

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

    query = """SELECT * FROM VOTERS WHERE VoterID = ?"""
    cursor.execute(query, [str(voterID)])
    results = cursor.fetchone()
    cursor.close()
    connection.close()

    if len(results) == 0:
        output = template("index.tpl")
    else:
        output = template("voter.tpl", **results)
    return output

@route('/address/<address>')
def listAddress(address):
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()
    resultsQuery = ("SELECT FirstName, MiddleName, LastName, Suffix, " +
            "AddressLine1, AddressLine2, City, CountyCode, Zipcode, "+
            "VoterID, BirthDate, PartyAffiliation, RegistrationDate " + 
            "FROM VOTERS " +
            "WHERE AddressLine1 = ?")
    countQuery = "SELECT COUNT(LastName) FROM VOTERS WHERE AddressLine1 = ?"
    cursor.execute(countQuery, [address])
    count = cursor.fetchone()
    print(resultsQuery)
    cursor.execute(resultsQuery, [address])
    results = cursor.fetchmany(25)
    #TODO fix count results and over all results returned
    cursor.close()
    connection.close()
    
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
    connection = setConnection('../Data/DB.sqlite')
    cursor = connection.cursor()
    query = "SELECT * FROM VOTERS WHERE VoterID = ?;"

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

