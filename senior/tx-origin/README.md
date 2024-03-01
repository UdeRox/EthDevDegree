# https://learnweb3.io/degrees/ethereum-developer-degree/senior/never-use-tx-origin-again/

## Descriptions

The attack will happen as follows, initially address1 will deploy Good.sol and will be the owner but the attacker will somehow fool the user who has the private key of address1 to call the attack function with Attack.sol.

When the user calls attack function with address1, tx.origin is set to address1. attack function further calls setOwner function of Good.sol which first checks if tx.origin is indeed the owner which is true because the original transaction was indeed called by address1. After verifying the owner, it sets the owner to Attack.sol

And, thus attacker is successfully able to change the owner of Good.sol 
Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```
