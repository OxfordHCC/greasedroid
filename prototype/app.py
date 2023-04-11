from flask import Flask, render_template, request, send_from_directory
import os
import pandas as pd
import patch.patches
from utils import initialze, decode, build, sign



app = Flask(__name__)

state = {
    'app_selected' : False,
    'apps_available' : [],
    'app' : '',
    'patches_selected' : False,
    'patches_available' : [],
    'patches_available_desc' : [],
    'patches' : [],
    'dl_show' : False,
        }
config = pd.read_csv("./data/config.csv")

@app.route('/', methods=["GET", "POST"])
def index():
    if state['app_selected'] == False:
        state['apps_available'] = list(os.listdir("./store"))
    if request.method == 'GET':
        if 'reset' in request.args.getlist('reset'):
            # re-initialize values
            state['app_selected'] = False
            state['app'] = ''
            state['patches_selected'] = False
            state['patches'] = []
            state['dl_show'] = False
        if state['app_selected'] == False:
            if request.args.getlist('app') != []:
                state['app_selected'] = True
                state['app'] = request.args.getlist('app')[0]
        if state['app_selected'] == True:
            state['patches_available'] = []; state['patches_available_desc'] = [];
            patches_req = config[config['patch_category'] == 'general']
            [state['patches_available'].append(i) for i in list(patches_req['patch_name'])]
            [state['patches_available_desc'].append(i) for i in list(patches_req['patch_desc'])]
            if 'twitter' in state['app']:
                patches_req = config[config['patch_category'] == 'twitter']
                [state['patches_available'].append(i) for i in list(patches_req['patch_name'])]
                [state['patches_available_desc'].append(i) for i in list(patches_req['patch_desc'])]
        if state['patches_selected'] == False:
            if state['patches_available'] != []:
                state['patches'] = []
                [state['patches'].append(i) for i in state['patches_available'] if str(i) in request.args.getlist(i)]
                print(state['patches'])
                if len(state['patches']) > 0:
                    # decompile
                    initialze(state['app'])
                    decode(state['app'])
                    # perform nth patching operation
                    for patch_func in state['patches']:
                        method_to_call = getattr(patch.patches, patch_func)
                        method_to_call(state['app'])
                        print("[*] Patch: ", patch_func)
                    # build & sign
                    build(state['app'])
                    sign(state['app'])
                    print("[>] Completed Patching.")
                    state['dl_show'] = True




    return render_template('index.html', app_selected = state['app_selected'], apps_available = state['apps_available'], app = state['app'], 
                            patches_selected = state['patches_selected'], patches_available = state['patches_available'], patches_available_desc = state['patches_available_desc'], 
                            dl_show = state['dl_show'])

@app.route('/apk/<filename>')  
def send_file(filename):  
    return send_from_directory("./"+str(filename[:-4])+"/dist/", filename)

if __name__ == '__main__':
    app.run(debug=True)
