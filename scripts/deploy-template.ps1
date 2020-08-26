
$rgName = "anftest-"(get-date -format MMddyyyymm)

new-azResourceGroup -name $rgName -location centralus

new-azResourceGroupDeployment -name $rgName `
    -resouceGroupName $rgName `
    -templateFile ./anf-test-net.azrm.json
    -verbose
