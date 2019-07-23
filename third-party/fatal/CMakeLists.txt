build_external(tgt_fatal)

install_external(fatal)

add_custom_target(
    clean-fatal
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

