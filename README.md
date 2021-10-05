## Build process setup

Sections `Prerequisites` and `Setup` should be done only once per build host

### Requirements

* Docker CE 17.12.0+ (https://docs.docker.com/install/)
* Docker Compose 1.10+ (https://github.com/docker/compose/releases/)

### CURL Requirements

No specific requirements

### Prerequisites

1. `Docker` should be installed on build host following these instructions:

    https://docs.docker.com/install/linux/docker-ce/centos/#set-up-the-repository

    and

    https://docs.docker.com/install/linux/docker-ce/centos/#install-docker-ce-1

2. `Docker Compose` should be installed on build host following instructions:

    https://docs.docker.com/compose/install/#install-compose

3. Add your build user into docker group (required to manage docker):

    ```
    usermod -aG docker <username>
    ```

    and relogin

4. Start Docker daemon

    ```
    systemctl enable docker
    systemctl start docker
    ```

5. Port 80 on build host should be free (stop nginx/httpd or move to different
port)

### Setup

1. Clone build repo with submodules (curl is just an example - it could be
any build repo):

    ```
    git clone --recursive https://github.com/aursu/rpmbuild-curl.git
    cd rpmbuild-curl
    ```

### Build process


1. Build images

    ```
    docker-compose -f docker-compose.base.yml build
    docker-compose -f build
    ```

2. Build packages

    ```
    docker-compose up -d
    ```

    command above will start all build serrvices in background. But it is possible
to run any of them or run in foreground etc

3. Wait until command `docker-compose ps` returns all services in state 'Exit 0'

### Access RPM packages

use `docker cp` command from container `webrepo` from path `/home/centos-7/rpmbuild/RPMS`

### Complete build

To complete all build processes run commands:

```
docker-compose down
docker-compose -f docker-compose.base.yml down
```

These commands will stop and remove all containers but not build images (see
`docker images` and `docker rmi` commands manuals)