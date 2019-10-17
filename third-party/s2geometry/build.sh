#!/bin/bash

source ../functions.sh

prepareBuild "s2geometry"

gflags_release=$THIRD_PARTY_DIR/gflags/_install/gflags
glog_release=$THIRD_PARTY_DIR/glog/_install/glog
gtest_release=$THIRD_PARTY_DIR/googletest/_install/googletest

echo
echo "Start building $PROJECT_NAME with $NEBULA_C_COMPILER ($CC_VER_STR)"
echo

#if !(cd $SOURCE_DIR && NOCONFIGURE=1 ./autogen.sh); then
#    cd $CURR_DIR
#    echo
#    echo "### $PROJECT_NAME failed to auto-reconfigure ###"
#    echo
#    exit 1
#fi

NEBULA_INCLUDE_DIRS="$gtest_release/include;$gflags_release/include;$glog_release/include;$NEBULA_INCLUDE_DIRS"
NEBULA_LIB_DIRS="$gtest_release/bin;$gflags_release/lib;$glog_release/lib;$NEBULA_LIB_DIRS"

cd $SOURCE_DIR

if [[ $SOURCE_DIR/CMakeLists.txt -nt $SOURCE_DIR/Makefile ||
      $CURR_DIR/build.sh -nt $SOURCE_DIR/Makefile ]]; then
    if !($NEBULA_CMAKE $CMAKE_FLAGS -DCMAKE_INCLUDE_PATH="$NEBULA_INCLUDE_DIRS" -DCMAKE_LIBRARY_PATH="$NEBULA_LIB_DIRS" -DBUILD_SHARED_LIBS=off -DWITH_GFLAGS=on -DWITH_GLOG=on -DBUILD_EXAMPLES=off    $SOURCE_DIR); then
        cd $CURR_DIR
        echo
        echo "### $PROJECT_NAME failed to configure the build ###"
        echo
        exit 1
    fi
fi

if (make $1 all && make install); then
    cd $CURR_DIR
    rm -fr $INSTALL_PATH/lib/CMake
    echo
    echo ">>> $PROJECT_NAME is built and installed successfully <<<"
    echo
    exit 0
else
    cd $CURR_DIR
    echo
    echo "### $PROJECT_NAME failed to build ###"
    echo
    exit 1
fi

