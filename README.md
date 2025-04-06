# Kafka_GCP

This projects deploys Apache Kafka on Google Cloud Platform (GCP) using Terraform for instance creation & provision, Ansible for Kafka & Zookeeper installation. Ansible files in the form of Terraform templates are rendered dynamically and provisioned to VMs. A new VPC is created, with a public subnet for control VM and a private subnet with a NAT Gateway for Kafka VM.


## Directory Structure

- `Terraform_GCP/`: Contains .tf scripts for instance creation.
- `ansible_files/`: Ansible files for Kafka & Zookeeper installation on VM.



## Getting Started

To deploy Kafka on GCP:

1. **Set Up GCP Environment**: Ensure you have a GCP account and the necessary permissions to create and manage resources. Create a key and download .json file.

2. **Provision Virtual Machines**: Create VM instances that will serve as Kafka brokers and Zookeeper nodes (handled by Terraform).

3. **Install Kafka and Zookeeper**: On Kafka VM, install the required software packages using Ansible (started upon creation and provision of VMs by Terraform with remote-exec). 

   ![Kafka Setup](./pngs/setup.png)

5. **Configure Networking**: Set up appropriate firewall rules and networking configurations to allow communication between nodes.

6. **Start Services**: Initiate Zookeeper and then start the Kafka brokers, defined as Ansible tasks.

   ![Kafka](./pngs/kafka.png)

   ![Zookeeper](./pngs/zookeeper.png)



## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
