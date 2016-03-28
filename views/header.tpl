<html lang="end">
    <head>
        <title>Voter Lookup</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Latest compiled and minified CSS -->
        <link href="/static/css/bootstrap.min.css" rel="stylesheet">
        <!-- Optional theme -->
        <link rel="stylesheet" href="/static/css/bootstrap-theme.min.css">
        <!-- Main CSS used -->
        <link rel="stylesheet" type="text/css" href="/static/css/main.css">
        <!-- JQuery DataTables CSS -->
        <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
        <!-- Buttons DataTables CSS -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.1.2/css/buttons.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css">
        <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-1.12.0.min.js">
        </script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js">
        </script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.1.2/js/dataTables.buttons.min.js">
        </script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.1.2/js/buttons.html5.min.js">
        </script>
    </head>
    <body>
        <nav class="navbar navbar-default navbar-static-top">
            <div class="container">
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a class="navbar-brand" href="/">Florida Voter Search - v12 - Statewide - March 2016 extract</a></li>
                    </ul>
                </div>
            </div>
        </nav> 
        <div class="container">
            % if defined('error'):
                <div class="alert alert-danger" role="alert">
                    {{error}}
                </div>
            % end
        </div>
        <div class="loader"></div>

