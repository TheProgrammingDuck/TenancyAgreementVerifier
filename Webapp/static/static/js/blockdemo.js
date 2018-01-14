function beginClaim(details, tenant_address){


    var TenancyContract = window.web3.eth.contract(tenancyContractABI());

    var core = TenancyContract.at('0x250be4dc2186e6fd7d060e7f4e78a233dadfcc8d');

    core.beginClaim(details, tenant_address, {from:window.web3.eth.accounts[0], gas:400000}, function(err){
    });
    console.log('Claim against Tenant:' + tenant_address + 'initiated');


}
