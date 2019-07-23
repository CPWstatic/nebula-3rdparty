build_external(tgt_zstd)

install_external(zstd)

add_custom_target(
    clean-zstd
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

