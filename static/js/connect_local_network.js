async function addHardhatNetwork() {
    try {
        await ethereum.request({
            method: "wallet_addEthereumChain",
            params: [{
                // chainId: "0x539", // Chain ID 1337 в hex
                chainId: "0x7A69", // Chain ID 31337 в hex
                chainName: "Hardhat",
                rpcUrls: ["http://127.0.0.1:8545"],
                nativeCurrency: {
                    name: "ETH",
                    symbol: "ETH",
                    decimals: 18
                }
            }]
        });
        console.log("Hardhat network added to MetaMask!");
    } catch (error) {
        console.error("Failed to add network:", error);
    }
}
