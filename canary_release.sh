# In /src/productcatalogservice/
# Creat docker image for v1 

docker build -t gcr.io/cloud-project-445516/productcatalog:v1 .
docker push gcr.io/cloud-project-445516/productcatalog:v1 

# After making change in products.json : "Sunclasses" -> "Class Sunclasses"
# Creat and push new docker image for v2

docker build -t gcr.io/cloud-project-445516/productcatalog:v2 .
docker push gcr.io/cloud-project-445516/productcatalog:v2 

# In kubernetes-manifests, configure the changes :

kubectl apply -f productcatalogservice.yaml 


# In istio-manifest, creat a new file product.yaml with the DestinationRule and VirtualService
# And save new changes 
istioctl install --set profile=demo -y
kubectl apply -f product.yaml


# Verify the pods are running
kubectl get pods

# Then logs into the different pods to verify

# Test it by refreshing the frontend page by using the external-ip

