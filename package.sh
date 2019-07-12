#!/bin/bash

targetDir=$1
targetTarName=$2
[[ -z ${targetDir} ]] && targetDir=`pwd`
[[ -z ${targetTarName} ]] && targetTarName="nebula-3rdparty.tar.gz"

echo "Current target dir is `pwd`"

targetNameList=(bzip2 double-conversion fatal fbthrift folly gflags glog googletest jemalloc libevent mstch proxygen rocksdb snappy wangle zlib zstd)

currentDir=`pwd`
# tar target package
for NAME in ${targetNameList[@]}
do
    pushd ${currentDir}/third-party/${NAME}/_install
        tar -rf ${targetDir}/${targetTarName} ${NAME}
    popd
done
