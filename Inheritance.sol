// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

// bir contract diger bi contracti 'is' kullanarak miras alir.
contract B is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

// Contracts birden cok parent contracttan miras alabilir.

contract D is B, C {
    // D.foo() returns "C"
    function foo() public pure override(B, C) returns (string memory) {
        return super.foo();
    }
}

contract E is C, B {
    // E.foo() returns "B"
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();
    }
}

// A ve B'nin sirasini degistirmek hata verir, temeleden derine seklinde siralanmali.
contract F is A, B {
    function foo() public pure override(A, B) returns (string memory) {
        return super.foo();
    }
}
