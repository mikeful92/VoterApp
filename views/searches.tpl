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
                <th>Data Year</th>
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

                    <td>{{search['DataYear']}}</td>
                    
                    <td>{{search['Zipcode']}}</td>
                    
                    <td>{{search['BirthMonth']}}</td>
                    
                    <td>{{search['BirthYear']}}</td>
                    
                    <td>{{search['RegMonth']}}</td>
                    
                    <td>{{search['RegYear']}}</td>
                    
                    <td>{{search['Gender']}}</td>
                    
                    <td>{{search['Race']}}</td>
                    
                    <td>{{search['Party']}}</td>
                    
                    <td>{{search['PhoneNumber']}}</td>
                    
                    <td>{{search['Email']}}</td>
                    

                    <td>
                        <form class="form" action="/listVoter" METHOD="POST" enctype = "multipart/form-data" style="margin-bottom: 0;">
                            <input type="hidden" name="SearchName" value="{{ search['FirstName'] }}">
                            <input type="hidden" name="FirstName" value="{{ search['FirstName'] }}">
                            <input type="hidden" name="LastName" value="{{ search['LastName'] }}">
                            <input type="hidden" name="MiddleName" value="{{ search['MiddleName'] }}">
                            <input type="hidden" name="AddressLine1" value="{{search['AddressLine1']}}">
                            <input type="hidden" name="AddressLine2" value="{{search['AddressLine2']}}">
                            <input type="hidden" name="City" value="{{ search['City'] }}">
                            <input type="hidden" name="CountyCode" value="{{ search['CountyCode'] }}">
                            <input type="hidden" name="DataYear" value="{{ search['DataYear'] }}">
                            <input type="hidden" name="ZipCode" value="{{ search['Zipcode'] }}">
                            <input type="hidden" name="BirthMonth" value="{{ search['BirthMonth'] }}">
                            <input type="hidden" name="BirthYear" value="{{ search['BirthYear'] }}">
                            <input type="hidden" name="RegMonth" value="{{ search['RegMonth'] }}">
                            <input type="hidden" name="RegYear" value="{{ search['RegYear'] }}">
                            <input type="hidden" name="Gender" value="{{ search['Gender'] }}">
                            <input type="hidden" name="Race" value="{{ search['Race'] }}">
                            <input type="hidden" name="Party" value="{{ search['Party'] }}">
                            <input type="hidden" name="PhoneNumber" value="{{ search['PhoneNumber'] }}">
                            <input type="hidden" name="Email" value="{{ search['Email'] }}">
                            <button class="btn btn-primary btn-xs" type="submit" name="type" value="Lookup">Lookup</button>
                        </form>

                    </td>
                    <td>
                        <form action="/searches" METHOD="POST" enctype = "multipart/form-data" onsubmit="return confirm('Do you really want to delete that search?');" style="margin-bottom: 0;">
                            <input type="hidden" name="SearchID" value="{{ search['ID'] }}">
                            <button class="btn btn-danger btn-xs" type="submit">DELETE</button>
                        </form>
                    </td>
                </tr>
            
            %end
        </tbody>
   </table>

</div>
% include('footer.tpl')