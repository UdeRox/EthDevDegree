import { expect } from "chai";
import { ethers } from "hardhat";

describe("Attack to the Game", () => {
  it("should attack the Game contract and guess the predefined number", async () => {
    const [sender] = await ethers.getSigners();
    const gameContract = await ethers.getContractFactory("Game");
    const game = await gameContract.deploy({ value: 1 });

    const attackContractFactory = await ethers.getContractFactory("Attack");
    const attackContract = await attackContractFactory.deploy(
      game.getAddress()
    );

    await attackContract.attack();
    expect(await game.getBalance()).to.equal(BigInt(0));
  });
});
