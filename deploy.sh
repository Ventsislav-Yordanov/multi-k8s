docker build -t ventsi94/multi-client:latest -t ventsi94/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ventsi94/multi-server:latest -t ventsi94/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ventsi94/multi-worker:latest -t ventsi94/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ventsi94/multi-client:latest
docker push ventsi94/multi-server:latest
docker push ventsi94/multi-worker:latest

docker push ventsi94/multi-client:$SHA
docker push ventsi94/multi-server:$SHA
docker push ventsi94/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ventsi94/multi-server:$SHA
kubectl set image deployments/client-deployment client=ventsi94/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ventsi94/multi-worker:$SHA