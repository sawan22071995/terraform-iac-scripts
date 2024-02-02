#!/bin/bash

echo ###################################################################################################################
echo #Description : Automation Script for Create Network LoadBalancer with Application LoadBalancer in AWS for EKS######
echo #Created By  : Sawan Chouksey                                                                                ######
echo #Email ID    : sawchouksey@deloitte.com                                                                      ######
echo #Used For    : Titan                                                                                         ######
echo ###################################################################################################################

#Variable Decleration
NLB_NAME="nlb-ingress-uat"
NLB_SUBNET_ID="subnet-0e3f5cac72EXAMPLE"
ALB_TG_VPC_ID="vpc-hkqeqfrwjfhroioi5385"
ALB_NAME="dev-internal-alb-01"
AWS_REGION="your-aws-region"
TARGET_GROUP_NAME_HTTP="alb-ingress-uat-http"
TARGET_GROUP_NAME_HTTPS="alb-ingress-uat-https"

aws elbv2 create-load-balancer --name my-load-balancer --type network --subnets subnet-0e3f5cac72EXAMPLE

aws create-target-group --name $TARGET_GROUP_NAME_HTTP --target-type "alb" --protocol "TCP" --port 80 --vpc-id $ALB_TG_VPC_ID --health-check-protocol "HTTP" --health-check-path "/"

aws create-target-group --name $TARGET_GROUP_NAME_HTTPS --target-type "alb" --protocol "TCP" --port 443 --vpc-id $ALB_TG_VPC_ID --health-check-protocol "HTTPS" --health-check-path "/"

# Get the ALB ARN using AWS CLI
NLB_ARN=$(aws elbv2 describe-load-balancers \
--region $AWS_REGION \
--query "LoadBalancers[?LoadBalancerName=='$NLB_NAME'].LoadBalancerArn" \
--output text)

# Get the TG ARN using AWS CLI
TARGET_GROUP_ARN_HTTP=$(aws elbv2 describe-target-groups \
--region $AWS_REGION \
--query "TargetGroups[?TargetGroupName=='$TARGET_GROUP_NAME_HTTP'].TargetGroupArn" \
--output text)

# Get the TG ARN using AWS CLI
TARGET_GROUP_ARN_HTTPS=$(aws elbv2 describe-target-groups \
--region $AWS_REGION \
--query "TargetGroups[?TargetGroupName=='$TARGET_GROUP_NAME_HTTPS'].TargetGroupArn" \
--output text)

# Get the ALB ARN using AWS CLI
ALB_ARN=$(aws elbv2 describe-load-balancers \
--region $AWS_REGION \
--query "LoadBalancers[?LoadBalancerName=='$ALB_NAME'].LoadBalancerArn" \
--output text)

aws elbv2 register-targets --target-group-arn $TARGET_GROUP_ARN_HTTP --targets Id=$ALB_ARN

aws elbv2 register-targets --target-group-arn $TARGET_GROUP_ARN_HTTPS --targets Id=$ALB_ARN

aws elbv2 create-listener --load-balancer-arn $NLB_ARN --protocol TCP --port 80 --default-actions Type=forward,TargetGroupArn=$TARGET_GROUP_ARN_HTTP

aws elbv2 create-listener --load-balancer-arn $NLB_ARN --protocol TCP --port 443 --default-actions Type=forward,TargetGroupArn=$TARGET_GROUP_ARN_HTTPS