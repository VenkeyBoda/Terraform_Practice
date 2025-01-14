# I want to Create the network with a vm in a subnet with nginx installed in azure

# steps:

     * Create a resource group
     * create a vnet with subnets
     * create a network security group
     * create a public ip address
     * create a vm with a network interface associated with nsg and public ip
     * configure a provisioner to install script
     
   * passed hardcore values: [created vnet and subnet](https://github.com/VenkeyBoda/Terraform_Practice/commit/100f8c4f53a71e6c9a60aa934a77b1f8aadf6f6c)    

   * Using varibales and .tfvars: [Passed sensitive values](https://github.com/VenkeyBoda/Terraform_Practice/commit/5f15ec8b939119a705c0b37f26777a1d250d727e)

   * local values: [local values declared](https://github.com/VenkeyBoda/Terraform_Practice/commit/2da23fc16139d547ac1abae4467e7cb5eea9db69) 
   
   * created nsg and public ip address: [passed hardcore values](https://github.com/VenkeyBoda/Terraform_Practice/commit/d43f77f37deae81cafa71013c4e0a15546024e2b)

   * created network interface and associated with nsg to nic: [nsg to nic](https://github.com/VenkeyBoda/Terraform_Practice/commit/1bb9ed84d49a9f4f481f3e03ce924ee5c1f98346)

   * created webserver for vm machine: [vm machine and output](https://github.com/VenkeyBoda/Terraform_Practice/commit/5f5a54a6fafb37e0534f6148dcf1b839c2b0de7d)

# Null resource and Provisioners
   * The primary use-case for the null resource is as a do-nothing containerfor    arbitrary actions taken by a provisioner.
   * multiple shell scripts are installed and then a null_resource instance is used to gather data about all and execute a single action that affects them all. 
   * Due to the triggers map, the null_resource will be replaced each time the instance ids change, and thus the remote-exec provisioner will be re-run.

# Install and deploy the nginx web server using css-templates
   * css-templates: [antique cafe template](https://github.com/VenkeyBoda/Terraform_Practice/commit/98b05c35685100c862c3ef454baa90d9932a53a4)