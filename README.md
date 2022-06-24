# Terraform Coding Exercise

Please read the [instructions](./INSTRUCTIONS.md) file.


##Correcting the environemnt errors to prepare the terraform provisioning using terrafrom init, and terraform apply.

 1. It is important to check whether port 53 is opened on local machine where docker container will be running.
    Running this  linux command ss -nltp | grep "53" will show whether port 53 is already taken by the default DNS service. The result of ss command will let us know precisely if the port 53 can be allocated to the docker container.
    If the port 53 is already taken by trhe default DNS service on the host machine, it will require to publish externally teh docker container on a diferent port that is not 53.
    That is the main reason why is osme cases it will require to change the parameters from "docker run" command written in build-and-run.sh script present inthe  folder tests .

    docker run -d --privileged --tmpfs /tmp --tmpfs /run \
     -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
     -v /etc/localtime:/etc/localtime:ro \
     -v ${SCRIPT_DIR}/dns-server/named.conf.none:/etc/named.conf:ro \
     --publish 127.0.0.1:54:53/tcp \
     --publish 127.0.0.1:54:53/udp \
     --rm --name ${CONTAINER_NAME} \
     --hostname ns.${EXAMPLE_DOMAIN} ${CONTAINER_NAME}:${CONTAINER_TAG}

2. Access the folder examples/exercise from teh repository to launch "terraform init" and "terraform plan".

3. After it is possible get back to main folder of the local repository cloned on your local machine where you can launch terraform init, terraform plan and terraorm apply -auto-approve.

