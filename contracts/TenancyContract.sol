pragma solidity ^0.4.13;

import './TenancyCoin.sol';

contract TenancyContract {

    uint claimId; 
    uint noOfClaims = 0;   
    uint voterFee;

    struct Tenant {
        bytes32 name;   // short name (up to 32 bytes)
        uint totalOwed;
        uint paidBond;
        bool hasVal; // default value is false
        mapping(address => Voter) public voters;
        uint voteCount;
    }

    struct Claim {
        //True == Completed, False == Pending
        bool claimStatus;   
        string claimDetails;
        address tenantAddress;
    }

    struct Voter {
        bool hasVoted; //default is false
    }

    mapping(claimId => Claim) public claims;
    mapping(address => Tenant) public tenants;
    mapping(address => bool) public decisionMap;
    address public landlord;
    uint public totalRentPrice;
    uint256 public voteCount = 0;
    uint256 voteTenant = 0;
    uint256 voteLandOwner = 0;
    TenancyCoin public token;


    event LogPaymentMade(address accountAddress, uint amount);
    event LogAddTenant(address tenantAddress, bytes32 nameToAdd);

    //The address of the caller of the tenancy function (creator of the tenancy) is made the landlord.
    function TenancyContract(uint _totalRentPrice) {
        landlord = msg.sender;
        totalRentPrice = _totalRentPrice;

        //TODO: initialise the coin contract
        token = createTokenContract();

    }
  
    //We add a tenant to the tenants dictionary. The key of the tenant key-value pair is the address of the tenant.
    function addTenant(address t, bytes32 nameToAdd, uint owed, uint paid) {
        require((msg.sender == landlord) && (!tenants[t].hasVal));

        LogAddTenant(t, nameToAdd);
        tenants[t] = Tenant({
            name: nameToAdd, 
            totalOwed: owed,
            paidBond: paid,
            hasVal: true,
            voters: {},
            voteCount = 0;
        });
    }

    //Can only be done by the Landlord
    function beginClaim(bool currentClaimStatus, string apparantDetails, address atenantAddress){

        claims[noOfClaims] = Claim({
            claimStatus: currentClaimStatus,
            claimDetails: apparantDetails,
            tenantAddress: atenantAddress
        });

        noOfClaims += 1;

        //returning the claimId
        return (noOfClaims-1);
    }

    //Currently, if the pay function is called by a non-tenant, it will still work by creating a new tenant with that key-value pair.
    //That is not how we want it to work however. We must ensure that this function can only be called if the tenant address is a key in tentants.

    //If msg.value is not defined then it will be 0. (or the caller might get a transaction error).
    function pay() public payable returns (uint) {
        tenants[msg.sender].paidBond += msg.value;
        LogPaymentMade(msg.sender, msg.value);
        return tenants[msg.sender].totalOwed - tenants[msg.sender].paidBond;
    }

    //Returns all the data for a tenant.
    function getTenant(address _address) public constant returns (bytes32, uint, uint, bool) {
        return (tenants[_address].name, tenants[_address].totalOwed,
                tenants[_address].paidBond, tenants[_address].hasVal);
    }

    //The voting function. Called when a user votes for either the tenant or the landlord.
    //This should only be called by the voter, not the landlord or the tenant.
    function arbitrate(address _tenantAddress, bool vote){

            if(!vote){
                voteLandOwner = voteLandOwner + 1;

            }

            else {
                voteTenant = voteTenant + 1;
            }
        }

        tenants[_tenantAddress].voters[msg.sender].hasVoted= true;
        //The voter gets paid for making their vote.
        _payVoter(_tenantAddress);

    }

    //Called when a disagreement has occurred between the tenant and the landlord. After voters are done voting on the issue, a decision is made based on the vote results.
    //ONLY RUN BY THE LANDLORD
    function makeDecision(uint claimID){
        //TODO: alter voteCount for all voting competitions
        require(voteCount >= 2);
        //TODO: voteTenant and voteLandOwner for all voting competitions
        if(voteLandOwner >= voteTenant){
            //transfer money to the person that calls makeDecision Currently
            msg.sender.transfer(tenants[claims[claimID].tenantAddress].paidBond);
            //decisionMap[msg.sender] = true;
        }

        else{
            landlord.transfer(tenants[msg.sender].paidBond);
            //decisionMap[msg.sender] = false;
        }

        _clean();

    }

    //TODO:when a tenenant leaves give them deposit back
    function tenantLeave(){

    }


    //Empties the votes
    function _clean() internal {

        voteTenant = 0;
        voteLandOwner = 0;
        voteCount = 0;

    }

    //Empties the "voters" dictionary.
    //As this is called by the tenant when a new dispute occurs, we need the tenant address to be passed in as an argument.
    function renewVote(address _address){
        tenants[_address].voters={};
    }

    //Each voter gets 1% of the Bond. 
    //We reduce 
    function _payVoter(address _tenantAddress) internal{

        require(msg.sender != 0x0);

        //Note: New smartcontract instance per landlord. 
        //Voter Fee is only recovered from the landlord as it's the landlord that has the bond/deposit.
        voterFee += tenants[_tenantAddress].paidBond/100;
        token.mint(msg.sender, 10);

        tenants[_tenantAddress].paidBond -= voterFee;

    }

    //Withdraw from landlord after voters get paid. (This is our fee.)
    function _withdrawFunds() internal{


    }


    //TODO: create a way of minting and distributing coins, like a buy function or something like in the crowdsale.sol

    function createTokenContract() internal returns (MintableToken) {
        return new TenancyCoin();
    }


}