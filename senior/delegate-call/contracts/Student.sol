// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Student {
    uint public mySum;
    address public studenAddress;

    function addTwoNumbers(
        address calclulator,
        uint a,
        uint b
    ) public returns (uint) {
        (bool sucess, bytes memory result) = calclulator.delegatecall(
            abi.encodeWithSignature("add(uint256,uint256)", a, b)
        );
        require(sucess, "Calculator add Numbers failed");
        return abi.decode(result, (uint));
    }
}
