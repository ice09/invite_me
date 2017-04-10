module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    poa: {
      host: "localhost",
      port: 8542,
      network_id: "*"
    }
  }
};
