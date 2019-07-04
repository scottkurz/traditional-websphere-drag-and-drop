How to build a [WebSphere Application Server traditional Docker](https://github.com/WASdev/ci.docker.websphere-traditional) container with a [monitored application deployment](https://www.ibm.com/support/knowledgecenter/SSAW57_9.0.0/com.ibm.websphere.nd.multiplatform.doc/ae/trun_app_set_dragdrop.html) directory (i.e. a "dropins" dir).

**Note:** Instructions shown using Git Bash for Windows (should be easily mapped to Linux/MacOS).

1.  Clone the Docker build directory

    -   `git clone git@github.com:scottkurz/monitored-twas-docker.git`

2.  Do a docker build via:

    -   `docker build -t scottkurz/monitored-twas-app-deploy:1 .`

    -   *Optional*: OR, start with my image: **scottkurz/monitored-twas-app-deploy:1** on DockerHub

3.  Run a new container *from repository root directory* with:

    1.  Windows

        ``` bash
        REPO_ROOT="$(cygpath -w $(pwd))"  # From Git Bash / Cygwin
        winpty docker run --name monitored-twas-app-deploy \
        -v "$REPO_ROOT\volumes\PASSWORD.txt":/tmp/PASSWORD \
        -v "$REPO_ROOT\volumes\monitored-app-dir":/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/monitoredDeployableApps \
        -p 9043:9043 -p 9443:9443 -p 7777:7777 \
        -e ENABLE_BASIC_LOGGING=true \
        -it  scottkurz/monitored-twas-app-deploy:1
        ```

    2.  (OR) Linux/Mac:

        ``` bash
        REPO_ROOT=$PWD
        docker run --name monitored-twas-app-deploy \
        -v "$REPO_ROOT/volumes/PASSWORD.txt":/tmp/PASSWORD \
        -v "$REPO_ROOT/volumes/monitored-app-dir":/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/monitoredDeployableApps \
        -p 9043:9043 -p 9443:9443 -p 7777:7777 \
        -e ENABLE_BASIC_LOGGING=true \
        -it  scottkurz/monitored-twas-app-deploy:1
        ```

<!-- -->

1.  Start with any application project, e.g.:

    -   `git clone https://github.com/scottkurz/MyRestApp`

2.  Make changes or whatever, and build it, (not shown, e.g. using RAD/WDT Eclipse tooling with an *Export WAR*):

3.  Copy into the mounted directory at location **…​/monitored-app-dir/servers/server1**, e.g.: `cp MyRestApp.war "$REPO_ROOT/volumes/monitored-app-dir/servers/server1"`

4.  Watch the app get installed:

<!-- -->

    [6/13/19 2:38:46:982 UTC] 00000049 AppManagement I   CWLDD0021I: Event id 580239227-1. Application MyRADRest_war is started on:
    WebSphere:cell=DefaultCell01,node=DefaultNode01,server=server1,status=success.
