# Copyright 2016 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Once recursive workspace is implemented in Bazel, this file should cease
# to exist.

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(
    "//third_party/golang:revision.bzl",
    "go_pins",
)
load(
    "//third_party/clang:revision.bzl",
    "clang_pins",
)
load(
    "//third_party/libcxx:revision.bzl",
    "libcxx_pins",
)
load(
    "//third_party/openjdk:revision.bzl",
    "JDK_VERSION",
    "OPENJDK_SHA256",
    "OPENJDK_SRC_SHA256",
)
load(
    "//container/ubuntu16_04/layers/bazel:version.bzl",
    "BAZEL_VERSION_SHA256S",
)

def repositories():
    """Download dependencies of bazel-toolchains."""
    excludes = native.existing_rules().keys()

    # ============================== Repositories ==============================
    if "io_bazel_rules_docker" not in excludes:
        http_archive(
            name = "io_bazel_rules_docker",
            sha256 = "b4775b7c4fc76e3113dab643ee35eefbabca0b44908d0d1c85dcf29cab7c0638",
            strip_prefix = "rules_docker-c7a93454d27e09ef707dfca53887ed0ff4372f04",
            urls = ["https://github.com/bazelbuild/rules_docker/archive/c7a93454d27e09ef707dfca53887ed0ff4372f04.tar.gz"],
        )

    # io_bazel_rules_go is the dependency of container_test rules.
    if "io_bazel_rules_go" not in excludes:
        http_archive(
            name = "io_bazel_rules_go",
            sha256 = "ba79c532ac400cefd1859cbc8a9829346aa69e3b99482cd5a54432092cbc3933",
            urls = ["https://github.com/bazelbuild/rules_go/releases/download/0.13.0/rules_go-0.13.0.tar.gz"],
        )

    if "base_images_docker" not in excludes:
        http_archive(
            name = "base_images_docker",
            sha256 = "e2b1b7254270bb7605e814a9dbf6d1e4ae04a11136ff1714fbfdabe3f87f7cf9",
            strip_prefix = "base-images-docker-12801524f867e657fbb5d1a74f31618aff181ac6",
            urls = ["https://github.com/GoogleCloudPlatform/base-images-docker/archive/12801524f867e657fbb5d1a74f31618aff181ac6.tar.gz"],
        )

    # ================================ GPG Keys ================================
    # Bazel gpg key necessary to install Bazel in the containers.
    if "bazel_gpg" not in excludes:
        native.http_file(
            name = "bazel_gpg",
            sha256 = "30af2ca7abfb65987cd61802ca6e352aadc6129dfb5bfc9c81f16617bc3a4416",
            urls = ["https://bazel.build/bazel-release.pub.gpg"],
        )

    # Docker gpg key necessary to install Docker in the containers.
    if "debian_docker_gpg" not in excludes:
        native.http_file(
            name = "debian_docker_gpg",
            sha256 = "1500c1f56fa9e26b9b8f42452a553675796ade0807cdce11975eb98170b3a570",
            urls = ["https://download.docker.com/linux/debian/gpg"],
        )

    # Docker gpg key necessary to install Docker in the containers.
    if "xenial_docker_gpg" not in excludes:
        native.http_file(
            name = "xenial_docker_gpg",
            sha256 = "1500c1f56fa9e26b9b8f42452a553675796ade0807cdce11975eb98170b3a570",
            urls = ["https://download.docker.com/linux/ubuntu/gpg"],
        )

    # GCloud gpg key necessary to install GCloud in the containers.
    if "gcloud_gpg" not in excludes:
        native.http_file(
            name = "gcloud_gpg",
            sha256 = "226ba1072f20e4ff97ee4f94e87bf45538a900a6d9b25399a7ac3dc5a2f3af87",
            urls = ["https://packages.cloud.google.com/apt/doc/apt-key.gpg"],
        )

    # =============================== Toolchains ===============================
    # Golang
    if "golang_release" not in excludes:
        native.http_file(
            name = "golang_release",
            sha256 = go_pins()['GOLANG_SHA256'],
            urls = ["https://storage.googleapis.com/golang/go" + go_pins()['GOLANG_REVISION'] + ".linux-amd64.tar.gz"],
        )

    # Clang
    if "ubuntu16_04_clang_release" not in excludes:
        native.http_file(
            name = "ubuntu16_04_clang_release",
            sha256 = clang_pins()['UBUNTU16_04_CLANG_SHA256'],
            urls = ["https://storage.googleapis.com/clang-builds-stable/clang-ubuntu16_04/clang_" + clang_pins()['CLANG_REVISION'] + ".tar.gz"],
        )

    # libcxx
    if "ubuntu16_04_libcxx_release" not in excludes:
        native.http_file(
            name = "ubuntu16_04_libcxx_release",
            sha256 = libcxx_pins()['UBUNTU16_04_LIBCXX_SHA256'],
            urls = ["https://storage.googleapis.com/clang-builds-stable/clang-ubuntu16_04/libcxx-msan_" + libcxx_pins()['LIBCXX_REVISION'] + ".tar.gz"],
        )

    # ============================ Bazel installers ============================
    # Official Bazel installer.sh for all supported versions.
    for bazel_version, bazel_sha256 in BAZEL_VERSION_SHA256S.items():
        name = "bazel_%s_installer" % (bazel_version.replace(".", ""))
        if name not in excludes:
            native.http_file(
                name = name,
                sha256 = bazel_sha256,
                urls = [
                    "https://releases.bazel.build/" + bazel_version + "/release/bazel-" + bazel_version + "-installer-linux-x86_64.sh",
                    "https://github.com/bazelbuild/bazel/releases/download/" + bazel_version + "/bazel-" + bazel_version + "-installer-linux-x86_64.sh",
                ],
            )

    # ============================ Azul OpenJDK packages ============================
    if "azul_open_jdk" not in excludes:
        native.http_file(
            name = "azul_open_jdk",
            sha256 = OPENJDK_SHA256,
            urls = ["https://mirror.bazel.build/openjdk/azul-zulu" + JDK_VERSION + "/zulu" + JDK_VERSION + "-linux_x64-allmodules.tar.gz"],
        )

    if "azul_open_jdk_src" not in excludes:
        native.http_file(
            name = "azul_open_jdk_src",
            sha256 = OPENJDK_SRC_SHA256,
            urls = ["https://mirror.bazel.build/openjdk/azul-zulu" + JDK_VERSION + "/zsrc" + JDK_VERSION + ".zip"],
        )
