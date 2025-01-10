## Online Boutique Deployment, Performance Monitoring and Canary Release ###

**This Project includes** : 
    - Deploying a microservices applications on GKE.
    - Setting up and running a Load Generator both locally and automatically in Google Cloud.
    - Monitoring the application and infrastructure using Grafana and Prometheus.
    - Performing performance evaluation using metrics from Grafana and Locust.
    - Creating a new canary release.

____________________________________________________________________________

## Base Steps 

## Deploying the Original Application in GKE

The application is deployed in GKE: In the file `deploy_manually.sh`, you will find commands to create a cluster in Kubernetes with different modes.

## Deploying the Load Generator Locally

To set up and run the load generator locally: Use the commands provided in the file `load_gen_local.sh` to create and run a Docker container for Locust.

## Deploying the Load Generator Automatically in Google Cloud
To automatically deploy the load generator in Google Cloud, follow these steps:

1. Navigate to the `terraform` folder.
2. Change the gcp_project_id in `terraform.tfvar` 
3. Run the following commands:
   terraform init
   terraform plan
   terraform apply

   This will create a Kubernetes cluster named `online-boutique` in the europe-west4-a region if it hasn’t been created already.

4. Find the external IP of the Frontend service:
   
   kubectl get services
 
   Copy the external IP and replace it in the `load_generator.tf` file.

5. Re-run the Terraform commands:

   terraform init
   terraform plan
   terraform apply

   This time, it will correctly create a VM for the load generator.

6. Verify the Deployment:
   SSH into the VM:

     gcloud compute ssh load-generator --zone=europe-west4-a

   Check if the load generator container is running:

     sudo docker ps

  Then logs into the running container to see the metrics: 

    sudo docker logs <container-id>

____________________________________________________________________________

## Advanced Steps

## Monitoring the Application and Infrastructure

To monitor the application and infrastructure, use the commands in the file `Grafana_prometheus.sh`.
This file includes steps to launch Grafana and Prometheus using Helm charts.
The Grafana service type was set to LoadBalancer, allowing external access to the Grafana dashboard without the need for port-forwarding.
Once deployed, the external IP of the Grafana service can be retrieved using:

  kubectl get services -n monitoring

Then access Grafana at `http://<external-ip>`.


## Performance Evaluation

I conducted a performance evaluation by:
  - Analyzing metrics from Grafana dashboards (e.g., Node Exporter and cAdvisor).
  - Using Locust metrics to simulate traffic and measure system performance.
  - Observing system behavior under different loads and analyzing bottlenecks.


## Canary release 

I created a new canary release of the application by modifying the products.json file,
changing "Sunglasses" to "Class Sunglasses"
For the detailed steps I followed, refer to the file `canary_release.sh`.

**At the end : use terraform destroy to destroy everything including the cluster**

____________________________________________________________________________

