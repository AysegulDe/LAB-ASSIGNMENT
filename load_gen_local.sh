
# In src/loadgenerator


docker build -t locust-loadgen .   
docker run -d -p 8089:8089 --entrypoint locust locust-loadgen --host="http://<frontend_ip_addr>" --headless --users=1000 --spawn-rate=1 

docker ps
