#!/bin/bash

source ../functions.sh

prepareBuild "s2geometry"

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

cd $SOURCE_DIR

if [[ $SOURCE_DIR/CMakeLists.txt -nt $SOURCE_DIR/Makefile ||
      $CURR_DIR/build.sh -nt $SOURCE_DIR/Makefile ]]; then
    if !($NEBULA_CMAKE $CMAKE_FLAGS -DCMAKE_C_FLAGS:STRING="$compiler_flags" -DCMAKE_CXX_FLAGS:STRING="$compiler_flags" -DBUILD_SHARED_LIBS=off    $SOURCE_DIR); then
        cd $CURR_DIR
        echo
        echo "### $PROJECT_NAME failed to configure the build ###"
        echo
        exit 1
    fi
fi

if (make $@ all && make install); then
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

