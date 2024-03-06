//@ts-ignore
// @ts-nocheck
import { ethers } from "hardhat";
const { SUBSCRIPTION_ID,FEE,OWNER, VRF_COORDINATOR, LINK_TOKEN, KEY_HASH } = require("../constants");

async function main() {
  const randomWinnerGame = await ethers.deployContract("RandomWinnerGame", [
    VRF_COORDINATOR,
    KEY_HASH,
    FEE,
    SUBSCRIPTION_ID
  ]);

  await randomWinnerGame.waitForDeployment();

  console.log(` deployed to ${randomWinnerGame.target}`);
  await sleep(30000);
  await hre.run("verify:verify", {
    address: randomWinnerGame.target,
    constructorArguments: [VRF_COORDINATOR, KEY_HASH, FEE, SUBSCRIPTION_ID],
  });

  function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
