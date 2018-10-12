docker build -t phareesh76/multi-client:latest -t phareesh76/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phareesh76/multi-server:latest -t phareesh76/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phareesh76/multi-worker:latest -t phareesh76/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push phareesh76/multi-client:latest
docker push phareesh76/multi-client:$SHA
docker push phareesh76/multi-server:latest
docker push phareesh76/multi-server:$SHA
docker push phareesh76/multi-worker:latest
docker push phareesh76/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=phareesh76/multi-server:$SHA
kubectl set image deployments/client-deployment client=phareesh76/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=phareesh76/multi-worker:$SHA
