% include('header.tpl')
<div class="row">
    <div class="col-lg-10 col-lg-offset-1">
        <div class="well">
            % if defined('count'):
                <div class="panel">
                    <div class="row">
                        <div class="col-lg-2">
                            <h4>Total results: {{count}}</h4>
                        </div>
                        % if defined('time'):
                            <div class="col-lg-2 col-lg-offset-8">
                                <h4>Search Time: {{time}}</h4>
                            </div>
                        % end
                        </h4>
                    </div>
                </div>
            % end
            <table id="results" class="table table-striped display">
                <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Middle Name</th>
                        <th>Last Name</th>
                        <th>Address Line 1</th>
                        <th>Line 2</th>
                        <th>City</th>
                        <th>County</th>
                        <th>Zip Code</th>
                        <th>Date of Birth</th>
                        <th>Party</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    %for row in rows:   
                        <tr>
                            <td>{{row['FirstName']}}</td>
                            <td>{{row['MiddleName']}}</td>
                            <td>{{row['LastName']}}</td>
                            <td>{{row['AddressLine1']}}</td>
                            <td>{{row['AddressLine2']}}</td>
                            <td>{{row['City']}}</td>
                            <td>{{row['CountyCode']}}</td>
                            <td>{{row['Zipcode']}}</td>
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
