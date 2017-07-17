# chef-solo-windows
This repository demonstrates using Chef Solo to configure a Windows host. The commits with names beginning with `Step #:` go through:
1. Configuring Chef Solo 
2. Running simple recipes that use log, windows_package, and file Chef resources 
3. Using guards to make resources idempotent
4. Using Berkshelf to manage Chef Supermarket dependencies in order to install Chocolatey and a Chocolatey package
5. Use a Chef Supermarket dependency to install and configure IIS to host a web site

## Getting Started
An Azure RM template is included in `infrastructure/` to create a virtual machine to follow along.

<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Flrakai%2Fchef-solo-windows%2Fmaster%2Finfrastructure%2Farm-template.json">
    <img src="https://camo.githubusercontent.com/536ab4f9bc823c2e0ce72fb610aafda57d8c6c12/687474703a2f2f61726d76697a2e696f2f76697375616c697a65627574746f6e2e706e67" data-canonical-src="http://armviz.io/visualizebutton.png" style="max-width:100%;">
</a> 

Using Azure PowerShell, do the following to provision the resources:
```ps1
Login-AzureRmAccount
New-AzureRmResourceGroup -Name cloud-kitchen -Location "Central US"
New-AzureRmResourceGroupDeployment -Name ChefSolo -ResourceGroupName cloud-kitchen -TemplateFile .\infrastructure\arm-template.json
Get-AzureRmPublicIpAddress -Name lab-vm-ip -ResourceGroupName cloud-kitchen | Select -ExpandProperty IpAddress
```
Alternatively, you can perform a one-click deploy with the following button:

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flrakai%2Fchef-solo-windows%2Fmaster%2Finfrastructure%2Farm-template.json">
    <img src="https://camo.githubusercontent.com/9285dd3998997a0835869065bb15e5d500475034/687474703a2f2f617a7572656465706c6f792e6e65742f6465706c6f79627574746f6e2e706e67" data-canonical-src="http://azuredeploy.net/deploybutton.png" style="max-width:100%;">
</a>

Remote Desktop into the virtual machine:
- user: `student`
- password: `1Lab_Virtual_Machine!`

## Following Along
At each commit `Step #:` copy the files onto the VM and run the commands described for the step in a `powershell` terminal.

### Step 1
Run the ChefDK installer that will appear on your desktop.  Verify the install by entering the following in PowerShell:
```ps1
chef-solo --version
```

### Step 2
Run the simple recipes and verify the Notepad++ installation by opening the editor:
```ps1
chef-solo -o 'recipe[ca-lab::hello]'
chef-solo -o 'recipe[ca-lab::file]'
chef-solo -o 'recipe[ca-lab::editor]'
& 'C:\Program Files\Notepad++\notepad++.exe'
```

### Step 3
Verify the gaurd makes the `windows_package` resource idempotent:
```ps1
chef-solo -o 'recipe[ca-lab::editor]'
```

### Step 4
From the ca-lab directory, install the Chocolatey cookbook dependency with Berkshelf, install Chocolatey, and install a `chocolatey_package`:
```ps1
berks install
berks vendor C:\chef\repo\cookbooks\vendored
chef-solo -o 'recipe[ca-lab::browser]'
```

### Step 5
Install IIS, configure it to host the sample website:
```ps1
berks vendor C:\chef\repo\cookbooks\vendored
chef-solo -o 'recipe[ca-lab]'
```

## Tearing Down
When finished, remove the Azure resources with:
```ps1
Remove-AzureRmResourceGroup -Name cloud-kitchen -Force
```

