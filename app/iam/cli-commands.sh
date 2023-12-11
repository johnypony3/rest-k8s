#!/bin/bash

aws iam create-role \
  --role-name eks-role-manual-02 \
  --assume-role-policy-document file://"cluster-trust-policy.json"

aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy \
  --role-name eks-role-manual-02
