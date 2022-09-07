import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();

const { ALCHEMY_API_KEY_MUMBAI } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  networks: {
    mumbai: {
      url: ALCHEMY_API_KEY_MUMBAI,
      accounts: [
        "8bde43799f301447ab03e6e25f3db094599b15acf836077c1d98a9b66aa8c37d",
      ],
    },
  },
};

export default config;
