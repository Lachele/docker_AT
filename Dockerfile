# Dockerfile for amber in a slurm cluster
FROM  python:3.5.2

# To get the AmberTools16.tar.bz file, fill out the form
# at the site below and click Download.
ADD AmberTools16.tar.bz2 USAGE.txt /usr/local/

RUN     apt-get update \
    &&  apt-get install -y \
        csh \
        flex \
        gfortran \
        g++ \
        zlib1g-dev \
        libbz2-dev \
        patch \
        openmpi-bin \
        libopenmpi-dev
   
RUN     cd /usr/local/amber16 \
    &&  export AMBERHOME=$(pwd) \
    &&  ./update_amber --show-applied-patches \
    &&  ./update_amber --update \
    &&  ./update_amber --show-applied-patches \
    &&  ./configure --with-python /usr/local/bin/python3.5 -noX11 gnu \
    &&  . ${AMBERHOME}/amber.sh \
    &&  make -j4 install \
    &&  ./configure --with-python /usr/local/bin/python3.5 -noX11 -mpi gnu \
    &&  make -j4 install 

CMD ["more","/usr/local/USAGE.txt"]
