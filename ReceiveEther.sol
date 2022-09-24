// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ReceiveEther {
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // Ether alma fonks. msg.data bos olmali
    receive() external payable {}

    // Fallback function cagrilir when msg.data bos olmadiginda
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // bu yontem onerilmez
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // islemin basari veya basarisizligiyla ilgili bool deger dondurur
        // bu yontem onerilmez
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // cagrinin basari veya basarisizligi hakkinda bool deger dondurur
        // Ether gondermek icin bu yontem tercih edilir.
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
