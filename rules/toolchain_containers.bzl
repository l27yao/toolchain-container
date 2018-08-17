def toolchain_container_sha256s():
    return {
        ###########################################################
        # Base images                                             #
        ###########################################################
        # gcr.io/cloud-marketplace/google/ubuntu16_04:latest
        "ubuntu16_04": "sha256:8a12cc26c62e2f9824aada8d13c1f0c2d2847d18191560e1500d651a709d6550",

        ###########################################################
        # Python3 images                                          #
        ###########################################################
        # gcr.io/google-appengine/python:latest
        "ubuntu16_04_python3": "sha256:845742768ca108827055ae9d3925b8a9a9bfa3d000f16a03407ea6b817f59c3d",
    }
