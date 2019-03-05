# Jenkins CLI

Download CLI from your Jenkins host and run it in a container.

Uses [Azul Zulu](https://www.azul.com/downloads/zulu/)
[Docker image](https://hub.docker.com/r/azul/zulu-openjdk/). The reason is that
I just wanted to try it out. It's working well so far.

More on [Jenkins CLI](https://wiki.jenkins.io/display/JENKINS/Jenkins+CLI).

# Requires

- make
- curl
- Python 3.7+
- pipenv

# Environment Variables

The following must be set and exported in your shell session,

- JENKINS_URL
    - Required by containers:
        - cli
        - cli-alt
    - For example, _https://jenkins.example.com/_
- JENKINS_LEADER_ADMIN_USER
    - Required by containers:
        - cli
        - cli-alt
    - For example, _admin_
- JENKINS_LEADER_ADMIN_PASSWORD
    - Required by containers:
        - cli
        - cli-alt
    - For example, _my-insecure-password_
- JENKINS_IP
    - Required by containers:
        - cli-alt
    - Used in:
        - ``openssl s_client -connect ...`` (see _Dockerfile_)
    - It is separate from JENKINS_HOST because in self-signed certificate cases sometimes the Jenkins host doesn't have a valid DNS record, either. Using an IP address instead is a workaround.
    - For example, _10.20.30.40_ or _jenkins.example.com_
- JENKINS_PORT
    - Required by containers:
        - cli-alt
    - Used in:
        - ``openssl s_client -connect ...`` (see _Dockerfile_)
    - For example, _443_ or _80_
- JENKINS_HOST
    - Required by containers:
        - cli-alt
    - Used in:
        - ``openssl s_client -connect ...`` (see _Dockerfile_)
        - ``keytool -import ...`` (see _Dockerfile_)
    - For example, _jenkins.example.com_
- KEYSTOREFILE
    - Required by containers:
        - cli-alt
    - Used in:
        - ``keytool -import ...`` (see _Dockerfile_)
    - It's used in the cli-alt scenario.
    - For example, _/usr/local/etc/keystore_, which is the value in _Makefile_ if this environment variable is not already set.
- KEYSTOREPASS
    - Required by containers:
        - cli-alt
    - Used in:
        - ``keytool -import ...`` (see _Dockerfile_)
    - For example, _IamInsecure_, which is the value in _Makefile_ if this environment variable is not already set.

These environment variables are either set to _NOTSET_ or another default value
in _Makefile_ if they are not already set. This may help identify issues when
they are not set by you.

# Usage

    $ make init

You should examine and modify _docker-compose.yml_ as required.

## cli

    $ make cli-exec

Run a [Bourne Shell](https://en.wikipedia.org/wiki/Bourne_shell) session in the
container.

## cli-alt

This is for use cases where the Jenkins server is using a self-signed
certificate.

    $ make cli-alt-build

The build step creates a container image that trusts the self-signed
certificate used by the Jenkins server.

    $ make cli-alt-exec

Run a [Bourne Shell](https://en.wikipedia.org/wiki/Bourne_shell) session in the
container.

More information,

- [Using jenkins-cli connecting to HTTPS port fails due to hostname mismatch in certificate](https://issues.jenkins-ci.org/browse/JENKINS-12629)
- [How to install a new SSL certificate?](https://support.cloudbees.com/hc/en-us/articles/203821254-How-to-install-a-new-SSL-certificate-)
- [How to create keystore and truststore using self-signed certificate?](https://unix.stackexchange.com/questions/347116/how-to-create-keystore-and-truststore-using-self-signed-certificate)
