const Web3 = require('web3');
const web3 = new Web3('HTTP://127.0.0.1:7545');

const abi =  [
    {
      "inputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "user",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "batchNo",
          "type": "address"
        }
      ],
      "name": "BatchAdded",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "previousOwner",
          "type": "address"
        }
      ],
      "name": "OwnershipRenounced",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "previousOwner",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "newOwner",
          "type": "address"
        }
      ],
      "name": "OwnershipTransferred",
      "type": "event"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "owner",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [],
      "name": "renounceOwnership",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "address",
          "name": "newOwner",
          "type": "address"
        }
      ],
      "name": "transferOwnership",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "address",
          "name": "_caller",
          "type": "address"
        }
      ],
      "name": "authorizeCaller",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "address",
          "name": "_caller",
          "type": "address"
        }
      ],
      "name": "deAuthorizeCaller",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "internalType": "address",
          "name": "_userAddress",
          "type": "address"
        }
      ],
      "name": "getUserRole",
      "outputs": [
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "internalType": "address",
          "name": "_batchNo",
          "type": "address"
        }
      ],
      "name": "getNextAction",
      "outputs": [
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "address",
          "name": "_userAddress",
          "type": "address"
        },
        {
          "internalType": "string",
          "name": "_name",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_contactNo",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_location",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_userType",
          "type": "string"
        }
      ],
      "name": "setUser",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "internalType": "address",
          "name": "_user",
          "type": "address"
        }
      ],
      "name": "getUser",
      "outputs": [
        {
          "internalType": "string",
          "name": "_name",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_contactNo",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_location",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_userType",
          "type": "string"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "internalType": "address",
          "name": "_batchNo",
          "type": "address"
        }
      ],
      "name": "getBatchDetails",
      "outputs": [
        {
          "internalType": "string",
          "name": "producerName",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "seedType",
          "type": "string"
        },
        {
          "internalType": "uint256",
          "name": "quantity",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "string",
          "name": "_producerName",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_seedType",
          "type": "string"
        },
        {
          "internalType": "uint256",
          "name": "_quantity",
          "type": "uint256"
        }
      ],
      "name": "setBatchDetails",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "address",
          "name": "_batchNo",
          "type": "address"
        },
        {
          "internalType": "string",
          "name": "_typeOfSeed",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_fertilizer",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_seedCondtion",
          "type": "string"
        },
        {
          "internalType": "uint256",
          "name": "_quantity",
          "type": "uint256"
        }
      ],
      "name": "setFarmInspector",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "internalType": "address",
          "name": "_batchNo",
          "type": "address"
        }
      ],
      "name": "getInspectorData",
      "outputs": [
        {
          "internalType": "string",
          "name": "typeOfSeed",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "fertilizer",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "seedCondition",
          "type": "string"
        },
        {
          "internalType": "uint256",
          "name": "quantity",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "address",
          "name": "_batchNo",
          "type": "address"
        },
        {
          "internalType": "uint256",
          "name": "_temp",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_germ",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_purification",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_seedMoisture",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_quantity",
          "type": "uint256"
        }
      ],
      "name": "setLabData",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "internalType": "address",
          "name": "_batchNo",
          "type": "address"
        }
      ],
      "name": "getLabData",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "temp",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "germ",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "purification",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "seedMoisture",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "quantity",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "address",
          "name": "_batchNo",
          "type": "address"
        },
        {
          "internalType": "uint256",
          "name": "_quantity",
          "type": "uint256"
        },
        {
          "internalType": "string",
          "name": "_warehouseName",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_transportType",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_date",
          "type": "string"
        }
      ],
      "name": "setDistributorData",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "internalType": "address",
          "name": "_batchNo",
          "type": "address"
        }
      ],
      "name": "getDistributorData",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "quantity",
          "type": "uint256"
        },
        {
          "internalType": "string",
          "name": "wareHouseName",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "transportType",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "date",
          "type": "string"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }
  ]

  const address = '0xb938ef4F0A370b1d9259337ec489B754b7da281d';

  const contract = new web3.eth.Contract(abi,address);


  const main = web3.utils.toChecksumAddress('0x68D1bD2dB10F2Cd80e9E78aabE820d6f460B6c70')
  const user = web3.utils.toChecksumAddress('0x189c57122D0F81c7479317df3Bb974Fd14d57BF7')




//   contract.methods.setBatchDetails('niks1','bmt',12).send({
//       from : main,gas:3000000
//    }).then(function(result){
//        console.log(result);
//    })

// contract.methods.getUser(user).call().then(function(result){
//           console.log(result);
//      })
// contract.methods.getUser(user).call().then(function(result){
//      console.log(result);
//  })
// web3.eth.accounts[0];

//console.log(web3.utils.toChecksumAddress('0x68D1bD2dB10F2Cd80e9E78aabE820d6f460B6c70'))
    