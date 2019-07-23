build_external(tgt_mstch)

install_external(mstch)

add_custom_target(
    clean-mstch
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

