#!/bin/bash

## bash file for running an amber utility that 
## expects an interactive session, e.g., tleap

##
## Change these variables as desired
#IMAGE='ambertools:16'
IMAGE='lachele/ambertools'
WORKDIR=$(pwd) # use an absolute path if you change this
USER=$UID  # your user id
GROUP=${GROUPS[0]}  # your group id
RM='true'  # change to false to keep the container around
           # after you have used it
           # ...this is generally not desirable
##
##

docker run -it --rm=${RM} \
  -v ${WORKDIR}:/home/working \
  -u="${USER}:${GROUP}" \
  -w="/home/working" \
  ${IMAGE} \
  /bin/bash -c "source /usr/local/amber16/amber.sh \
  && $1"

