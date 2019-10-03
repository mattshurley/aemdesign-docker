#!/usr/bin/env bash

# requires that get_config.sh has been executed.

if [[ -z "${IMAGE}" ]] || [[ -z "${IMAGE_VERSION}" ]] || [[ -z "${TEST_COMMAND}" ]]; then
    echo "please run get_config.sh"
    travis_terminate 1
fi

echo ">>> VERIFY BUILD CONTAINER <<<"
export CONTAINER_COMMAND="docker run ${IMAGE}:${IMAGE_VERSION} ${TEST_COMMAND}"
echo CONTAINER_COMMAND="${CONTAINER_COMMAND}"
export CONTAINER_OUTPUT="$(eval ${CONTAINER_COMMAND})"
echo "CONTAINER_OUTPUT=${CONTAINER_OUTPUT}"
if [[ ! ${CONTAINER_OUTPUT} =~ ${TEST_COMMAND_VERIFY} ]]; then travis_terminate 1; fi
