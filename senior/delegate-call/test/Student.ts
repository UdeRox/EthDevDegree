import { expect } from "chai";
import { ethers } from "hardhat";

describe("Student Contract delegate-call", () => {
    it("Should call the deletegate and add function", async () => {
        const studentFactory = await ethers.getContractFactory("Student");
        const student = await studentFactory.deploy();
        const calculatorFactory = await ethers.getContractFactory("Calculator");
        const calculator = await calculatorFactory.deploy();
        await student.addTwoNumbers(calculator.getAddress(), 1, 2);
        expect(await student.mySum()).to.equal(3);
    })
})