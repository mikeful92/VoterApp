% include('header.tpl')
<div class="container">
    <div class="well">
        <ul style="list-style-type:none">
            <li><b>2016 Data</b></li>
            <li>Voter ID: {{VoterID}}</li>
            <li>Last Name: {{LastName}}</li>
            <li>Suffix: {{Suffix}}</li>
            <li>First Name: {{FirstName}}</li>
            <li>Middle Name: {{MiddleName}}</li>
            <li>Residence Address: {{AddressLine1}} {{AddressLine2}}</li>
            <li>Residence City: {{City}}</li>
            <li>County Code: {{CountyCode}}</li>
            <li>Residence Zipcode: {{ZipCode}}</li>
            <li>Mailing Address Line 1: {{MailingAddressLine1}}</li>
            <li>Mailing Address Line 2: {{MailingAddressLine2}}</li>
            <li>Mailing Address Line 3: {{MailingAddressLine3}}</li>
            <li>Mailing City: {{MailingCity}}</li>
            <li>Mailing State: {{MailingState}}</li>
            <li>Mailing Zipcode: {{MailingZipcode}}</li>
            <li>Mailing Country: {{MailingCountry}}</li>
            <li>Gender: {{Gender}}</li>
            <li>Race: {{Race}}</li>
            <li>Birth Date: {{BirthDate}}</li>
            <li>Registration Date: {{RegistrationDate}}</li>
            <li>Party: {{Party}}</li>
            <li>Voter Status: {{VoterStatus}}</li>
            <li>Phone Area Code: {{PhoneAreaCode}}</li>
            <li>Phone Number: {{PhoneNumber}}</li>
            <li>Phone Extension: {{PhoneExtension}}</li>
            <li>Email: {{Email}}</li>
        </ul>
        <form action="/address/{{AddressLine1}}" METHOD="GET">
            <button type="submit">Look up Household</button>
        </form>
    </div>
</div>
%include('footer.tpl')
