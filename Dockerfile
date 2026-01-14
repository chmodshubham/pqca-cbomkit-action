FROM registry.access.redhat.com/ubi8/openjdk-21:1.20

USER root
RUN microdnf install -y gcc-c++ make cmake \
    && microdnf clean all

COPY --chown=0:0 target/CBOMkit-action.jar /cbomkit-action/CBOMkit-action.jar
COPY --chown=0:0 target/java/scan/*.jar /cbomkit-action/java/scan/

ENV LANGUAGE='en_US:en'
ENV CBOMKIT_JAVA_JAR_DIR="/cbomkit-action/java/scan"

USER 0:0
WORKDIR /

CMD ["java","-Xmx16g","-jar","/cbomkit-action/CBOMkit-action.jar"]
