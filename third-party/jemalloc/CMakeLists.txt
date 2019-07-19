build_external(tgt_jemalloc)

install(DIRECTORY _install/jemalloc DESTINATION ${THIRDPARTY_PATH})

add_custom_target(
    clean-jemalloc
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

