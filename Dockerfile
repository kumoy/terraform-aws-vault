FROM plus3it/tardigrade-ci:0.0.9

WORKDIR /ci-harness
ENTRYPOINT ["make"]
