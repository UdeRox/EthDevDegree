import { expect } from "chai";
import { ethers } from "hardhat";
import { Calculator } from "../typechain-types";

describe("Calculator add function", () => {
  let calculatorContract: Calculator;
  beforeEach(async () => {
    const calculatorContractFactor = await ethers.getContractFactory(
      "Calculator"
    );
    calculatorContract =
      (await calculatorContractFactor.deploy()) as Calculator;
  });

  it("Should add two numbers", async () => {
    const a = 1;
    const b = 2;
    const expectedResult = a + b;
    await calculatorContract.add(a, b);
    expect(await calculatorContract.result()).to.equal(expectedResult);
  });

  it("Should read the initial value", async () => {
    const result = await calculatorContract.result();
    expect(result).to.equal(0);
  });
});
