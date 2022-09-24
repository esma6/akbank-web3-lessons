// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


library Math {
    //lib tanimlama kisiti, state degisken kullanamiyoruz.
    // internal fonksiyonu sozlesmeye gomer.
    // internal yerine public yapsaydik sozlesme deploy olduktan sonra
    //ayrica kutuphaneyi de dagitmamiz gerekirdi.
    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
}

contract Test {
    function testMax(uint x, uint y) external pure returns(uint) {
        return Math.max(x, y);
    }
}

library ArrayLib {
    function find(uint[] storage arr, uint x) internal view returns (uint) {
        for(uint i = 0; i < arr.length; i++) {
            if(arr[i] == x) {
                return i;
            }
        }
        // revert gasdan tasaruf saglar, sayi dizide yoksa gasi geri alir.
        revert("not found");
    } 
}

// state veriable icin lib kullanimi
contract TestArray {

    using ArrayLib for uint[];
    uint[] public arr = [3,2,1];

    //diziden eleman bulacagimiz icin view yazdik
    function testFind() external view returns (uint) {
        // return ArrayLib.find(arr, 2);
         return arr.find(2);
    }
}