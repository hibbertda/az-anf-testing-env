# Azure NetApp Files (ANF) - Testing Environment
Template to build testing environment for Azure NetApp Files (ANF). A virtual machine and all required infrastructure needed to test storage performance. Common storage performance tools are loaded on the Ubuntu VM.

Use the following links to jump into deployed in your Azure environment.

<br />

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhibbertda%2Faz-anf-testing-env%2Fmaster%2Fanf-test-net.azrm.json" target="_blank">
    <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>

<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhibbertda%2Faz-anf-testing-env%2Fmaster%2Fanf-test-net.azrm.json" target="_blank">
    <img src="https://azuredeploy.net/AzureGov.png"/>
</a>

<br />

**Note**: At the time of writing this Azure NetApp Files is not available in all Azure Government regions. Double check [availability by region](https://azure.microsoft.com/en-us/global-infrastructure/services/) to ensure you use a region where the service is available.

---
<br />

## Environemt

The template will deploy all required resources to create a new stand alone environment for testing. 

The VM is not accessible directly from the internet. Azure Bastion is used to connect to the VM over SSH from the Azure portal.
<center>

![environment layou](/static/envlayout.png)

</center>
---
<br />

## Storage Layout

The purpose of this template is to create an environemtn to test Azure NetApp Files performance for applications that require high performance storage. To facilitate testing the VM is configured with 8 managed disks (to be configured in software RAID0), and two Azure NetApp Files capacity pools representing Standard and Premium tiers. 

|Count|Storage Type|Connection|Capacity||
|---|---|---|---|---|
|1|Managed Disk|Local|512 GB| OS |
|8|Managed Disk|Local|2 TB| Software RAID0 |
|1|ANF Volume |NFSv3|4TB|Standard Tier |
|1|ANF Volume |NFSv3|4TB|Premium Tier |

<br />

<center>

![storage layout](/static/storagelayout.png)

</center>

<br />
---

## Performance Testing

The linux Flexible I/O tester is automatically installed on the Ubuntu VM for performance testing. The following example(s) cover common storage perfromance testing scenarios

### Random Read/Write

Use the following example to test random read/write performance

```bash
sudo fio --filename=/mnt/anfStandard/stdfile \ 
    --size=500GB \
    --direct=1 \
    --rw=randrw \
    --bs=4k \
    --ioengine=libaio \
    --iodepth=256 \
    --runtime=120 \
    --numjobs=4 \
    --time_based \
    --group_reporting \
    --name=iops-test-job \
    --eta-newline=1
```

[Flexible I/O tester man page](https://linux.die.net/man/1/fio)