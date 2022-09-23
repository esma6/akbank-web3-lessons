// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract forAndWhileLoops {
    function loops() external pure {
        for (uint i = 0; i < 10; i++){
            if (i == 4) {
                continue; //4'u atlar
            }
            if ( i == 5) {
                break;//dongu 5 olunca kirilir, 6,7,8,9 icin calismaz.
            }
        }
        
        uint j = 0;
        while (j < 10) {
            j++;
        }
    }
    function sum(uint _n) external pure returns (uint) {
        uint s;
        //gas maliyeti dongunun boyu arttikca artar
        for(uint i = 0; i <= _n; i++) {
            s += i;
        }
        return s;
    }
}