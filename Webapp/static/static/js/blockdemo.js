function beginClaim(details, tenant_address){

	var selectElement = document.getElementById('selectNumber'),
      //1. Call some smart contract function that returns NoOfCases
      //2. Create OptionArray of that length.

      optionArray = [1, 2, 3, 4, 5];

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
      populateSelectElement(this, optionArray);
  });

function report(claimId) {
    //1. Uses claimId to return claim details from blockchain
    //2. Creates a new paragraph in frontend to display it.

    var claimDetails = document.getElementById('blockchainClaimDetails');
    claimDetails.textContent = "potato";

  }

    var TenancyContract = window.web3.eth.contract(tenancyContractABI());

    var core = TenancyContract.at('0x250be4dc2186e6fd7d060e7f4e78a233dadfcc8d');

    core.beginClaim(details, tenant_address, {from:window.web3.eth.accounts[0], gas:400000}, function(err){
    });
    console.log('Claim against Tenant:' + tenant_address + 'initiated');


}
