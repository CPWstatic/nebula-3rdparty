build_external(tgt_jemalloc)

install_external(jemalloc)

add_custom_target(
    clean-jemalloc
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

