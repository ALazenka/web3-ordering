// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract RestaurantOrder {
  uint256 totalOrders;

  event NewOrder(address indexed from, uint256 timestamp);

  struct Order {
    uint tableSize;
    string drink;
    string appetizer;
    string main;
    uint256 timestamp;
  }

  struct OrderInput {
    uint tableSize;
    string drink;
    string appetizer;
    string main;
  }

  Order[] orders;

  constructor() {
    console.log("This is my first contract!");
  }

  function placeOrder(OrderInput memory _order) public {
    totalOrders += 1;

    orders.push(
      Order(
        _order.tableSize,
        _order.drink,
        _order.appetizer,
        _order.main,
        block.timestamp
      )
    );

    emit NewOrder(msg.sender, block.timestamp);
  }

  function getAllOrders() public view returns (Order[] memory) {
    return orders;
  }

  function getTotalOrders() public view returns (uint256) {
    return totalOrders;
  }
}
