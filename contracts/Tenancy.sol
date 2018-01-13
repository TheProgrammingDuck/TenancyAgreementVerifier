pragma solidity ^0.4.0;
contract Tenancy {

    struct Tenant {
        bytes32 name;   // short name (up to 32 bytes)
        uint totalOwed;
        uint paidBond;
        bool hasVal; // default value is false
        mapping(address => Voter) public voters;
    }

    struct Voter {
        bool hasVoted; //default is false
    }

    mapping(address => Tenant) public tenants;
    mapping(address => bool) public decisionMap;
    address public landlord;
    uint public totalRentPrice;
    uint256 public voteCount = 0;
    uint256 public voteYes = 0;
    uint256 public voteNo = 0;


    event LogPaymentMade(address accountAddress, uint amount);
    event LogAddTenant(address tenantAddress, bytes32 nameToAdd);

    //The address of the caller of the tenancy function (creator of the tenancy) is made the landlord.
    function Tenancy(uint _totalRentPrice) {
        landlord = msg.sender;
        totalRentPrice = _totalRentPrice;

        //TODO: initialise the coin contract

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
            voters: {}
        });
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
                voteNo = voteNo + 1;

            }

            else {
                voteYes = voteYes + 1;
            }
        }

        tentants[_tenantAddress].voters[msg.sender].hasVoted= true;
        //The voter gets paid for making their vote.
        payVoter();

    }

    //Called when a disagreement has occurred between the tenant and the landlord. After voters are done voting on the issue, a decision is made based on the vote results.
    function makeDecision(){

        require(voteCount >= 2);
        //point of contention
        if(voteYes >= voteNo){
            decisionMap[msg.sender] = true;
        }

        else{
            decisionMap[msg.sender] = false;
        }

        _clean();

    }

    //Empties the votes
    function _clean() internal {

        voteYes = 0;
        voteNo = 0;
        voteCount = 0;

    }

    //Empties the "voters" dictionary.
    //As this is called by the tenant when a new dispute occurs, we need the tenant address to be passed in as an argument.
    function renewVote(address _address){
        tenants[_address].voters={};
    }

    function payVoter(){
        //TODO: Pay the voters 
        
    }


    //TODO: create a way of minting and distributing coins, like a buy function or something like in the crowdsale.sol

}