build_external(tgt_libevent)

install_external(libevent)

add_custom_target(
    clean-libevent
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

