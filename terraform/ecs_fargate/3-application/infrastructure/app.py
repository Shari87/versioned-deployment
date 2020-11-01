"""
A simple restful application to display its current version
"""
__author__ = "Sahajhaksh Hariharan"

from flask import Flask, jsonify

app = Flask(__name__)


@app.route('/<float:version>', methods=['GET']) 
def disp_version(version):
    """
    :param version: a float argument to display the current version of the app
    :return: a json output which displays the current version
    """
    return jsonify({'The version of the app is': version})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
