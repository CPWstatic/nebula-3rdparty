build_external(
    tgt_googletest
    tgt_gflags tgt_glog
)

install_external(googletest)

add_custom_target(
    clean-googletest
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

