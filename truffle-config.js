module.exports = {

  networks: {
    development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 7545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    }
  },
  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis',
  compilers: {
    solc: {
      version: "^0.8.11",    // Fetch exact version from solc-bin (default: truffle's version) - last version ">=0.4.22 <0.9.0"
      optimizer: {
        enable: true,
        runs: 200 // depends on the project
      }
    }
  }
};
