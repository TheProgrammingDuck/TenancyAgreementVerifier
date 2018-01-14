pragma solidity ^0.4.13;

import './TenancyCoin.sol';

contract TenancyContract {

    uint noOfClaims = 0;   
    uint voterFee = 0;

    struct Voter {
        bool hasVoted; //default is false
    }

    struct Tenant {
        bytes32 name;   // short name (up to 32 bytes)
        uint totalOwed;
        uint paidBond;
        bool hasVal; // default value is false
        mapping(address => Voter) voters;
        uint voteCount;
    }

    struct Claim {
        //True == Completed, False == Pending
        bool claimStatus;   
        string claimDetails;
        uint256 claimEnd;
        address tenantAddress;
    }

    mapping(uint => Claim) public claims;
    mapping(address => Tenant) public tenants;
    mapping(address => bool) public decisionMap;
    address public landlord;
    uint public bondPrice;
    uint256 voteTenant = 0;
    uint256 voteLandOwner = 0;
    TenancyCoin public token;
    address public owner;


    event LogPaymentMade(address accountAddress, uint amount);
    event LogAddTenant(address tenantAddress, bytes32 nameToAdd);

    function TenancyContract(uint _bondPrice){
        bondPrice = _bondPrice;
        owner = msg.sender;
        token = createTokenContract();

    }
  
    //We add a tenant to the tenants dictionary. The key of the tenant key-value pair is the address of the tenant.
    function addTenant(address t, bytes32 nameToAdd) {
        require((msg.sender == landlord) && (!tenants[t].hasVal));

        mapping(address => Voter) tempVoters;

        LogAddTenant(t, nameToAdd);
        tenants[t] = Tenant({
            name: nameToAdd, 
            paidBond: bondPrice,
            hasVal: true,
            voters: tempVoters,
            voteCount: 0
        });
    }

    //Can only be done by the Landlord
    function beginClaim(string apparantDetails, address atenantAddress){

        claims[noOfClaims] = Claim({
            claimStatus: false,
            claimDetails: apparantDetails,
            claimEnd: block.length + 10,
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
    //If vote==false, vote is for landowner. If vote==true, vote is for the tenant.
    function arbitrate(address _tenantAddress, bool vote){

            if(!vote){
                voteLandOwner = voteLandOwner + 1;
            }

            else {
                voteTenant = voteTenant + 1;
            }

        tenants[_tenantAddress].voters[msg.sender].hasVoted = true;
        //The voter gets paid for making their vote.
        _payVoter(_tenantAddress);

    }

    //Called when a disagreement has occurred between the tenant and the landlord. After voters are done voting on the issue, a decision is made based on the vote results.
    //ONLY RUN BY THE LANDLORD
    function makeDecision(uint claimID) onlyLandlord{
        //TODO: alter require so that the competition ends after a fixed amount of time not a voteCount
       require(claims[claimID].claimEnd >= block.length);
    
        if(voteLandOwner >= voteTenant){
            //transfer money to the person that calls makeDecision Currently
            msg.sender.transfer(tenants[claims[claimID].tenantAddress].paidBond);
            //decisionMap[msg.sender] = true;
        }
        //TODO: fix clean
        _clean(claimID);

    }

    //TODO:when a tenenant leaves give them deposit back
    function tenantLeave(){

    }


    //Empties the votes
    //TODO:MAKEITWORK
    function _clean(uint claimID) internal {

        claims[claimID].claimStatus = true;

        voteTenant = 0;
        voteLandOwner = 0;

    }

    //Empties the "voters" dictionary.
    //As this is called by the tenant when a new dispute occurs, we need the tenant address to be passed in as an argument.
    function renewVote(address _address, uint claimID){
        require(claims[claimID].claimEnd >= block.length);
        tenants[_address].voters[msg.sender].hasVoted = false;
    }

    //Each voter gets 1% of the Bond. 
    //We reduce 
    function _payVoter(address _tenantAddress) internal{

        //Note: New smartcontract instance per landlord. 
        //Voter Fee is only recovered from the landlord as it's the landlord that has the bond/deposit.
        voterFee += tenants[_tenantAddress].paidBond/100;
        token.mint(msg.sender, 10);

        tenants[_tenantAddress].paidBond -= voterFee;

    }

    //Withdraw from landlord after voters get paid. (This is our fee.)
    function withdrawFunds(address ourAddress) onlyOwner{
    	ourAddress.transfer(voterFee);
    	voterFee = 0;

    }

    function createTokenContract() internal returns (MintableToken) {
        return new TenancyCoin();
    }

    function setLandlord(address lord){
    	landlord = lord;
    }

     modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

     modifier onlyLandlord {
        require(msg.sender == landlord);
        _;
    }


}