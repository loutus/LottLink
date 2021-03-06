// const { ethers } = require("hardhat");
const { ethers, upgrades } = require("hardhat");



async function main() {
    const [deployer] = await ethers.getSigners();
  
    // console.log("Owner address:", deployer.address);

    // const ERC20PermitSimple = await ethers.getContractFactory("ERC20PermitSimple");
    // const permitSimple = await ERC20PermitSimple.deploy();
    // console.log("permitSimple Contract Address:", permitSimple.address);

    // const ERC20UUPS = await ethers.getContractFactory("ERC20UUPS");
    // const UUPS = await ERC20UUPS.deploy();
    // console.log("ERC20UUPS Contract Address:", UUPS.address);

    // const CrossChainDAO = await ethers.getContractFactory("CrossChainDAO");
    // const CChDAO = await CrossChainDAO.deploy();
    // console.log("CrossChainDAO Contract Address:", CChDAO.address);

    // const CrossChainNFT = await ethers.getContractFactory("CrossChainNFT");
    // const CCh = await CrossChainNFT.deploy();
    // console.log("CrossChainNFT Contract Address:", CCh.address);

    // const NFTTransparent = await ethers.getContractFactory("NFTTransparent");
    // const Transparent = await upgrades.deployProxy(NFTTransparent);
    // await Transparent.deployed();
    // console.log("NFTTransparent Contract Address:", Transparent.address);

    // const ContData = await ethers.getContractFactory("ContData");
    // const CD = await upgrades.deployProxy(ContData);
    // await CD.deployed();
    // console.log("ContData Contract Address:", CD.address);

    const UserData = await ethers.getContractFactory("UserData");
    const UD = await upgrades.deployProxy(UserData);
    await UD.deployed();
    console.log("UserData Contract Address:", UD.address);

    // const NFTTransparent2 = await ethers.getContractFactory("NFTTransparent");
    // const upgraded = await upgrades.upgradeProxy("0x65A52682Df507552d37FC2235eF2bC7FfD4BF181", NFTTransparent2);
    // console.log("upgraded.");


    // const TransparentUpgradeableProxy = await ethers.getContractFactory("TransparentUpgradeableProxy");
    // const TP = await TransparentUpgradeableProxy.deploy("0xb8d7e8Bc9F8D50d37677cF007c2a4dBe685497D3", "0xc92a7Cf349dD3897c23BbB2BF8150A30d9EbaD58");
    // console.log("TransparentUpgradeableProxy Contract Address:", TP.address);

    // const DAO = await ethers.getContractFactory("DAO");
    // const D = await DAO.deploy();
    // console.log("DAO Contract Address:", D.address);

    // const LOTTPublicNFT = await ethers.getContractFactory("LOTTPublicNFT");
    // const LOTPUB = await LOTTPublicNFT.deploy();
    // console.log("LOTTPublicNFT Contract Address:", LOTPUB.address);

    // const NFTMarket = await ethers.getContractFactory("NFTMarket");
    // const NM = await NFTMarket.deploy();
    // console.log("NFTMarket Contract Address:", NM.address);

    // const UserData = await ethers.getContractFactory("UserData");
    // const UD = await UserData.deploy();
    // console.log("UserData Contract Address:", UD.address);

    // const Consumer = await ethers.getContractFactory("RandomNumberConsumer");
    // const RNC = await Consumer.deploy();
    // console.log("Random Number Consumer Contract Address:", RNC.address);

    // const Register = await ethers.getContractFactory("Register");
    // const R = await Register.deploy();
    // console.log("Register Contract Address:", R.address);

    // const NFTContract = await ethers.getContractFactory("MyToken");
    // const NFT = await NFTContract.deploy();
    // console.log("NFT Contract Address:", NFT.address);

    // const ChanceRoom = await ethers.getContractFactory("ChanceRoom");
    // const ChR = await ChanceRoom.deploy();
    // console.log("ChanceRoom Library Contract Address:", ChR.address);

    // const LOTTTest = await ethers.getContractFactory("LOTTTest");
    // const ERC777Token = await LOTTTest.deploy("LOTTTest777", "LOTT", "100000000000000000000000000", "0xe189BfcC0D6f5f63401B104c1051699C7AA1ae4a");
    // console.log("ERC777Token Contract Address:", ERC777Token.address);

    // const ERC777TestReceiver = await ethers.getContractFactory("ERC777TestReceiver");
    // const Receiver = await ERC777TestReceiver.deploy();
    // console.log("Receiver Contract Address:", Receiver.address);

    // const ERC777TestSender = await ethers.getContractFactory("ERC777TestSender");
    // const Sender = await ERC777TestSender.deploy();
    // console.log("Sender Contract Address:", Sender.address);

    // const Factory = await ethers.getContractFactory("Factory");
    // const F = await Factory.deploy("0x92c3f3b2122b61a50b218df446e2799535fcb519", "0xa175b2bc8028286a1cb68c06c9fc0f57deccc378", "0x3c028e8b052e83d8215c13a16699eac8564432d9", "0x043ca25f2c83862b30eb128d25adc9239464d985");
    // console.log("Factory Contract Address:", F.address);

    // execCommand(`npx hardhat verify --network mumbai ${F.address} ${R.address} ${RNC.address} ${NFT.address} ${ChR.address}`)
    // execCommand(`npx hardhat verify --network mumbai ${RNC.address}`)
    // exeCommand("npx",["hardhat","verify","--network" ,"mumbai" ,F.address,R.address ,RNC.address ,NFT.address ,ChR.address])
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });