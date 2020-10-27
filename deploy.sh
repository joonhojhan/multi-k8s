docker build -t joonhojhan/multi-client:latest -t joonhojhan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t joonhojhan/multi-server:latest -t joonhojhan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t joonhojhan/multi-worker:latest -t joonhojhan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push joonhojhan/multi-client:latest
docker push joonhojhan/multi-server:latest
docker push joonhojhan/multi-worker:latest

docker push joonhojhan/multi-client:$SHA
docker push joonhojhan/multi-server:$SHA
docker push joonhojhan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=joonhojhan/multi-client:$SHA
kubectl set image deployments/server-deployment server=joonhojhan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=joonhojhan/multi-worker:$SHA
