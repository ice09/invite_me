# invite_me
Middleware component for keybase.io identity verification for onboarding in private PoA-testnets

## system overview

the system consists of two components:

1. registry: the smart contract to register the keybase user/ethereum address pair
2. verifier: the python middleware component to read ethereum.json, verify the signature and send 100 ETH if verification successful

### registry

#### Prerequisites


1. Install [Truffle](http://truffleframework.com)
2. Connect your own node to the [DemoPoA-testnet](https://github.com/paritytech/parity/wiki/Demo-PoA-tutorial)

```
poa: {
    host: "localhost",
    port: 8542,
    network_id: "*"
}
```

#### Setup

1. Deploy contracs to PoA-testnet with `truffle migrate --poa`
