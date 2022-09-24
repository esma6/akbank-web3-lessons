// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Diğer sözleşmelerle etkileşim kurmak için call fonksiyonu kullanılır.
// Bu, fallback fonksiyonunu çağırarak yalnızca Ether gönderirken kullanılması önerilen yöntemdir. 
// Ancak, mevcut fonksiyonlari çağırmak için önerilen yol değildir.


contract Receiver {
    event Received(address caller, uint amount, string message);

    fallback() external payable {
        emit Received(msg.sender, msg.value, "Fallback was called");
    }

    function foo(string memory _message, uint _x) public payable returns (uint) {
        emit Received(msg.sender, msg.value, _message);

        return _x + 1;
    }
}

contract Caller {
    event Response(bool success, bytes data);
     // Caller contract için kaynak koda sahip olmadığını düşünelim.
     // contract recivier, ancak contract recivierin adresini ve çağrılacak fonk biliyoruz.
    function testCallFoo(address payable _addr) public payable {
        // ether gonderebilir ve ozel bir gas miktari belirleyebiliriz
        (bool success, bytes memory data) = _addr.call{value: msg.value, gas: 5000}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );

        emit Response(success, data);
    }

    //Var olmayan bi fonksiyonu cagirmak falback fonksiyonunu tetikler
    function testCallDoesNotExist(address _addr) public {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("doesNotExist()")
        );

        emit Response(success, data);
    }
}
