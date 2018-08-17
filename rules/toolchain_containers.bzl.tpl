def toolchain_container_sha256s():
    return {
        ###########################################################
        # Base images                                             #
        ###########################################################
        # gcr.io/cloud-marketplace/google/ubuntu16_04:latest
        "ubuntu16_04": "$ubuntu16_04",

        ###########################################################
        # Python3 images                                          #
        ###########################################################
        # gcr.io/google-appengine/python:latest
        "ubuntu16_04_python3": "$ubuntu16_04_python3",
    }
