pragma solidity ^0.4.0;
contract LandLordContract {

    struct Tenant {
        bytes32 name;   // short name (up to 32 bytes)
        uint totalOwed;
        uint paidBond;
        bool hasVal; // default value is false
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

    function LandLordContract(uint _totalRentPrice) {
        landlord = msg.sender;
        totalRentPrice = _totalRentPrice;
    }

    function addTenant(address t, bytes32 nameToAdd, uint owed, uint paid) {
        require((msg.sender == landlord) && (!tenants[t].hasVal));

        LogAddTenant(t, nameToAdd);
        tenants[t] = Tenant({
            name: nameToAdd,
            totalOwed: owed,
            paidBond: paid,
            hasVal: true
        });
    }

    function pay() public payable returns (uint) {
        tenants[msg.sender].paidBond += msg.value;
        LogPaymentMade(msg.sender, msg.value);
        return tenants[msg.sender].totalOwed - tenants[msg.sender].paidBond;
    }

    function getTenant(address _address) public constant returns (bytes32, uint, uint, bool) {
        return (tenants[_address].name, tenants[_address].totalOwed,
                tenants[_address].paidBond, tenants[_address].hasVal);
    }


    function arbitrate(bool vote){
        if(voters[msg.sender] == false){

            voteCount = voteCount + 1;

            if(!vote){
                voteNo = voteNo + 1;

            }

            else {
                voteYes = voteYes + 1;
            }
        }

        voters[msg.sender] = true;

    }

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

    function _clean() internal {

        voteYes = 0;
        voteNo = 0;
        voteCount = 0;

    }


    function renewVote(){
        
    }

}