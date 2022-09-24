// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FunctionModifier {
    bool public paused;
    uint public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }
    
    // modifier middleware gibidir.
    // _; ana fonksiyonu cagirir
    modifier whenNotPaused() {
        require(paused == false, "paused");
        _;
    }

    function inc() external whenNotPaused {
        count += 1;
    }
    
    function dec() external whenNotPaused {
        count -= 1;
    }

    modifier cap(uint _x) {
        require(_x < 100, "x >= 100");
        _;
    }
    function incBy (uint _x) external whenNotPaused cap(_x) {
        count += _x;
    }

    modifier sandwich() {
        count += 10;
        // ana fonk cagrilir;
        _;
        // ana fonk islenene kadar burda durulur
        // ana fonk bittikten sonra asagidaki kod calismaya devam eder
        count *= 2;
    }

    function foo() external sandwich {
        count += 1;
    }
}