build_external(tgt_snappy)

install(DIRECTORY _install/snappy DESTINATION ${THIRDPARTY_PATH})

add_custom_target(
    clean-snappy
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

