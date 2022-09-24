pragma solidity ^0.8.7;
// SPDX-License-Identifier: MIT

contract FeeCollector { // 
    address public owner;
    uint256 public balance;
    
    constructor() {
        owner = msg.sender; // contracti deploy edenin bilgilerini tutuyoruz
    }
    
    //smart contract'a para gonderildiginde calisacak fonksiyon
    receive() payable external {
        //msg.value degiskeni sayesinde contracta gonderilen para miktarina erisiriz
        balance += msg.value; //contract'da depolanan para miktarini hesaplariz
    }
    
    //girilen adres ve miktar bilgilerini alan transfer fonks.
    function withdraw(uint amount, address payable destAddr) public {
        //fonksiyonu cagiran kisi islevin sahibi ise para cekme islemi yapilir
        //eger degilse false doner ve fonksiyondaki geri kalan islemler de durur 
        require(msg.sender == owner, "Only owner can withdraw");
        require(amount <= balance, "Insufficient funds");
        
        destAddr.transfer(amount); // verilen adrese para gonderir
        balance -= amount; //transfer edilen miktar bakiyeden dusulur.
    }
}