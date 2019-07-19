build_external(tgt_mstch)

install(DIRECTORY _install/mstch DESTINATION ${THIRDPARTY_PATH})

add_custom_target(
    clean-mstch
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

