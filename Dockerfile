FROM quay.io/debezium/connect:3.0.8.Final

USER root

ENV MSK_IAM_AUTH_VERSION=2.3.2

# 1. Create your plugin folder & download the AWS IAM Auth "uber‑jar"
RUN mkdir -p /kafka/connect/aws-msk-iam-auth \
 && curl -fsSL \
      https://github.com/aws/aws-msk-iam-auth/releases/download/v${MSK_IAM_AUTH_VERSION}/aws-msk-iam-auth-${MSK_IAM_AUTH_VERSION}-all.jar \
      -o /kafka/connect/aws-msk-iam-auth/aws-msk-iam-auth.jar \
# 2. Copy every Debezium connector JAR (they include the Debezium config classes)
 && for dir in /kafka/connect/debezium-connector-*/; do \
      cp "$dir"/*.jar /kafka/connect/aws-msk-iam-auth/ 2>/dev/null || : ; \
    done \
 && chown -R 1001:0 /kafka/connect/aws-msk-iam-auth

USER 1001