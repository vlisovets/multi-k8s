docker build -t vlisovets/multi-client:latest -t vlisovets/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vlisovets/multi-server:latest -t vlisovets/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vlisovets/multi-worker:latest -t vlisovets/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vlisovets/multi-client:latest
docker push vlisovets/multi-server:latest
docker push vlisovets/multi-worker:latest
docker push vlisovets/multi-client:$SHA
docker push vlisovets/multi-server:$SHA
docker push vlisovets/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=vlisovets/multi-server:$SHA
kubectl set image deployments/client-deployment client=vlisovets/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vlisovets/multi-worker:$SHA
