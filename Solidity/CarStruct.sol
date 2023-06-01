// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract CarStruct{
    struct Car{
        address owner;
        string model;
        uint year;
    }
    Car public car;
    Car[] public cars;
    mapping (address => Car[]) addressByOwner;

    function examples() public   {
        Car memory toyota = Car(msg.sender, "Toyota", 1990);
        Car memory lambo = Car({model:"Lambo", owner:msg.sender, year:1991});
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2003;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);
        cars.push(Car(msg.sender, "Ferrari", 2005));

        delete tesla.owner;

        Car storage _car = cars[0];
        _car.year = 1997;
    }   

    
}
