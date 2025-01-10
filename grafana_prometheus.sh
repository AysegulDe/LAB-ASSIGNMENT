
# Commands to lauch Grafana and Prometheus using Helm chart


helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
kubectl create namespace monitoring

helm install prometheus prometheus-community/prometheus -n monitoring

# Look if all pods is running
kubectl get pods -n monitoring

# Port-forward the Prometheus server to use it locally
kubectl port-forward svc/prometheus-server 9090:80 -n monitoring
helm install grafana grafana/grafana -n monitoring

# Access Grafana via External IP (host):
# Change The Type of grafana into LoadBalancer, then access the host 
kubectl -n monitoring edit svc grafana 

# Extract the password 
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# Login as admin and password extracted

# Add prometheus as data source in grafana 
http://prometheus-server.monitoring.svc.cluster.local

# Add pre-configured dashboards such as Dashboard ID = 14282: Kubernetes cAdvisor metrics or 
# Dashboard ID = 1860: node exporter metrics  
