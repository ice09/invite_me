from ethereum.utils import sha3
from web3 import Web3, HTTPProvider
import sys, urllib.request, codecs, json

def verify(me):
    try:
        r = urllib.request.urlopen("https://{0}.keybase.pub/ethereum.json".format(me))
        data = json.loads(r.read().decode(r.info().get_param('charset') or 'utf-8'))
    except:
        return "ERROR: Cannot load https://{0}.keybase.pub/ethereum.json".format(me)
        raise
    print("\nmsghash   : ", "0x" + str(codecs.encode(sha3(data['proofString']), "hex"), "utf8"))
    print("sign_hex  : ", codecs.decode(data['signature'][2:], "hex"))
    print("address   : ", data['address'] + "\n")
    abi = json.loads(abi_def())
    try:
        web3 = Web3(HTTPProvider('http://127.0.0.1:8542'))
        web3.personal.unlockAccount(web3.eth.accounts[1], '');
        con = web3.eth.contract(abi=abi, address='0x15BB295ACE4063044230D83c178Ce3F782619c0E');
        res = con.transact({"from": web3.eth.accounts[1]}).register(me, data['address'], sha3(data['proofString']), codecs.decode(data['signature'][2:], "hex"))
        web3.personal.unlockAccount(web3.eth.accounts[1], '');
        return web3.eth.sendTransaction({"from": web3.eth.accounts[1], "to": data['address'], "value": "100000000000000000000"})
    except:
        return "ERROR:" + str(sys.exc_info()[0]) + "\nHave you already registered?"
        raise

def abi_def():
    return """[
{
  "constant": false,
  "inputs": [
    {
      "name": "username",
      "type": "string"
    }
  ],
  "name": "unregister",
  "outputs": [],
  "payable": false,
  "type": "function"
},
{
  "constant": true,
  "inputs": [],
  "name": "myUsername",
  "outputs": [
    {
      "name": "",
      "type": "string"
    }
  ],
  "payable": false,
  "type": "function"
},
{
  "constant": false,
  "inputs": [
    {
      "name": "a",
      "type": "address"
    }
  ],
  "name": "changeOwner",
  "outputs": [],
  "payable": false,
  "type": "function"
},
{
  "constant": true,
  "inputs": [
    {
      "name": "u",
      "type": "string"
    }
  ],
  "name": "getAddress",
  "outputs": [
    {
      "name": "",
      "type": "address"
    }
  ],
  "payable": false,
  "type": "function"
},
{
  "constant": true,
  "inputs": [
    {
      "name": "a",
      "type": "address"
    }
  ],
  "name": "getUsername",
  "outputs": [
    {
      "name": "",
      "type": "string"
    }
  ],
  "payable": false,
  "type": "function"
},
{
  "constant": false,
  "inputs": [
    {
      "name": "username",
      "type": "string"
    },
    {
      "name": "hash",
      "type": "bytes32"
    },
    {
      "name": "signature",
      "type": "bytes"
    }
  ],
  "name": "registerSender",
  "outputs": [
    {
      "name": "",
      "type": "bool"
    }
  ],
  "payable": false,
  "type": "function"
},
{
  "constant": false,
  "inputs": [
    {
      "name": "username",
      "type": "string"
    },
    {
      "name": "addr",
      "type": "address"
    },
    {
      "name": "hash",
      "type": "bytes32"
    },
    {
      "name": "signature",
      "type": "bytes"
    }
  ],
  "name": "register",
  "outputs": [
    {
      "name": "",
      "type": "bool"
    }
  ],
  "payable": false,
  "type": "function"
},
{
  "inputs": [],
  "payable": false,
  "type": "constructor"
},
{
  "anonymous": false,
  "inputs": [
    {
      "indexed": false,
      "name": "username",
      "type": "string"
    },
    {
      "indexed": false,
      "name": "addr",
      "type": "address"
    }
  ],
  "name": "Registered",
  "type": "event"
},
{
  "anonymous": false,
  "inputs": [
    {
      "indexed": false,
      "name": "username",
      "type": "string"
    },
    {
      "indexed": false,
      "name": "addr",
      "type": "address"
    }
  ],
  "name": "Unregistered",
  "type": "event"
}
]"""
