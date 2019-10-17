build_external(
    tgt_s2geometry
    tgt_googletest
)

install_external(s2geometry)

add_custom_target(
    clean-s2geometry
    COMMAND "rm" "-fr" "_build" "_install" "_build.log"
)

