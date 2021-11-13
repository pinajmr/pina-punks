const deploy = async() => {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contract with the account:", deployer.address);
    const PinaPunks = await ethers.getContractFactory("PinaPunks");
    const deployed = await PinaPunks.deploy(["0xExample", "0xExample2"], [60, 40]);
    console.log("Pina Punks is deployed at:", deployed.address);
    
};

deploy()
.then(() => process.exit(0))
.catch((error) => {
    console.error(error);
    process.exit(1);
});