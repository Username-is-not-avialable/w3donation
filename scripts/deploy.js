const hre = require("hardhat");

async function main() {
    const Storage = await hre.ethers.getContractFactory("Storage");
    const storage = await Storage.deploy();
    console.log("SimpleStorage deployed to:", storage.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
