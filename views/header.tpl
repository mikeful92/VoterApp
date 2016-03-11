<html lang="end">
    <head>
        <title>Voter Lookup</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Latest compiled and minified CSS -->
        <link href="/static/css/bootstrap.min.css" rel="stylesheet">
        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="/static/css/main.css">
        <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
    </head>
    <body>
        <nav class="navbar navbar-default navbar-static-top">
            <div class="container">
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a class="navbar-brand" href="/">Florida Voter Search</a></li>
                    </ul>
                </div>
            </div>
        </nav> 
        <div class="row">
            <div class="col-lg-10 col-lg-offset-1">
                <div class="well">
                    
                    <form class="form-inline" action="/listVoter" METHOD="POST" style="margin-bottom: 0;">
                    <div class="row">
                        <div class="col-lg-1 col-lg-offset-1">
                            <div class="input-group">
                                <input type="text" class="form-control input" name="firstName" placeholder="First Name" value="{{ get('firstName','') }}">
                            </div>
                        </div>
                        <div class="col-lg-1">
                            <div class="input-group">
                                <input type="text" class="form-control input" name="lastName" placeholder="Last Name" value="{{ get('lastName','') }}">
                            </div>
                        </div>
                        <div class="col-lg-1">
                            <div class="input-group">
                                <input type="text"  class="form-control input"name="middleName" placeholder="Middle Name" value="{{ get('middleName','') }}">
                            </div>
                        </div>
                        <div class="col-lg-1">
                            <div class="input-group">
                                <select class="form-control input" name="countyCode">
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
                        </div>
                        <div class="col-lg-1">
                            <div class="input-group">
                                <input type="text" class="form-control input" name="voterID" placeholder="Voter ID" value="{{ get('voterID','') }}">
                            </div>
                        </div>
                        <div class="col-lg-1">
                            <div class="input-group">
                                <input type="text" class="form-control input" name="birthMonth" placeholder="Birth Month">
                            </div>
                        </div>
                        <div class="col-lg-1">
                            <div class="input-group">
                                <input type="text" class="form-control input" name="birthYear" placeholder="Birth Year">
                            </div>
                        </div>
                        <div class="col-lg-1">
                            <div class="input-group">
                                <input type="text" class="form-control input" name="zipCode" placeholder="ZipCode" value="{{ get('zipCode','') }}">
                            </div>
                        </div>
                        <div class="col-lg-1 col-lg-offset-1">
                            <button class="btn btn-primary btn-block" type="submit">Lookup</button>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="container">
            % if defined('error'):
                <div class="alert alert-danger" role="alert">
                    {{error}}
                </div>
            % end
        </div>

