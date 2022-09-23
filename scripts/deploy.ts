import { ethers } from "hardhat";

async function main() {

  const contract = await ethers.getContractFactory("Stake");

  const deployedContract = await contract.deploy();

  deployedContract.deployed();

  console.log("Contract Successfully deployed here:", deployedContract.address)

  // Contract Successfully deployed here: 0xE413D32CAFdA8b04E74f27038D1a162ab362cF4c


  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
