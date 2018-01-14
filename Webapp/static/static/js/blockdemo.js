
	var selectElement = document.getElementById('selectNumber'),

  function populateSelectElement (element, array) {
      var newElement,
          i;
      for(i = 0; i < array.length; i += 1) {
          newElement = document.createElement('option');
          newElement.textContent = optionArray[i];
          newElement.value = optionArray[i];
          element.appendChild(newElement);
      }
  }

  selectElement.addEventListener('click', function() {

  	var noClaims = getNoOfClaims();

  	var optionArray = [];

  	for(i = 0; i < noClaims; i += 1){
  		optionArray.push(i);
  	}

      populateSelectElement(this, optionArray);
  });

  function scrollIntoView(elementID) {
   var e = document.getElementById(elementID);
   if (!!e && e.scrollIntoView) {
       e.scrollIntoView();
   }
}

function report(claimId) {
    //1. Uses claimId to return claim details from blockchain
    //2. Creates a new paragraph in frontend to display it.

    var claimDetails = document.getElementById('blockchainClaimDetails');

    var details = getClaimDetails(claimId);

    claimDetails.textContent = details;

  }

 function generateClaim(details, tenant_address){

    var TenancyContract = window.web3.eth.contract(tenancyContractABI());

    var core = TenancyContract.at('0x250be4dc2186e6fd7d060e7f4e78a233dadfcc8d');

    core.beginClaim(details, tenant_address, {from:window.web3.eth.accounts[0], gas:400000}, function(err){
    });
    console.log('Claim against Tenant:' + tenant_address + 'initiated');
}


function getNoOfClaims(){

  var TenancyContract = window.web3.eth.contract(tenancyContractABI());

  var core = TenancyContract.at('0x250be4dc2186e6fd7d060e7f4e78a233dadfcc8d');

  return (core.noOfClaims.call());
}


function submitVote(tenantAddress, vote){

    var TenancyContract = window.web3.eth.contract(tenancyContractABI());

    var core = TenancyContract.at('0x250be4dc2186e6fd7d060e7f4e78a233dadfcc8d');

    core.arbitrate(tenantAddress, vote, {from:window.web3.eth.accounts[0], gas:400000}, function(err){
    });
    console.log(tenantAddress + 'voted');

}


function setupAgreement(landlordAddress, tenantName, tenantAddress, deposit){

    //IN future do something wacky like instantiate contract etc.    

    var TenancyContract = window.web3.eth.contract(tenancyContractABI());

    var core = TenancyContract.at('0x250be4dc2186e6fd7d060e7f4e78a233dadfcc8d');

    core.addTenant(tenantAddress, tenantName, {from:window.web3.eth.accounts[0], gas:400000}, function(err){
    });
    console.log(tenantName + 'added to the list of tenants');
}


function payDeposit(depositPrice){

    var TenancyContract = window.web3.eth.contract(tenancyContractABI());

    var core = TenancyContract.at('0x250be4dc2186e6fd7d060e7f4e78a233dadfcc8d');

    core.pay({from:window.web3.eth.accounts[0], value: window.web3.toWei(depositPrice, "ether"), gas:400000}, function(err){
    });

    console.log('The deposit has been paid');

}

function makeDecision(claimId){

	var TenancyContract = window.web3.eth.contract(tenancyContractABI());

    var core = TenancyContract.at('0x250be4dc2186e6fd7d060e7f4e78a233dadfcc8d');

    core.makeDecision(claimId, {from:window.web3.eth.accounts[0], value: window.web3.toWei(depositPrice, "ether"), gas:400000}, function(err){
    });

    console.log('Decision has been made, Voting has been closed.');

}

function getClaimDetails(claimId){

	var TenancyContract = window.web3.eth.contract(tenancyContractABI());

    var core = TenancyContract.at('0x250be4dc2186e6fd7d060e7f4e78a233dadfcc8d');

    return (core.claims.call([claimId].claimDetails));
}