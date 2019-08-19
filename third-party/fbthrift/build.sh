#!/bin/bash

source ../functions.sh

prepareBuild "fbthrift"

double_conversion_release=$THIRD_PARTY_DIR/double-conversion/_install/double-conversion
gflags_release=$THIRD_PARTY_DIR/gflags/_install/gflags
glog_release=$THIRD_PARTY_DIR/glog/_install/glog
folly_release=$THIRD_PARTY_DIR/folly/_install/folly
wangle_release=$THIRD_PARTY_DIR/wangle/_install/wangle
mstch_release=$THIRD_PARTY_DIR/mstch/_install/mstch
zlib_release=$THIRD_PARTY_DIR/zlib/_install/zlib
zstd_release=$THIRD_PARTY_DIR/zstd/_install/zstd

echo
echo "Start building $PROJECT_NAME with $NEBULA_CXX_COMPILER ($CXX_VER_STR)"
echo

#if !(cd $SOURCE_DIR && autoreconf -ivf -I/usr/local/share/aclocal-1.15 -I/usr/share/aclocal); then
#    cd $CURR_DIR
#    echo
#    echo "### $PROJECT_NAME failed to auto-reconfigure ###"
#    echo
#    exit 1
#fi

cd $SOURCE_DIR

COMPILER_FLAGS="-fPIC -DPIC    $EXTRA_CXXFLAGS"
LINKER_FLAGS="-static-libgcc -static-libstdc++    $EXTRA_LDFLAGS"
NEBULA_PREFIX_DIRS="$double_conversion_release;$gflags_release;$glog_release;$folly_release;$wangle_release;$mstch_release;$zlib_release;$zstd_release;$NEBULA_PREFIX_DIRS"
NEBULA_INCLUDE_DIRS="$double_conversion_release/include;$gflags_release/include;$glog_release/include;$folly_release/include;$wangle_release/include;$mstch_release/include;$zlib_release/include;$zstd_release/include;$NEBULA_INCLUDE_DIRS"
NEBULA_LIB_DIRS="$double_conversion_release/lib;$gflags_release/lib;$glog_release/lib;$folly_release/lib;$wangle_release/lib;$mstch_release/lib;$zlib_release/lib;$zstd_release/lib;$NEBULA_LIB_DIRS"

if [[ $SOURCE_DIR/CMakeLists.txt -nt $SOURCE_DIR/Makefile ||
      $CURR_DIR/build.sh -nt $SOURCE_DIR/Makefile ]]; then
#    if !($NEBULA_CMAKE $CMAKE_FLAGS -DCMAKE_C_FLAGS:STRING="$COMPILER_FLAGS" -DCMAKE_CXX_FLAGS:STRING="$COMPILER_FLAGS" -DCMAKE_STATIC_LINKER_FLAGS:STRING="" -DCMAKE_EXE_LINKER_FLAGS:STRING="$LINKER_FLAGS" -DCMAKE_PREFIX_PATH="$NEBULA_PREFIX_DIRS" -DCMAKE_INCLUDE_PATH="$NEBULA_INCLUDE_DIRS" -DCMAKE_LIBRARY_PATH="$NEBULA_LIB_DIRS" -DBoost_USE_STATIC_LIBS:BOOL=YES -DTHRIFT_HOME=$INSTALL_PATH -DFLEX_EXECUTABLE=$NEBULA_FLEX     $SOURCE_DIR); then
    if !($NEBULA_CMAKE $CMAKE_FLAGS -DCMAKE_C_FLAGS:STRING="$COMPILER_FLAGS" -DCMAKE_CXX_FLAGS:STRING="$COMPILER_FLAGS" -DCMAKE_STATIC_LINKER_FLAGS:STRING="" -DCMAKE_EXE_LINKER_FLAGS:STRING="$LINKER_FLAGS" -DCMAKE_PREFIX_PATH="$NEBULA_PREFIX_DIRS" -DCMAKE_INCLUDE_PATH="$NEBULA_INCLUDE_DIRS" -DCMAKE_LIBRARY_PATH="$NEBULA_LIB_DIRS" -DTHRIFT_HOME=$INSTALL_PATH -DFLEX_EXECUTABLE=$NEBULA_FLEX     $SOURCE_DIR); then
        cd $CURR_DIR
        echo
        echo "### $PROJECT_NAME failed to configure the build ###"
        echo
        exit 1
    fi
fi

if (make $1 all && make install); then
    cd $CURR_DIR
    echo
    echo ">>> $PROJECT_NAME is built and installed successfully <<<"
    echo
else
    cd $CURR_DIR
    echo
    echo "### $PROJECT_NAME failed to build ###"
    echo
    exit 1
fi

# build thrift_jar
SKIP_JAVA_JAR=$2
if [[ "${SKIP_JAVA_JAR}" == "ON" ]]; then
    echo ">>> SKIP JAVA JAR <<<"
    exit 0
fi

cd $SOURCE_DIR/thrift/lib/java/thrift
if (mvn clean package); then
    echo
    echo ">>> $PROJECT_NAME is built thrift-jar successfully <<<"
    echo
else
    echo
    echo ">>> $PROJECT_NAME is built thrift-jar failed <<<"
    echo
    exit 1
fi

yes|cp $SOURCE_DIR/thrift/lib/java/thrift/target/thrift-1.0-SNAPSHOT.jar $INSTALL_PATH
