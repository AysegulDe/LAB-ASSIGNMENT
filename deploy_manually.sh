
# Deploying the original application in GKE

# Create a container with different modes

# Cloned the microservices-demo repository from Google  
# git clone https://github.com/GoogleCloudPlatform/microservices-demo.git
# cd microservices-demo

# Deployment with Autopilot Mode 
gcloud container clusters creat-auto online-boutique 
kubectl apply -f ./release/kubernetes-manifests.yaml


# Deployment Standard Mode 
gcloud container clusters create online-boutique   --num-nodes=4   --machine-type=e2-standard-2   --zone=europe-west6-a
gcloud container clusters get-credentials online-boutique --region europe-west6-a 
kubectl apply -f ./release/kubernetes-manifests.yaml
kubectl get services
kubectl get pods
