#!/bin/bash

while getopts "c" o; do
    case "${o}" in
        c)
            clean
            ;;
    esac
done

minikube start --extra-config=apiserver.authorization-mode=RBAC
kubectl create namespace test-namespace

# Create a private key for your user
openssl genrsa -out test-user.key 2048
# Create a certificate sign request
openssl req -new -key test-user.key -out test-user.csr -subj "/CN=test-user/O=DartK8s"
# Generate the final certificate by approving the certificate sign request
openssl x509 -req -in test-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out test-user.crt -days 365

# Add a new context with the new credentials
kubectl config set-credentials test-user --client-certificate=test-user.crt  --client-key=test-user.key
kubectl config set-context test-user-context --cluster=minikube --namespace=test-namespace --user=test-user

kubectl create -f role-deployment-manager.yaml
kubectl create -f rolebinding-deployment-manager.yaml

kubectl create deployment nginx --image=nginx


function clean() {
    minikube stop
    minikube delete
    rm -rf ~/.minikube/
    rm -rf ~/.kube/
    rm test-user.crt
    rm test-user.csr
    rm test-user.key
}