build_external(tgt_double-conversion)

install(DIRECTORY _install/double-conversion DESTINATION ${THIRDPARTY_PATH})

add_custom_target(
    clean-double-conversion
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

