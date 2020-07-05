docker build -t ayodejioseni/multi-client:latest -t ayodejioseni/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ayodejioseni/multi-server:latest -t ayodejioseni/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ayodejioseni/multi-worker:latest -t ayodejioseni/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ayodejioseni/multi-client:latest
docker push ayodejioseni/multi-server:latest
docker push ayodejioseni/multi-worker:latest
docker push ayodejioseni/multi-client:$SHA
docker push ayodejioseni/multi-server:$SHA
docker push ayodejioseni/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ayodejioseni/multi-server:$SHA
kubectl set image deployments/client-deployment client=ayodejioseni/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ayodejioseni/multi-worker:$SHA
