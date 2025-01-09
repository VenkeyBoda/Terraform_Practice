# following below steps we can create 
   * 1 vpc
   * 1 internet gateway
   * 2 public subnets 
   * 2 private subnets
   * 1 public route table
   * 1 priavte route table

   ## Steps:
      * Create vpc
      * Create an internet gateway
      * Create a private route table
      * create a public route table
      * add route in public route table to internet gateway
      * Create subnets for public and associate with public route table
      * Create subnets for private and associate with private route table

# Create security group
   * create a public security group for web
      * create a security group inbound rules
      * create a security group for default outbound rules
   * create a private security group for db
      * create a security group inbound rules
      * create a security group for default outbound rules
   * after all changes done: [added security groups](https://github.com/VenkeyBoda/Terraform_Practice/commit/36e7de1eb366413d84fffbe0abd76caa18c657ff)

# Import a ssh key (pulic key)
   * i have a key pair ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub
   * import ssh key pair: [added key pair](https://github.com/VenkeyBoda/Terraform_Practice/commit/675c655753b437ac8a7ba82079ee79f26fa648c4) 

# Create an ec2 instance with ubuntu 24.04
   * The inputs required are
      * ami id
      * instance type
      * key pair
      * subnet
      * public ip
      * security group

   * used hardcore values: [passed hardcore values](https://github.com/VenkeyBoda/Terraform_Practice/commit/6c0542ed4a1358d1a05d3bdfb1bce4f16fb39a0c)

   * created ec2 instance after all changes done: [passed sensitive user values](https://github.com/VenkeyBoda/Terraform_Practice/commit/84814be4fc815e83be2e8c358cbdeec33a5a1dc4) 

# using data sources for executing the results
   * used datasources webimage: [added datasources](https://github.com/VenkeyBoda/Terraform_Practice/commit/21d21a50ab93e90478139c47f7f11513307135a3)

# user data

   * intall nginx used user data(scripts.sh): [nginx server install](https://github.com/VenkeyBoda/Terraform_Practice/commit/5c1762c9d4ad5c46589ba71b58aab70c421bac6d) 

# Provisioners

   * remote-exec: [pass the data using provisioners](https://github.com/VenkeyBoda/Terraform_Practice/commit/de157da52fc96a1ad8780a328fa69b20f997fdd6)   

# Null resource
   * The primary use-case for the null resource is as a do-nothing containerfor    arbitrary actions taken by a provisioner.
   * multiple shell scripts are installed and then a null_resource instance is used to gather data about all and execute a single action that affects them all. 
   * Due to the triggers map, the null_resource will be replaced each time the instance ids change, and thus the remote-exec provisioner will be re-run.

   * Null resource created: [installd nginx and java](https://github.com/VenkeyBoda/Terraform_Practice/commit/e1c21081488b86dcddba27847fdc5fa2ef5115fc)

# deploy the nginx web server using css-templates

   * css-templates: [antique cafe template](https://github.com/VenkeyBoda/Terraform_Practice/commit/0fc881417a9833071de05bc6d11e81daeaf7157c) 

# security check scans

   *  security scan root block and metadata tokens: [tfscan security checks](https://github.com/VenkeyBoda/Terraform_Practice/commit/4ec840a9d23e8fac145f6c90bafb5644bb1ce68f) 