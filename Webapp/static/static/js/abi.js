function tenancyContractABI(){
	abi = [ {
      "constant": false,
      "inputs": [],
      "name": "pay",
      "outputs": [],
      "payable": true,
      "stateMutability": "payable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "lord",
          "type": "address"
        }
      ],
      "name": "setLandlord",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "",
          "type": "address"
        }
      ],
      "name": "decisionMap",
      "outputs": [
        {
          "name": "",
          "type": "bool"
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
          "name": "ourAddress",
          "type": "address"
        }
      ],
      "name": "withdrawFunds",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "t",
          "type": "address"
        },
        {
          "name": "nameToAdd",
          "type": "bytes32"
        }
      ],
      "name": "addTenant",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "apparantDetails",
          "type": "string"
        },
        {
          "name": "atenantAddress",
          "type": "address"
        }
      ],
      "name": "beginClaim",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
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
          "name": "claimID",
          "type": "uint256"
        }
      ],
      "name": "makeDecision",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_address",
          "type": "address"
        },
        {
          "name": "claimID",
          "type": "uint256"
        }
      ],
      "name": "renewVote",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "owner",
      "outputs": [
        {
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
      "inputs": [
        {
          "name": "_tenantAddress",
          "type": "address"
        },
        {
          "name": "vote",
          "type": "bool"
        }
      ],
      "name": "arbitrate",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "name": "claims",
      "outputs": [
        {
          "name": "claimStatus",
          "type": "bool"
        },
        {
          "name": "claimDetails",
          "type": "string"
        },
        {
          "name": "claimEnd",
          "type": "uint256"
        },
        {
          "name": "tenantAddress",
          "type": "address"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "bondPrice",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "landlord",
      "outputs": [
        {
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
      "name": "tenantLeave",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "_address",
          "type": "address"
        }
      ],
      "name": "getTenant",
      "outputs": [
        {
          "name": "",
          "type": "bytes32"
        },
        {
          "name": "",
          "type": "uint256"
        },
        {
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "noOfClaims",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
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
          "name": "",
          "type": "address"
        }
      ],
      "name": "token",
      "outputs": [
        {
          "name": "",
          "type": "address"
        },
        {
          "name": "paidBond",
          "type": "uint256"
        },
        {
          "name": "hasVal",
          "type": "bool"
        },
        {
          "name": "voteCount",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "name": "",
          "type": "address"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function",
      "constant": true,
      "name": "tenants",
      "outputs": [
        {
          "name": "name",
          "type": "bytes32"
        },
        {
          "name": "paidBond",
          "type": "uint256"
        },
        {
          "name": "hasVal",
          "type": "bool"
        },
        {
          "name": "voteCount",
          "type": "uint256"
        }
      ]
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "name": "_bondPrice",
          "type": "uint256"
        },
        {
          "indexed": false,
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "LogPaymentMade",
      "type": "constructor",
      "payable": false,
      "stateMutability": "nonpayable"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "name": "accountAddress",
          "type": "address"
        },
        {
          "indexed": false,
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "LogPaymentMade",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "name": "tenantAddress",
          "type": "address"
        },
        {
          "indexed": false,
          "name": "nameToAdd",
          "type": "bytes32"
        }
      ],
      "name": "LogAddTenant",
      "type": "event"
    }];

    return abi;
}