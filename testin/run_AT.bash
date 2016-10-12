#!/bin/bash

## bash file for running an amber utility that 
## does not expect an interactive session, e.g., sandeR

##
## Change these variables as desired
#IMAGE='ambertools:16'
IMAGE='lachele/ambertools'
WORKDIR=$(pwd) # use an absolute path if you change this
GROUP=${GROUPS[0]}  # your group id
RM='true'  # change to false to keep the container around
           # after you have used it
           # ...this is generally not desirable
##
##

docker run --rm=${RM} \
  -v ${WORKDIR}:/home/working \
  ${IMAGE} \
  /bin/bash -c "\
  chown $UID:${GROUP} /home/working \
  && groupadd -g ${GROUP} working \
  && adduser --home /home/working \
      --shell /bin/bash \
      --uid $UID \
      --gid ${GROUP} \
      --disabled-password \
      --system working \
  && su - working \
  && cd /home/working \
  && source /usr/local/amber16/amber.sh \
  &&  $1"

#  -u="$USER:${GROUP}" \
