import os
import re
import sys
import telnetlib
import uuid
from flask import Flask, flash, request, redirect

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    result = ""
    if request.method == "POST":
        username = request.form['user']
        password = request.form['pass']

        regex = re.compile(r'^[a-zA-Z]{3,15}$')
        if regex.match(username) and regex.match(password):
            result = telnet(username, password)
        else:
            result = "Username and/or password does not only contain letters and/or is not between 3 and 15 characters"

    return '''
    <!doctype html>
    <title>Create account</title>
    <ol>
      <li>Install vanilla World of Warcraft patched to v1.12.1 (not the new classic client). Prepatched client found <a href="https://drive.google.com/file/d/1TDoNNUXCtsgIUhLw96biPCqjv3AcLYkg/view">here</a> or <a href="https://mega.nz/#!uYxBWAYb!4bV1pqFl2-zXRS7063GqzAnt53oe5jTcmlVce9CtKPc">here</a></li>
      <li id="realmlist">In World of Warcraft install folder, edit realmlist.wtf: set realmlist </li>
      <li>Create account below (only letters, 3-15 characters in both fields)</li>
      <li>Play game</li>
    </ol>
    <script>document.getElementById("realmlist").innerHTML += location.hostname</script>
    <form method="post">
      Username:<br>
      <input name="user" pattern="[A-Za-z]{3,15}" type="text"><br>
      Password:<br>
      <input name="pass" pattern="[A-Za-z]{3,15}" type="password"><br>
      <input type="submit">
    </form>
    <p>%s</p>
    ''' % result

def telnet(username, password):
    print("Creating account: %s" % username)
    adm_pass = ""
    try:
        f = open("/app/cmangos_adm_pass", "r")
        adm_pass = f.read()
        f.close()
    except:
        pass
    try:
        tn = telnetlib.Telnet("cmangos", "3443", 15)
    except:
        print("Unable to connect to server")
        return "Unable to connect to server"
    print(tn.read_some())
    tn.write("administrator\n".encode('ascii'))
    print(tn.read_some())
    if adm_pass:
        tn.write(("%s\n" % adm_pass).encode('ascii'))
        print(tn.read_some())
    else:
        tn.write("administrator\n".encode('ascii'))
        print(tn.read_some())
        f = open("/app/cmangos_adm_pass", "w")
        new_adm_pass = str(uuid.uuid1())[:15]
        f.write(new_adm_pass)
        f.close()
        tn.write(("account password administrator %s %s\n" % (new_adm_pass, new_adm_pass)).encode('ascii'))
        print(tn.read_some())
    tn.write(("account create %s %s\n" % (username, password)).encode('ascii'))
    data = tn.read_some()[:-9]
    print("Result: " + data.decode('ascii'))
    return data.decode('ascii')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8086, debug=False)
