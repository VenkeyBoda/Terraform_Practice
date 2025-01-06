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

      * used hardcore values:         