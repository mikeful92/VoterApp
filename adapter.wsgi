import sys, os, bottle

sys.path = ['/var/www/VoterApp/'] + sys.path
os.chdir(os.path.dirname(__file__))

import voterServer # This loads your application

application = bottle.default_app()