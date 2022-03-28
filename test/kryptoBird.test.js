const {assert} = require('chai');

// eslint-disable-next-line no-undef
const KryptoBird = artifacts.require("Kryptobird");

require('chai')
.use(require('chai-as-promised'))
.should()

// eslint-disable-next-line no-undef
contract('KryptoBird', async function (accounts) {
  let contract;
    describe('deployment', async () => {
      it('deploy successfully', async () => {
        contract = await KryptoBird.deploy();
        const address = contract.address; 
        
      });
    });

  })