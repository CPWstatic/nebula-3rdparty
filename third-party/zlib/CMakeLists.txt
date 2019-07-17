build_external(tgt_zlib)

install(DIRECTORY _install/zlib DESTINATION ${THIRDPARTY_PATH})

add_custom_target(
    clean-zlib
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

