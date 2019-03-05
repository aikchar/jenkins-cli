FROM azul/zulu-openjdk-alpine

ARG JENKINS_HOST
ARG JENKINS_IP
ARG JENKINS_PORT
ARG KEYSTOREFILE
ARG KEYSTOREPASS

RUN    apk --update add curl openssl \
    && openssl s_client -connect ${JENKINS_IP}:${JENKINS_PORT} </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ${JENKINS_HOST}.cer \
    && keytool -import -noprompt -trustcacerts -alias ${JENKINS_HOST} -file ${JENKINS_HOST}.cer -keystore ${KEYSTOREFILE} -storepass ${KEYSTOREPASS}
