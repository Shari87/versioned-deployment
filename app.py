from flask import Flask, jsonify

app = Flask(__name__)


@app.route('/version/<float:num>', methods=['GET'])
def display_version(num):
    """
    :param num: a float argument to display the current version of the app
    :return: a json output which displays the current version
    """
    return jsonify({'The version is': num})


if __name__ == '__main__':
    app.run(debug=True)
