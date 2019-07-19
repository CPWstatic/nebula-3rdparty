build_external(tgt_libevent)

install(DIRECTORY _install/libevent DESTINATION ${THIRDPARTY_PATH})

add_custom_target(
    clean-libevent
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

