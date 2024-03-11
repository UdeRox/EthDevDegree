import { ethers } from "hardhat";
import { expect } from "chai";

describe("", () => {    
    it("", async () => {
        const Attact = await ethers.getContractFactory("Attact");
        const attact = await Attact.deploy();
        await attact.deployed();
        expect(await attact.get()).to.equal(0);
    });
})   