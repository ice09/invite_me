pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "./ThrowProxy.sol";
import "../contracts/KeybaseRegistry.sol";

contract TestKeybaseRegistryDeployed {
  
  uint public initialBalance = 1 ether;

  function testDoubleRegisterDeployedWrongMsgSender() {
    KeybaseRegistry meta = KeybaseRegistry(DeployedAddresses.KeybaseRegistry());
    address expected = 0x0;
    Assert.equal(meta.getAddress("ice09"), expected, "Address should be empty.");

    //https://repl.it/languages/python3
    //print (codecs.decode("b73383b1ec8a044b187fff9e0be99e027a5018796c49b9c649c714cdfcc93110", "hex"))
    //print (codecs.decode("456e25f77bd2c964884cdb9649b4f8797b7b6d14fee709f8069470c65a1c548b2cf6ce0d42dfb6ff6c6d225a58c121194e7c7d8e4a3842e3000be057a0e8c9c001", "hex"))
    ThrowProxy throwProxy = new ThrowProxy(address(meta));
    KeybaseRegistry(address(throwProxy)).register("ice09", 0xc15f96f1fc1a4099c039945bbe0bb0f6f2a649d9, '\xb73\x83\xb1\xec\x8a\x04K\x18\x7f\xff\x9e\x0b\xe9\x9e\x02zP\x18ylI\xb9\xc6I\xc7\x14\xcd\xfc\xc91\x10', 'En%\xf7{\xd2\xc9d\x88L\xdb\x96I\xb4\xf8y{{m\x14\xfe\xe7\t\xf8\x06\x94p\xc6Z\x1cT\x8b,\xf6\xce\rB\xdf\xb6\xfflm"ZX\xc1!\x19N|}\x8eJ8B\xe3\x00\x0b\xe0W\xa0\xe8\xc9\xc0\x01');
    bool r = throwProxy.execute.gas(500000)();
    Assert.isFalse(r, "should throw, wrong msg.sender");
  }
}
