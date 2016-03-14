    </body>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="/static/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#results").DataTable({
                "dom": 'lBfrtip',
                "buttons": ['copy','csv','excel','print']
            });
        } );
    </script>
</html>

