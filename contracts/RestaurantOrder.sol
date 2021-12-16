// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract RestaurantOrder {
    uint256 totalOrders;
    uint256 private seed;

    event NewOrder(
        address indexed from,
        uint256 timestamp,
        uint256 tableSize,
        string drink,
        string appetizer,
        string main
    );

    struct Order {
        uint256 tableSize;
        string drink;
        string appetizer;
        string main;
        uint256 timestamp;
    }

    struct OrderInput {
        uint256 tableSize;
        string drink;
        string appetizer;
        string main;
    }

    Order[] orders;

    constructor() payable {
        console.log("This is my first contract!");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function placeOrder(OrderInput memory _order) public {
        totalOrders += 1;

        uint256 orderTime = block.timestamp;

        orders.push(
            Order(
                _order.tableSize,
                _order.drink,
                _order.appetizer,
                _order.main,
                orderTime
            )
        );

        seed = (block.difficulty + orderTime + seed) % 100;

        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            // refund user some ether
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewOrder(
            msg.sender,
            orderTime,
            _order.tableSize,
            _order.drink,
            _order.appetizer,
            _order.main
        );
    }

    function getAllOrders() public view returns (Order[] memory) {
        return orders;
    }

    function getTotalOrders() public view returns (uint256) {
        return totalOrders;
    }
}
