    </body>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="/static/js/bootstrap.min.js"></script>
    <script>
        $(window).load(function() {
            $(".loader").fadeOut("slow");
        })
        $(document).ready(function() {
            $("#results").DataTable({
                "dom": 'lfrtip',
                "lengthMenu": [100, 250, 500]
            });
        } );
    </script>
</html>
