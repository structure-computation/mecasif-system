#execfile( "./concat_js.py" )
from concat_js import *

for p in os.listdir( "views.coffee" ):
    concat_js( "views.coffee/" + p, "gen/" + p + ".js" )
