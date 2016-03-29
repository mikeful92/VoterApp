% include('header.tpl')
<div class="well">
   <table class="table">
        <thead>
            <tr>
                <th>Search Name</th>
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
            </tr>
        </thead>
        <tbody>
            %for search in searches:
            <form class="form" action="/listVoter" METHOD="POST" enctype = "multipart/form-data">
                <tr>
                    <td>{{search['SearchName']}}</td>
                    <td>{{search['FirstName']}}</td>
                    <input type="hidden" name="firstName" value="{{ search['FirstName'] }}">
                    <td>{{search['LastName']}}</td>
                    <input type="hidden" name="lastName" value="{{ search['LastName'] }}">
                    <td>{{search['MiddleName']}}</td>
                    <input type="hidden" name="middleName" value="{{ search['MiddleName'] }}">
                    <td>{{search['AddressLine1']}}</td>
                    <input type="hidden" name="residenceAddress1" value="{{search['AddressLine1']}}">
                    <td>{{search['AddressLine2']}}</td>
                    <input type="hidden" name="residenceAddress2" value="{{search['AddressLine2']}}">
                    <td>{{search['City']}}</td>
                    <input type="hidden" name="city" value="{{ search['City'] }}">
                    <td>{{search['CountyCode']}}</td>
                    <input type="hidden" name="countyCode" value="{{ search['CountyCode'] }}">
                    <td>{{search['Zipcode']}}</td>
                    <input type="hidden" name="zipCode" value="{{ search['Zipcode'] }}">
                    <td>{{search['BirthMonth']}}</td>
                    <input type="hidden" name="birthMonth" value="{{ search['BirthMonth'] }}">
                    <td>{{search['BirthYear']}}</td>
                    <input type="hidden" name="birthYear" value="{{ search['BirthYear'] }}">
                    <td>{{search['RegMonth']}}</td>
                    <input type="hidden" name="regMonth" value="{{ search['RegMonth'] }}">
                    <td>{{search['RegYear']}}</td>
                    <input type="hidden" name="regYear" value="{{ search['RegYear'] }}">
                    <td>{{search['Gender']}}</td>
                    <input type="hidden" name="gender" value="{{ search['Gender'] }}">
                    <td>{{search['Race']}}</td>
                    <input type="hidden" name="race" value="{{ search['Race'] }}">
                    <td>{{search['PartyAffiliation']}}</td>
                    <input type="hidden" name="party" value="{{ search['PartyAffiliation'] }}">
                    <td>{{search['PhoneNumber']}}</td>
                    <input type="hidden" name="phoneNumber" value="{{ search['PhoneNumber'] }}">
                    <td>{{search['Email']}}</td>
                    <input type="hidden" name="email" value="{{ search['Email'] }}">

                    <td><button class="btn btn-primary btn-block" type="submit" name="type" value="Lookup">Lookup</button></form></td>
                    <td>
                        <form action="/searches" METHOD="POST" enctype = "multipart/form-data">
                            <input type="hidden" name="SearchID" value="{{ search['ID'] }}">
                            <button class="btn btn-primary btn-block" type="submit">DELETE</button>
                        </form>
                    </td>
                </tr>
            
            %end
        </tbody>
   </table>

</div>
% include('footer.tpl')