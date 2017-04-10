from bottle import route, run, template
import infrastructure
import invitation
import verification

@route('/invite/<me>')
@infrastructure.allow_cors
def invite(me):
    (priv, pub, address, dumped) = invitation.create_invitation(me)
    return template("<br/><div class='alert alert-warning'><span class='text-danger'>Private Key: <b>{{privk}}</b></span><br/><span class='text-primary'>Ethereum address: <b>{{addr}}</b></span></div><div class='alert alert-info'>Copy & Paste this JSON to <code>KEYBASE_DIR/public/KEYBASE_USER/ethereum.json</code></div><pre>{{jsons}}</pre>", jsons=dumped,privk=(priv.to_string().hex()),pubk=(pub.hex()), addr=("0x" + address))

@route('/load/<me>')
@infrastructure.allow_cors
def load(me):
    result = verification.verify(me)
    return template("{{result}}", result=result)

run(host='0.0.0.0', port=8088, debug=True)
