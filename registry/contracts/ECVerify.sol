// taken from https://gist.github.com/axic/5b33912c6f61ae6fd96d6c4a47afde6d
library ECVerify {
    function safer_ecrecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal returns (bool, address) {
        bool ret;
        address addr;

        assembly {
            let size := mload(0x40)
            mstore(size, hash)
            mstore(add(size, 32), v)
            mstore(add(size, 64), r)
            mstore(add(size, 96), s)

            ret := call(3000, 1, 0, size, 128, size, 32)
            addr := mload(size)
        }

        return (ret, addr);
    }

    function ecrecovery(bytes32 hash, bytes sig) returns (bool, address) {
        bytes32 r;
        bytes32 s;
        uint8 v;

        if (sig.length != 65)
          return (false, 0);

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))

            v := byte(0, mload(add(sig, 96)))
        }

        if (v < 27)
          v += 27;

        if (v != 27 && v != 28)
            return (false, 0);

        return safer_ecrecover(hash, v, r, s);
    }

    function ecverify(bytes32 hash, bytes sig, address signer) returns (address) {
        bool ret;
        address addr;
        (ret, addr) = ecrecovery(hash, sig);
        return addr;
    }

}
