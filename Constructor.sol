// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Constructor {
    address public owner;
    uint public x;
    
    constructor(uint _x) {
        owner = msg.sender; // sozlesmeyi deploy ettigimiz hesabin adresini owner'a atar.
        x = _x; // constructor parametre olarak aldigi _x'i state olan x degiskenine atar.
    }
}