build_external(
    tgt_glog
    tgt_gflags tgt_libevent tgt_double-conversion
)

install_external(glog)

add_custom_target(
    clean-glog
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

