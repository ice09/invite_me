pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "./ThrowProxy.sol";
import "../contracts/KeybaseRegistry.sol";

contract TestKeybaseRegistrySig {
  
  uint public initialBalance = 1 ether;

  function testDoubleRegisterWrongAddr() {
    KeybaseRegistry meta = new KeybaseRegistry();
    address expected = 0x0;
    Assert.equal(meta.getAddress("ice09"), expected, "Address should be empty.");

    ThrowProxy throwProxy = new ThrowProxy(address(meta));
    meta.changeOwner(address(throwProxy));
    
    KeybaseRegistry(address(throwProxy)).register("ice09", 0x000000000000000000000000000000000000dead, '\xb73\x83\xb1\xec\x8a\x04K\x18\x7f\xff\x9e\x0b\xe9\x9e\x02zP\x18ylI\xb9\xc6I\xc7\x14\xcd\xfc\xc91\x10', 'En%\xf7{\xd2\xc9d\x88L\xdb\x96I\xb4\xf8y{{m\x14\xfe\xe7\t\xf8\x06\x94p\xc6Z\x1cT\x8b,\xf6\xce\rB\xdf\xb6\xfflm"ZX\xc1!\x19N|}\x8eJ8B\xe3\x00\x0b\xe0W\xa0\xe8\xc9\xc0\x01');
    bool r = throwProxy.execute.gas(500000)();
    Assert.isFalse(r, "Should be false, as it should throw");

    Assert.equal(meta.getAddress("ice09"), expected, "Address should be empty.");

    KeybaseRegistry(address(throwProxy)).register("ice09", 0xc15f96f1fc1a4099c039945bbe0bb0f6f2a649d9, '\xb73\x83\xb1\xec\x8a\x04K\x18\x7f\xff\x9e\x0b\xe9\x9e\x02zP\x18ylI\xb9\xc6I\xc7\x14\xcd\xfc\xc91\x10', 'En%\xf7{\xd2\xc9d\x88L\xdb\x96I\xb4\xf8y{{m\x14\xfe\xe7\t\xf8\x06\x94p\xc6Z\x1cT\x8b,\xf6\xce\rB\xdf\xb6\xfflm"ZX\xc1!\x19N|}\x8eJ8B\xe3\x00\x0b\xe0W\xa0\xe8\xc9\xc0\x01');
    r = throwProxy.execute.gas(500000)();
    Assert.isTrue(r, "Should be true, as it should not throw");

    expected = 0xc15f96f1fc1a4099c039945bbe0bb0f6f2a649d9;
    Assert.equal(meta.getAddress("ice09"), expected, "Address should not be empty.");
  }
    
}
