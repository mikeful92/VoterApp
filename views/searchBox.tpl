<div class="well">
    <div class="row">
        <div class="col-lg-4">
            <ul>
                <li>Fields are NOT case-senstive</li>
                <li>All non-date fields accept multiple wildcard(*)</li>
            </ul>
        </div>
        <div class="col-lg-4">
            <ul>
                <li>Address 1 and 2 try to find a close match if no wild cards are used</li>
                <li>Zipcode and Birth year can take multiple values separated by comma(,)</li>
            </ul>
        </div>
        <div class="col-lg-4">
            <ul>
                <li>Date fields can accept month only, year only or month and year</li>
                <li>Phone is more accurate when search by 7 digits, but can search for 10 digits</li>
            </ul>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-lg-10 col-lg-offset-1">
        <div class="well">
            
            <form class="form" action="/listVoter" METHOD="POST" enctype = "multipart/form-data" style="margin-bottom: 0;">
            <div class="row">
                <div class="col-lg-2">
                    <div class="form-group">
                        <input type="text" class="form-control input" name="firstName" placeholder="First Name" value="{{ get('firstName','') }}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="lastName" placeholder="Last Name" value="{{ get('lastName','') }}">
                    </div>
                    <div class="form-group">
                        <input type="text"  class="form-control input"name="middleName" placeholder="Middle Name" value="{{ get('middleName','') }}">
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="form-group">
                        <input type="text"  title="Single wildcard(*) for non-empty searches. Multi wildcard (*) can be used"
                        class="form-control input masterTooltip" name="residenceAddress1" placeholder="Residence Address" value="{{ get('residenceAddress','') }}">
                    </div>
                    <div class="form-group">
                        <input type="text"  class="form-control input" name="residenceAddress2" placeholder="Residence Address 2" value="{{ get('residenceAddress2','') }}" >
                    </div>
                    <div class="form-group">
                        <input type="text"  class="form-control input" name="city" placeholder="City" value="{{ get('city','') }}">
                    </div>
                    <div class="form-group">
                        <select class="form-control input" name="countyCode" >
                            <option value='PAL' selected>Palm Beach</option>
                            <option value=''> Statewide </option>
                            <option value='BRO'>Broward</option>
                            <option value='MRT'>Martin</option>
                            <option value='STL'>St. Lucie</option>
                            <option value='ALA'>Alachua</option>
                            <option value='BAK'>Baker</option>
                            <option value='BAY'>Bay</option>
                            <option value='BRA'>Bradford</option>
                            <option value='BRE'>Brevard</option>
                            <option value='BRO'>Broward</option>
                            <option value='CAL'>Calhoun</option>
                            <option value='CHA'>Charlotte</option>
                            <option value='CIT'>Citrus</option>
                            <option value='CLA'>Clay</option>
                            <option value='CLL'>Collier</option>
                            <option value='CLM'>Columbia</option>
                            <option value='DAD'>Miami-Dade</option>
                            <option value='DES'>Desoto</option>
                            <option value='DIX'>Dixie</option>
                            <option value='DUV'>Duval</option>
                            <option value='ESC'>Escambia</option>
                            <option value='FLA'>Flagler</option>
                            <option value='FRA'>Franklin</option>
                            <option value='GAD'>Gadsden</option>
                            <option value='GIL'>Gilchrist</option>
                            <option value='GLA'>Glades</option>
                            <option value='GUL'>Gulf</option>
                            <option value='HAM'>Hamilton</option>
                            <option value='HAR'>Hardee</option>
                            <option value='HEN'>Hendry</option>
                            <option value='HER'>Hernando</option>
                            <option value='HIG'>Highlands</option>
                            <option value='HIL'>Hillsborough</option>
                            <option value='HOL'>Holmes</option>
                            <option value='IND'>Indian River</option>
                            <option value='JAC'>Jackson</option>
                            <option value='JEF'>Jefferson</option>
                            <option value='LAF'>Lafayette</option>
                            <option value='LAK'>Lake</option>
                            <option value='LEE'>Lee</option>
                            <option value='LEO'>Leon</option>
                            <option value='LEV'>Levy</option>
                            <option value='LIB'>Liberty</option>
                            <option value='MAD'>Madison</option>
                            <option value='MAN'>Manatee</option>
                            <option value='MRN'>Marion</option>
                            <option value='MRT'>Martin</option>
                            <option value='MON'>Monroe</option>
                            <option value='NAS'>Nassau</option>
                            <option value='OKA'>Okaloosa</option>
                            <option value='OKE'>Okeechobee</option>
                            <option value='ORA'>Orange</option>
                            <option value='OSC'>Osceola</option>
                            <option value='PAL'>PalmBeach</option>
                            <option value='PAS'>Pasco</option>
                            <option value='PIN'>Pinellas</option>
                            <option value='POL'>Polk</option>
                            <option value='PUT'>Putnam</option>
                            <option value='SAN'>SantaRosa</option>
                            <option value='SAR'>Sarasota</option>
                            <option value='SEM'>Seminole</option>
                            <option value='STJ'>St.Johns</option>
                            <option value='STL'>St.Lucie</option>
                            <option value='SUM'>Sumter</option>
                            <option value='SUW'>Suwannee</option>
                            <option value='TAY'>Taylor</option>
                            <option value='UNI'>Union</option>
                            <option value='VOL'>Volusia</option>
                            <option value='WAK'>Wakulla</option>
                            <option value='WAL'>Walton</option>
                            <option value='WAS'>Washington</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="zipCode" placeholder="ZipCode" value="{{ get('zipCode','') }}">
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="form-group">
                        <input type="text" class="form-control input" name="birthMonth" placeholder="Birth Month" value="{{ get('birthMonth','') }}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="birthYear" placeholder="Birth Year" value="{{ get('birthYear','')}}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="regMonth" placeholder="Reg. Month" value="{{ get('regMonth','') }}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="regYear" placeholder="Reg. Year" value="{{ get('regYear','')}}">
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="form-group">
                        <select class="form-control input" name="gender">
                            %if defined('gender'):
                                % if gender == "M":
                                    <option value="">Any Gender</option>
                                    <option value="M" selected>Male</option>
                                    <option value='F'>Female</option>
                                    <option value="U">Unknown</option>
                                %end
                                % if gender == 'F':
                                    <option value="">Any Gender</option>
                                    <option value="M">Male</option>
                                    <option value='F' selected>Female</option>
                                    <option value="U">Unknown</option>
                                %end
                                % if gender == '':
                                    <option value="" selected>Any Gender</option>
                                    <option value="M">Male</option>
                                    <option value='F'>Female</option>
                                    <option value="U">Unknown</option>
                                %end
                                % if gender == 'U':
                                    <option value="" >Any Gender</option>
                                    <option value="M">Male</option>
                                    <option value='F'>Female</option>
                                    <option value="U" selected>Unknown</option>
                                %end
                            %end
                            %if not defined('gender'):
                                <option value="" selected>Any Gender</option>
                                <option value="M">Male</option>
                                <option value='F'>Female</option>
                                <option value="U">Unknown</option>
                            %end
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control input" name="race">
                            %if defined('race'):
                                % if race == "":
                                    <option value="" selected>Any Race</option>
                                    <option value="1">American Indian</option>
                                    <option value='2'>Asian</option>
                                    <option value="3">Black</option>
                                    <option value="4">Hispanic</option>
                                    <option value="5">White</option>
                                    <option value="6">Other</option>
                                    <option value="7">Multi-racial</option>
                                    <option value="9">Unknown</option>
                                %end
                                % if race == '1':
                                    <option value="">Any Race</option>
                                    <option value="1" selected>American Indian</option>
                                    <option value='2'>Asian</option>
                                    <option value="3">Black</option>
                                    <option value="4">Hispanic</option>
                                    <option value="5">White</option>
                                    <option value="6">Other</option>
                                    <option value="7">Multi-racial</option>
                                    <option value="9">Unknown</option>
                                %end
                                % if race == '2':
                                    <option value="">Any Race</option>
                                    <option value="1" >American Indian</option>
                                    <option value='2'selected>Asian</option>
                                    <option value="3">Black</option>
                                    <option value="4">Hispanic</option>
                                    <option value="5">White</option>
                                    <option value="6">Other</option>
                                    <option value="7">Multi-racial</option>
                                    <option value="9">Unknown</option>
                                %end
                                % if race == '3':
                                    <option value="">Any Race</option>
                                    <option value="1">American Indian</option>
                                    <option value='2'>Asian</option>
                                    <option value="3" selected>Black</option>
                                    <option value="4">Hispanic</option>
                                    <option value="5">White</option>
                                    <option value="6">Other</option>
                                    <option value="7">Multi-racial</option>
                                    <option value="9">Unknown</option>
                                %end
                                % if race == '4':
                                    <option value="">Any Race</option>
                                    <option value="1">American Indian</option>
                                    <option value='2'>Asian</option>
                                    <option value="3">Black</option>
                                    <option value="4" selected>Hispanic</option>
                                    <option value="5">White</option>
                                    <option value="6">Other</option>
                                    <option value="7">Multi-racial</option>
                                    <option value="9">Unknown</option>
                                %end
                                % if race == '5':
                                    <option value="">Any Race</option>
                                    <option value="1">American Indian</option>
                                    <option value='2'>Asian</option>
                                    <option value="3">Black</option>
                                    <option value="4">Hispanic</option>
                                    <option value="5" selected>White</option>
                                    <option value="6">Other</option>
                                    <option value="7">Multi-racial</option>
                                    <option value="9">Unknown</option>
                                %end
                                % if race == '6':
                                    <option value="">Any Race</option>
                                    <option value="1">American Indian</option>
                                    <option value='2'>Asian</option>
                                    <option value="3">Black</option>
                                    <option value="4">Hispanic</option>
                                    <option value="5">White</option>
                                    <option value="6" selected>Other</option>
                                    <option value="7">Multi-racial</option>
                                    <option value="9">Unknown</option>
                                %end
                                % if race == '7':
                                    <option value="">Any Race</option>
                                    <option value="1">American Indian</option>
                                    <option value='2'>Asian</option>
                                    <option value="3">Black</option>
                                    <option value="4">Hispanic</option>
                                    <option value="5">White</option>
                                    <option value="6">Other</option>
                                    <option value="7" selected>Multi-racial</option>
                                    <option value="9">Unknown</option>
                                %end
                                % if race == '9':
                                    <option value="">Any Race</option>
                                    <option value="1">American Indian</option>
                                    <option value='2'>Asian</option>
                                    <option value="3">Black</option>
                                    <option value="4">Hispanic</option>
                                    <option value="5">White</option>
                                    <option value="6">Other</option>
                                    <option value="7">Multi-racial</option>
                                    <option value="9" selected>Unknown</option>
                                %end
                            %end
                            %if not defined('race'):
                                <option value="" selected>Any Race</option>
                                <option value="1">American Indian</option>
                                <option value='2'>Asian</option>
                                <option value="3">Black</option>
                                <option value="4">Hispanic</option>
                                <option value="5">White</option>
                                <option value="6">Other</option>
                                <option value="7">Multi-racial</option>
                                <option value="9">Unknown</option>
                            %end
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control input" name="party">
                            %if defined('party'):
                                % if party == "":
                                    <option value="" selected>Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option>                                            
                                %end
                                % if party == 'DEM':
                                    <option value="">Any Pary</option>
                                    <option value="DEM" selected>Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'NPA':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA" selected>No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'REP':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP" selected>Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'AIP':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP" selected>American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'CPF':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF" selected>Constitution Party of Florida</option>                                           
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'ECO':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO" selected>Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'GRE':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE" selected>Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'IDP':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP" selected>Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'INT':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT" selected>Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'LPF':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF" selected>Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'PSL':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL" selected>Party for Socialism and Liberation - Florida</option>
                                    <option value="REF">Reform Party</option> 
                                %end
                                % if party == 'REF':
                                    <option value="">Any Pary</option>
                                    <option value="DEM">Florida Democratic Party</option>
                                    <option value="NPA">No Party Affiliation</option>
                                    <option value="REP">Republican Party of Florida</option>
                                    <option value="AIP">American’s Party of Florida</option>
                                    <option value="CPF">Constitution Party of Florida</option>                                            
                                    <option value="ECO">Ecology Party of Florida</option>
                                    <option value="GRE">Green Party of Florida</option>
                                    <option value="IDP">Independence Party of Florida</option>
                                    <option value="INT">Independent Party of Florida</option>
                                    <option value="LPF">Libertarian Party of Florida</option>                                            
                                    <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                    <option value="REF" selected>Reform Party</option> 
                                %end
                            %end
                            %if not defined('party'):
                                <option value="" selected>Any Pary</option>
                                <option value="DEM">Florida Democratic Party</option>
                                <option value="NPA">No Party Affiliation</option>
                                <option value="REP">Republican Party of Florida</option>
                                <option value="AIP">American’s Party of Florida</option>
                                <option value="CPF">Constitution Party of Florida</option>                                            
                                <option value="ECO">Ecology Party of Florida</option>
                                <option value="GRE">Green Party of Florida</option>
                                <option value="IDP">Independence Party of Florida</option>
                                <option value="INT">Independent Party of Florida</option>
                                <option value="LPF">Libertarian Party of Florida</option>                                            
                                <option value="PSL">Party for Socialism and Liberation - Florida</option>
                                <option value="REF">Reform Party</option> 
                            %end
                        </select>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="form-group">
                        <input type="text" class="form-control input" name="phoneNumber" placeholder = "Phone" value = "{{get ('phoneNumber','')}}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="email" placeholder = "E-mail" value = "{{get ('email','')}}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="voterID" placeholder="Voter ID" value="{{ get('voterID','') }}">
                    </div>
                </div>
                <div class="col-lg-1">
                    <button class="btn btn-primary btn-block" type="submit" name="type" value="Lookup">Lookup</button>
                    <button class="btn btn-primary btn-block" type="submit" name="type" value="Export">Export</button>
                    <button class="btn btn-primary btn-block" type="submit" name="type" value="SaveSearch">Save</button>
                    <input type="text" class="form-control input" name="searchName" placeholder="Search Name">
                </div>
            </div>
            </form>
        </div>
    </div>
</div>