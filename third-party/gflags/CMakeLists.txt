build_external(tgt_gflags)

install(DIRECTORY _install/gflags DESTINATION ${THIRDPARTY_PATH})

add_custom_target(
    clean-gflags
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

