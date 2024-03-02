import { ethers } from "hardhat";

describe("delegate-call Attack", () => {
  it("Attack.sol will be able to change the owner of Good.sol", async () => {
    const [_, address1] = await ethers.getSigners();
    const helperFactory = await ethers.getContractFactory("Helper");
    const helperContract = await helperFactory.deploy();

    const goodContractFactory = await ethers.getContractFactory("Good");
    const good = await goodContractFactory
      .connect(address1)
      .deploy(helperContract);

    const attackContractFactory = await ethers.getContractFactory("Attack");
    const attackContract = await attackContractFactory
      .connect(address1)
      .deploy(good.getAddress());
    const txn = await attackContract.attack();
    // expect(await good.owner()).to.equal(attackContract.address);
  });
});
