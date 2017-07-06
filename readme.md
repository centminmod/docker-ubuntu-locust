Docker image for [locust.io](http://locust.io). [Locust Documentation](http://docs.locust.io/).

![](images/locust-01.png)

# standalone

where `TARGET_URL` is the site domain name you want to test i.e. `TARGET_URL=http://domain.com`. Setup `target` variable.

    target=http://domain.com
    docker run -d -p 8089:8089 --name locust -e LOCUST_MODE=standalone -e TARGET_URL=${target} centminmod/docker-ubuntu-locust

use native host network to lower network overhead

    target=http://domain.com
    docker run -d -p 8089:8089 --net=host --name locust -e LOCUST_MODE=standalone -e TARGET_URL=${target} centminmod/docker-ubuntu-locust

# distributed

**master**

where `TARGET_URL` is the site domain name you want to test i.e. `TARGET_URL=http://domain.com`

    target=http://domain.com
    docker run -d -p 8089:8089 --name locustmaster -e LOCUST_MODE=master -e TARGET_URL=${target} centminmod/docker-ubuntu-locust

use native host network to lower network overhead

    target=http://domain.com
    docker run -d -p 8089:8089 --net=host --name locustmaster -e LOCUST_MODE=master -e TARGET_URL=${target} centminmod/docker-ubuntu-locust

**slave**

Where `<master-server-ip` is IP address for locust.io master assigned to variable `masterhost` and `TARGET_URL` is the site domain name you want to test i.e. `TARGET_URL=${target}` and first slave named `--name locustslave1`. For second slave name `--name locustslave2`, third slave name `--name locustslave3` etc.

    target=http://domain.com
    masterhost=<master-server-ip>
    docker run -d -p 8090:8089 --name locustslave1 -e LOCUST_MODE=slave -e MASTER_HOST=${masterhost} -e TARGET_URL=${target} centminmod/docker-ubuntu-locust

use native host network to lower network overhead

    target=http://domain.com
    masterhost=<master-server-ip>
    docker run -d -p 8090:8089 --net=host --name locustslave1 -e LOCUST_MODE=slave -e MASTER_HOST=${masterhost} -e TARGET_URL=${target} centminmod/docker-ubuntu-locust

**slave scripting**

you can script starting X number of slaves i.e. start 3 slave instances with sequence 1, 2, 3.

    for i in $(seq 1 3); do
      port=8089
      port=$(($port+$i))
      target=http://domain.com
      masterhost=<master-server-ip>
      docker run -d -p $port:8089 --name locustslave${i} -e LOCUST_MODE=slave -e MASTER_HOST=${masterhost} -e TARGET_URL=${target} centminmod/docker-ubuntu-locust
    done

removal of the locust slaves

    for i in $(seq 1 3); do
      docker stop locustslave${i}; docker rm locustslave${i};
    done

removal of locust master

    docker stop locustmaster; docker rm locustmaster

example of 1x master + 3x slave locust.io configuration

![](images/locust-04.png)

# inspecting logs

    docker logs locust -f

example run for named `locust` image:

    target=http://domain.com
    docker run -d -p 8089:8089 --name locust -e LOCUST_MODE=standalone -e TARGET_URL=${target} centminmod/docker-ubuntu-locust

example run log inspection for docker image named `locust`

    docker logs locust -f
    => Starting locust
    /usr/local/bin/locust -f /locust/scripts/locust0.py --host=http://domain.com
    [2017-07-06 03:43:59,718] 9ba173c41ae7/INFO/locust.main: Starting web monitor at *:8089
    [2017-07-06 03:43:59,718] 9ba173c41ae7/INFO/locust.main: Starting Locust 0.7.5
    [2017-07-06 03:45:25,073] 9ba173c41ae7/INFO/locust.runners: Hatching and swarming 1000 clients at the rate 100 clients/s...
    [2017-07-06 03:45:42,760] 9ba173c41ae7/INFO/locust.runners: All locusts hatched: MyLocust: 1000
    [2017-07-06 03:45:42,760] 9ba173c41ae7/INFO/locust.runners: Resetting stats

![](images/locust-02.png)

# tips

setup a SSH alias commands

to remove docker image `locust` standalone

    alias rmlocust='docker stop locust; docker rm locust; docker rmi centminmod/docker-ubuntu-locust;'

to remove docker image `locustmaster` master

    alias rmlocustmaster='docker stop locustmaster; docker rm locustmaster; docker rmi centminmod/docker-ubuntu-locust;'

to remove docker image `locustslave1` slave `#1`

    alias rmlocustslave1='docker stop locustslave1; docker rm locustslave1; docker rmi centminmod/docker-ubuntu-locust;'

to remove docker image `locustslave2` slave `#2`

    alias rmlocustslave2='docker stop locustslave2; docker rm locustslave2; docker rmi centminmod/docker-ubuntu-locust;'

to remove docker image `locustslave3` slave `#3`

    alias rmlocustslave3='docker stop locustslave3; docker rm locustslave3; docker rmi centminmod/docker-ubuntu-locust;'

to remove docker image `locustslave4` slave `#4`

    alias rmlocustslave4='docker stop locustslave4; docker rm locustslave4; docker rmi centminmod/docker-ubuntu-locust;'

to remove docker image `locustslave5` slave `#5`

    alias rmlocustslave5='docker stop locustslave5; docker rm locustslave5; docker rmi centminmod/docker-ubuntu-locust;'

to remove docker image `locustslave6` slave `#6`

    alias rmlocustslave6='docker stop locustslave6; docker rm locustslave6; docker rmi centminmod/docker-ubuntu-locust;'

to remove docker image `locustslave7` slave `#7`

    alias rmlocustslave7='docker stop locustslave7; docker rm locustslave7; docker rmi centminmod/docker-ubuntu-locust;'

to remove docker image `locustslave8` slave `#8`

    alias rmlocustslave8='docker stop locustslave8; docker rm locustslave8; docker rmi centminmod/docker-ubuntu-locust;'