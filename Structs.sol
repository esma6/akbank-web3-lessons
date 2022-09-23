// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function examples() external {
        //struct baslatmanin uc yolu var
        Car memory toyota = Car("Toyota", 1990, msg.sender); // parametre sirasi onemli
        Car memory lambo = Car({model: "Lamborghini", year: 1980, owner: msg.sender}); // sira onemsiz
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari",2020, msg.sender));

        // memory gecici
        //storage kalici
        // Ethereum Sanal Makinesi üzerindeki her işlem
        // bize bir miktar Gas'a mal olur. Gas tüketimi
        // ne kadar düşükse, Solidity kodunuz o kadar iyidir.
        // Memorynin Gas tüketimi, Storagenin gas tüketimine 
        // kıyasla çok önemli değildir. Bu nedenle, ara hesaplamalar
        // için memeory kullanmak ve nihai sonucu storage'da saklamak her zaman daha iyidir.
        Car storage _car = cars[0];
        _car.model;
        _car.year = 1999;
        delete _car.owner;

        delete cars[1];
    }
}