#!/usr/local/bin/bash

echo "Deleting a kind cluster named k8s..."
./kind delete cluster --name k8s

echo "Creating a kind cluster named k8s..."
./kind create cluster --config kind-config.yaml --name k8s
