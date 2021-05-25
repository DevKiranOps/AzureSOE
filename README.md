# SOE Build Pipeline


## Variables:

### Pipeline-UI Vars
VMPASSWORD           - Password for the VM
TFRESOURCEGROUP      - Resource Group where the Storage Account for remote state is created
TFSTORAGEACCOUNT     -  Account for remote state
TFCONTAINERNAME      - Container where Storage Account is created.
TFKEY                - 
        
### Pipeline in-line variables
AZSUBSCRIPTION  - Azure Service Connection
LOCATION        - Location where the resources need to be created
ENV             - Environment
action          - Whether to terraform apply or destroy 

## Stages

There's only one stage with 4 steps:
1. Prereq:
    Substitutes values in the pipeline.
2. terraform init
3. terraform validate
4. terraform apply  - runs when the value of the variable action == apply. 
                      applies terraform configuration 
5. terraform destroy - runs when the value of the variable action == apply. 
                      destroys terraform configuration



Ansible variable	Setting	Why
rhel8cis_rule_1_1_1_2	false	vFAT needed for gen2
rhel8cis_rule_1_1_1_4	false	UDF needed for provisioning
rhel8cis_rule_1_1_5	false	/tmp noexec messes up agents
rhel8cis_rule_1_1_10	false	/var/tmp noexec messes up agents
