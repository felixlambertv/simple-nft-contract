import { ethers } from "hardhat";

async function main() {
  const Nft = await ethers.getContractFactory("NFT");
  const nft = await Nft.deploy();
  await nft.deployed();

  console.log(`Deployed at  ${nft.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
