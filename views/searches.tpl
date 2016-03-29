% include('header.tpl')
<div class="well">
   <table class="table table-striped display" id="searches">
        <thead>
            <tr>
                <th>Search Name</th>
                <th>Count</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Middle Name</th>
                <th>Address Line 1</th>
                <th>Line 2</th>
                <th>City</th>
                <th>Cty.</th>
                <th>ZipCode</th>
                <th>Birth Month</th>
                <th>Birth Year</th>
                <th>Reg Month</th>
                <th>Reg Year</th>
                <th>Gender</th>
                <th>Race</th>
                <th>Party</th>
                <th>Phone Number</th>
                <th>Email</th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            %for search in searches:
                <tr>
                    <td>{{search['SearchName']}}</td>
                    <td>{{search['Count']}}</td>
                    <td>{{search['FirstName']}}</td>
                    <td>{{search['LastName']}}</td>
                    
                    <td>{{search['MiddleName']}}</td>
                    
                    <td>{{search['AddressLine1']}}</td>
                    
                    <td>{{search['AddressLine2']}}</td>
                    
                    <td>{{search['City']}}</td>
                   
                    <td>{{search['CountyCode']}}</td>
                    
                    <td>{{search['Zipcode']}}</td>
                    
                    <td>{{search['BirthMonth']}}</td>
                    
                    <td>{{search['BirthYear']}}</td>
                    
                    <td>{{search['RegMonth']}}</td>
                    
                    <td>{{search['RegYear']}}</td>
                    
                    <td>{{search['Gender']}}</td>
                    
                    <td>{{search['Race']}}</td>
                    
                    <td>{{search['PartyAffiliation']}}</td>
                    
                    <td>{{search['PhoneNumber']}}</td>
                    
                    <td>{{search['Email']}}</td>
                    

                    <td>
                        <form class="form" action="/listVoter" METHOD="POST" enctype = "multipart/form-data">
                            <input type="hidden" name="firstName" value="{{ search['FirstName'] }}">
                            <input type="hidden" name="lastName" value="{{ search['LastName'] }}">
                            <input type="hidden" name="middleName" value="{{ search['MiddleName'] }}">
                            <input type="hidden" name="residenceAddress1" value="{{search['AddressLine1']}}">
                            <input type="hidden" name="residenceAddress2" value="{{search['AddressLine2']}}">
                            <input type="hidden" name="city" value="{{ search['City'] }}">
                            <input type="hidden" name="countyCode" value="{{ search['CountyCode'] }}">
                            <input type="hidden" name="zipCode" value="{{ search['Zipcode'] }}">
                            <input type="hidden" name="birthMonth" value="{{ search['BirthMonth'] }}">
                            <input type="hidden" name="birthYear" value="{{ search['BirthYear'] }}">
                            <input type="hidden" name="regMonth" value="{{ search['RegMonth'] }}">
                            <input type="hidden" name="regYear" value="{{ search['RegYear'] }}">
                            <input type="hidden" name="gender" value="{{ search['Gender'] }}">
                            <input type="hidden" name="race" value="{{ search['Race'] }}">
                            <input type="hidden" name="party" value="{{ search['PartyAffiliation'] }}">
                            <input type="hidden" name="phoneNumber" value="{{ search['PhoneNumber'] }}">
                            <input type="hidden" name="email" value="{{ search['Email'] }}">
                            <button class="btn btn-primary btn-block" type="submit" name="type" value="Lookup">Lookup</button>
                        </form>

                    </td>
                    <td>
                        <form action="/searches" METHOD="POST" enctype = "multipart/form-data" onsubmit="return confirm('Do you really want to delete that search?');">
                            <input type="hidden" name="SearchID" value="{{ search['ID'] }}">
                            <button class="btn btn-danger btn-block" type="submit">DELETE</button>
                        </form>
                    </td>
                </tr>
            
            %end
        </tbody>
   </table>

</div>
% include('footer.tpl')