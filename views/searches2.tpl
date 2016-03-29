% include('header.tpl')
%for search in searches: 
    <div class="well">
        <div class="row">
            <form class="form" action="/listVoter" METHOD="POST" enctype = "multipart/form-data" style="margin-bottom: 0;">
                <div class="col-lg-2">                
                    <div class="form-group">
                        <input type="text" class="form-control input" name="firstName" placeholder="First Name" value="{{ search['FirstName'] }}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="lastName" placeholder="Last Name" value="{{ search['LastName'] }}">
                    </div>
                    <div class="form-group">
                        <input type="text"  class="form-control input"name="middleName" placeholder="Middle Name" value="{{ search['MiddleName']}}">
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="form-group">
                        <input type="text"  class="form-control input masterTooltip" name="residenceAddress1" placeholder="Residence Address" value="{{ search['AddressLine1'] }}">
                    </div>
                    <div class="form-group">
                        <input type="text"  class="form-control input" name="residenceAddress2" placeholder="Residence Address 2" value="{{ search['AddressLine2']}}" >
                    </div>
                    <div class="form-group">
                        <input type="text"  class="form-control input" name="city" placeholder="City" value="{{ search['City'] }}">
                    </div>
                    <!--
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
                -->
                    <div class="form-group">
                        <input type="text" class="form-control input" name="zipCode" placeholder="ZipCode" value="{{ search['Zipcode'] }}">
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="form-group">
                        <input type="text" class="form-control input" name="birthMonth" placeholder="Birth Month" value="{{search['BirthMonth']}}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="birthYear" placeholder="Birth Year" value="{{search['BirthYear']}}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="regMonth" placeholder="Reg. Month" value="{{search['RegMonth']}}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="regYear" placeholder="Reg. Year" value="{{search['RegYear']}}">
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="form-group">
                        <select class="form-control input" name="gender">
                            % if search['Gender'] == "M":
                                <option value="">Any Gender</option>
                                <option value="M" selected>Male</option>
                                <option value='F'>Female</option>
                                <option value="U">Unknown</option>
                            %end
                            % if search['Gender'] == 'F':
                                <option value="">Any Gender</option>
                                <option value="M">Male</option>
                                <option value='F' selected>Female</option>
                                <option value="U">Unknown</option>
                            %end
                            % if search['Gender'] == '':
                                <option value="" selected>Any Gender</option>
                                <option value="M">Male</option>
                                <option value='F'>Female</option>
                                <option value="U">Unknown</option>
                            %end
                            % if search['Gender'] == 'U':
                                <option value="" >Any Gender</option>
                                <option value="M">Male</option>
                                <option value='F'>Female</option>
                                <option value="U" selected>Unknown</option>
                            %end
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control input" name="race">
                            % if search['Race'] == "":
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
                            % if search['Race'] == '1':
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
                            % if search['Race'] == '2':
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
                            % if search['Race'] == '3':
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
                            % if search['Race'] == '4':
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
                            % if search['Race'] == '5':
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
                            % if search['Race'] == '6':
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
                            % if search['Race'] == '7':
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
                            % if search['Race'] == '9':
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
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control input" name="party">
                            % if search['PartyAffiliation'] == "":
                                <option value="" selected>Any Party</option>
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
                            % if search['PartyAffiliation'] == 'DEM':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'NPA':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'REP':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'AIP':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'CPF':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'ECO':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'GRE':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'IDP':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'INT':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'LPF':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'PSL':
                                <option value="">Any Party</option>
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
                            % if search['PartyAffiliation'] == 'REF':
                                <option value="">Any Party</option>
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
                        </select>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="form-group">
                        <input type="text" class="form-control input" name="phoneNumber" placeholder = "Phone" value = "{{search['PhoneNumber']}}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="email" placeholder = "E-mail" value = "{{search['Email']}}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input" name="voterID" placeholder="Voter ID" value="{{search['VoterID']}}">
                    </div>
                </div>
                <div class="col-lg-1">
                    <button class="btn btn-primary btn-block" type="submit" name="type" value="Lookup">Lookup</button>
                </div>
            </form>
            <form action="/searches2" METHOD="POST" enctype = "multipart/form-data" style="margin-bottom: 0;">
                <input type="hidden" name="SearchID" value="{{ search['ID'] }}">
                <button class="btn btn-primary btn-xs" type="submit">DELTE</button>
            </form>
        </div>
    </div>
%end
% include('footer.tpl')