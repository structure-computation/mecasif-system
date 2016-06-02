#execfile( "./concat_js.py" )
from concat_js import *

models = []

for p in os.listdir( "models.coffee" ):
    concat_js( "models.coffee/" + p, "gen/" + p + ".js" )
    models.append("gen/" + p + ".js")

exec_cmd( "echo > gen/models.js " )

for m in sorted(models):
    exec_cmd( "cat gen/models.js " + m + " > gen/models_tmp.js" )
    exec_cmd( "mv gen/models_tmp.js gen/models.js" )