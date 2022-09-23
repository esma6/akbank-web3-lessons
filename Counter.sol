// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Counter {
    uint public count;
    
    //view veya pure olarak tanimlamadik cunku state degiskenini degistiriyoruz
    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }

}