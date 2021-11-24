const main = async () => {
  const restaurantOrderFactory = await hre.ethers.getContractFactory(
    "RestaurantOrder"
  );
  const orderContract = await restaurantOrderFactory.deploy();
  await orderContract.deployed();

  let orderTxn = await orderContract.placeOrder({
    tableSize: 1,
    drink: "Coca Cola",
    appetizer: "Salad",
    main: "Steak & Potatoes",
  });
  await orderTxn.wait();

  const [_, randomPerson] = await hre.ethers.getSigners();
  waveTxn = await orderContract.connect(randomPerson).placeOrder({
    tableSize: 2,
    drink: "Pepsi",
    appetizer: "Fries",
    main: "Burger",
  });

  const totalOrders = await orderContract.getTotalOrders();
  console.log(`${totalOrders} order(s) placed in total`);

  const orders = await orderContract.getAllOrders();
  console.log(orders);
}

main();
