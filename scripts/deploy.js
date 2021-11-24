const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log('Deploying contracts with account: ', deployer.address);
  console.log('Account balance: ', accountBalance.toString());

  const orderContractFactory = await hre.ethers.getContractFactory('RestaurantOrder');
  const orderContract = await orderContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.001'),
  });
  await orderContract.deployed();

  console.log('RestaurantOrder address: ', orderContract.address);
};

main();
