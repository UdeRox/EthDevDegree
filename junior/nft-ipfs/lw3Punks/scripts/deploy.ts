//@ts-ignore
// @ts-nocheck
import { formatEther, parseEther } from "viem";
import hre from "hardhat";
require("dotenv").config({ path: ".env" });

async function main() {
  const metadataURL = "ipfs://QmZfziXWDFCoLxJ2NTdSqqwYRJSV32ViAzLBfpVoDiWbyt";
  const myAddress = "0x86F2414fe645e4e5d16aC7f3590C0D739F881AC4"
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const unlockTime = BigInt(currentTimestampInSeconds + 60);

  const lockedAmount = parseEther("0.001");

  // const lock = await hre.viem.deployContract("Lock", [unlockTime], {
  //   value: lockedAmount,
  // });
  const lw3Punks = await hre.viem.deployContract("LW3Punks", [myAddress, metadataURL]);

  await sleep(30000);

  console.log(
    `Lock with ${formatEther(
      lockedAmount
    )}ETH and unlock timestamp deployed to ${lw3Punks.address}`
  );

  await hre.run("verify:verify", {
    address: lw3Punks.target,
    constructorArguments: [myAddress, metadataURL],
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
