// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Event{
    struct Event{
        address organizer;
        string name;
        uint date;
        uint priceOfTicket;
        uint totalTicket;
        uint remainingTicket;
    }
    mapping(uint=>Event) public events;
    mapping(address=>mapping(uint=>uint)) public tickets;
    uint public nextId;
    function createEvent(string memory _name , uint _date, uint _priceOfTicket , uint _totalTicket) public{
        require(_date>block.timestamp,"event time passed!");
        events[nextId]=Event(msg.sender,_name,_date,_priceOfTicket,_totalTicket,_totalTicket);
        nextId++;

    }
    function buyTicket(uint id , uint quantity) public payable{
        require(events[id].date>block.timestamp,"not valied time");
        require(events[id].remainingTicket>=quantity,"no tickit");
        require(msg.value==events[id].priceOfTicket*quantity,"provide correct price");
        events[id].remainingTicket-=quantity;
        tickets[msg.sender][id]+=quantity;
    }
    function transferTicket(uint id , uint quantity,address to) public {
    require(events[id].date>block.timestamp,"not valied time");
    require(events[id].remainingTicket>=quantity,"no tickit");
    tickets[msg.sender][id]-=quantity;
    tickets[to][id]+=quantity;  
    }

}
