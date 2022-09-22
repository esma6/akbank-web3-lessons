// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Data types - values and references
contract Data {
    bool public b = true;
    uint public u = 123; 
    // uint = uint256 0 to 2**256 - 1
    // uint8   0 to 2**8 - 1
    // uint16  0 to 2**16 - 1
    int public i = -123;
    // uint256  0 to 2**255 - 1
    // int128   0 to 2**127 - 1
    int public minInt = type(int).min; // int degerinin en kucuk degerini dondurur
    int public maxInt = type(int).max;
    address public addr;// 0x00000000000000000000000000000000000000000;
    bytes32 public b32; // 0x0000000000000000000000000000000000000000000000000000000000000000;
}