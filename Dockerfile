FROM quay.io/debezium/connect:3.0.8.Final

USER root
RUN mkdir -p /kafka/connect/aws-msk-iam-auth \
 && curl -fSL -o /kafka/connect/aws-msk-iam-auth/aws-msk-iam-auth-2.3.2.jar \
         https://repo1.maven.org/maven2/software/amazon/msk/aws-msk-iam-auth/2.3.2/aws-msk-iam-auth-2.3.2.jar \
 && chown -R 1000:0 /kafka/connect

USER 1000