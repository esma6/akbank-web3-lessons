// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract StateVariables {
    //state variable fonksiyon disinda tanimlanir
    //blockchainde tutulur
    uint public myUint = 123;

    function foo() external {
        // global degisken fonksiyon icinde tanimlanir
        //blockchainde saklanmaz
        uint notStateVariable = 456;
    }
}