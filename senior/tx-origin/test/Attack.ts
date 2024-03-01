import { expect } from "chai";
import { ethers } from "hardhat";

describe("tx.origin", () => {
  it("Attack.sol will be able to change the owner of Good.sol", async () => {
    const [_, address1] = await ethers.getSigners();
    const goodContractFactory = await ethers.getContractFactory("Good");
    const good = await goodContractFactory.connect(address1).deploy();

    const attackContractFactory = await ethers.getContractFactory("Attack");
    const attackContract = await attackContractFactory
      .connect(address1)
      .deploy(good.getAddress());
    const txn = await attackContract.attack();
    expect(await good.owner()).to.equal(await attackContract.getAddress());
  });
});
