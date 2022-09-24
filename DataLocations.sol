// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Data locations - storage, memory and calldata

// storage ,durum degiskeni
// memory ,bellege yuklenmis veri
// calldata ,fonksiyon inputlari icin
contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples(uint[] calldata y, string calldata s) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});

        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "foo";

        MyStruct memory readOnly = myStructs[msg.sender];
        readOnly.foo = 456;

        _internal(y);

        uint[] memory memArr = new uint[](3);
        memArr[0] = 234;
        return memArr;
    }

    // calldata degistirilemez ve gasdan tasaruf.

    function _internal(uint[] calldata y) private {
        uint x = y[0];
    }
}