build_external(tgt_fatal)

install(DIRECTORY _install/fatal DESTINATION ${THIRDPARTY_PATH})

add_custom_target(
    clean-fatal
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

