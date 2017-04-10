pragma solidity ^0.4.6;

import "./ECVerify.sol";

contract KeybaseRegistry {

  address private owner;

  mapping (address => string) private usernames;
  mapping (string => address) private addresses;

  event Registered(string username, address addr);
  event Unregistered(string username, address addr);

  function KeybaseRegistry() {
    owner = msg.sender;
  }
  
  function changeOwner(address a) {
    if (owner != msg.sender)
      throw;
    owner = a;
  }

  function getUsername(address a) public constant returns (string) {
    return usernames[a];
  }

  function getAddress(string u) public constant returns (address) {
    return addresses[u];
  }

  function myUsername() public constant returns (string) {
    return getUsername(msg.sender);
  }

  function registerSender(string username, bytes32 hash, bytes signature) public returns (bool) {
    return register(username, msg.sender, hash, signature);
  }

  function register(string username, address addr, bytes32 hash, bytes signature) public returns (bool) {
    if (msg.sender != owner) throw;

    if (checkSignature(hash, signature, addr) != addr) {
        throw;
    }

    if ((bytes(usernames[addr]).length > 0) || (addresses[username] != 0x0)) {
        throw;
    }

    usernames[addr] = username;
    addresses[username] = addr;
    Registered(username, addr);
    return true;
  }

  function unregister(string username) {
    if (msg.sender != owner) throw;

    if (addresses[username] == 0x0) {
        throw;
    }
    Unregistered(username, addresses[username]);
    usernames[addresses[username]] = "";
    addresses[username] = 0x0;
  }

  function checkSignature(bytes32 hash, bytes signature, address addr) private constant returns (address) {
    return ECVerify.ecverify(hash, signature, addr);
  }

}
