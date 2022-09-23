// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// Mappingler çoğunlukla benzersiz Ethereum adresini ilişkili değer türüyle ilişkilendirmek için kullanılır.
// Mappingler,  mapping (keyType => valueType) synatxi ile oluşturulur.
// keyType, herhangi bir built-in value type, bytes, string veya herhangi bir contract olabilir.
// valueType, başka bir mapping veya bir array dahil olmak üzere herhangi bir tür olabilir.
// Mappings not iterable.
// Mappinglerde kaç değerin saklandığını bilebilmemiz için mappingler sayılabilir.


contract Mapping {

    mapping(address => uint) public balances;

    mapping(address => mapping(address => bool)) public isFriend;

    function example() external{
        balances[msg.sender] = 123;
        uint bal = balances[msg.sender];
        uint bal2 = balances[address(1)]; // 0

        balances[msg.sender] += 456; // 123 + 456 = 579

        delete balances[msg.sender]; // 0

        isFriend[msg.sender][address(this)] = true;
    }
}