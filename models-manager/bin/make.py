#execfile( "./concat_js.py" )
from concat_js import *

for p in os.listdir( "models.coffee" ):
    concat_js( "models.coffee/" + p, "models/" + p + ".js" )
