build_external(tgt_zstd)

install(DIRECTORY _install/zstd DESTINATION ${THIRDPARTY_PATH})

add_custom_target(
    clean-zstd
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

