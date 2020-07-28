docker build - t ramp620/multi-client:latest -t ramp620/multi-client:$SHA -f ./client/Dockerfile ./client
docker build - t ramp620/multi-server:latest -t ramp620/multi-server:$SHA -f ./server/Dockerfile ./server
docker build - t ramp620/multi-worker:latest -t ramp620/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ramp620/multi-client:latest
docker push ramp620/multi-server:latest
docker push ramp620/multi-worker:latest

docker push ramp620/multi-client:latest/ramp620/multi-client:$SHA
docker push ramp620/multi-server:latest/ramp620/multi-server:$SHA
docker push ramp620/multi-worker:latest/ramp620/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ramp620/multi-server:$SHA
kubectl set image deployments/server-deployment client=ramp620/multi-client:$SHA
kubectl set image deployments/server-deployment worker=ramp620/multi-worker:$SHA