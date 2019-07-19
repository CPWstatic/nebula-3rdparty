build_external(tgt_bzip2)

install(DIRECTORY _install/bzip2 DESTINATION ${THIRDPARTY_PATH})

add_custom_target(
    clean-bzip2
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

