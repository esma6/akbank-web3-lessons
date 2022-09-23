// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ViewAndPure {
    uint public num;

    function viewFunc() external view returns (uint) {
        return num;
    }
    function pureFunc() external pure returns (uint) {
        return 1;
    }

    // view function cunku state degiskeni okumus num
    function addToNum(uint x) external view returns (uint) {
        return num + x;
    }
    // pure function cunku state degiskeni almamis
    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }
}