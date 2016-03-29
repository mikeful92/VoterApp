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
                <th>Voter ID</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            %for search in searches:
                <tr>
                    <td>{{search['SearchName']}}</td>
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
                    <td>{{search['VoterID']}}</td>

                    <td><button>Lookup</td>
                </tr>
            %end
        </tbody>
   </table>

</div>
% include('footer.tpl')