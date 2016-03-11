% include('header.tpl')
<div class="row">
    <div class="col-lg-10 col-lg-offset-1">
        <div class="well">
            % if defined('count'):
                <div class="panel">
                    <p>Total results: {{count['COUNT(*)']}}</p>
                </div>
            % end
            <table id="results" class="table table-striped display">
                <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Middle Name</th>
                        <th>Last Name</th>
                        <th>Suffix</th>
                        <th>Address Line 1</th>
                        <th>Address Line 2</th>
                        <th>City</th>
                        <th>County</th>
                        <th>Zip Code</th>
                        <th>Voter ID</th>
                        <th>Date of Birth</th>
                        <th>Party</th>
                        <th><button class="btn btn-default btn-xs">Download CSV</button></th>
                    </tr>
                </thead>
                <tbody>
                    %for row in rows:   
                        <tr>
                            <td>{{row['FirstName']}}</td>
                            <td>{{row['MiddleName']}}</td>
                            <td>{{row['LastName']}}</td>
                            <td>{{row['Suffix']}}</td>
                            <td>{{row['AddressLine1']}}</td>
                            <td>{{row['AddressLine2']}}</td>
                            <td>{{row['City']}}</td>
                            <td>{{row['CountyCode']}}</td>
                            <td>{{row['Zipcode']}}</td>
                            <td>{{row['VoterID']}}</td>
                            <td>{{row['BirthDate']}}</td>
                            <td>{{row['PartyAffiliation']}}</td>
                            <td>
                                <form action="/voter/{{row['VoterID']}}" METHOD="GET"  style="margin-bottom: 0;">
                                    <button class="btn btn-primary btn-xs" type="submit">Full Record</button>
                                </form>
                            </td>
                        </tr>
                    %end
                </tbody>
            </table>
        </div>
    </div>
</div>
% include('footer.tpl')
