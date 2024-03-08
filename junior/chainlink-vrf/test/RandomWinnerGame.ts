import { ethers } from "hardhat";
import { expect } from "chai";
import {
  FEE,
  KEY_HASH,
  SUBSCRIPTION_ID,
  VRF_COORDINATOR,
} from "../constants/index";

describe("RandomWinnerGame", function () {
  it("RandomWinnerGame Should deploy", async function () {
    const gameContractFactory = await ethers.getContractFactory("RandomWinnerGame");
    const gameContract = await gameContractFactory.deploy(VRF_COORDINATOR, KEY_HASH, FEE, SUBSCRIPTION_ID);
    expect(await gameContract.maxPlayers()).to.equal(10);
    expect(await gameContract.subscriptionId()).to.equal(SUBSCRIPTION_ID);
    expect(await gameContract.gameStarted()).to.equal(false);
  });

});
