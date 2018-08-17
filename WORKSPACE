
# Copyright 2017 The Bazel Authors. All rights reserved.
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
workspace(name = "toolchain_container")

load(
    "//repositories:repositories.bzl",
    bazel_toolchains_repositories = "repositories",
)

bazel_toolchains_repositories()

load(
    "@io_bazel_rules_docker//container:container.bzl",
    container_repositories = "repositories",
)

container_repositories()

load(
    "//repositories:images.bzl",
    bazel_toolchains_images = "images",
)

bazel_toolchains_images()

load("@io_bazel_rules_go//go:def.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

load(
    "//container/ubuntu16_04/debian_pkgs:revision.bzl",
    "debian_pkgs_tar_pins",
)

load("//rules:gcs.bzl", "gcs_file")

gcs_file(
   name = "ubuntu16_04_debian_pkgs",
   file = "ubuntu16-04-debian_pkgs_" + debian_pkgs_tar_pins()["DEBIAN_PKGS_TAR_REVISION"] + ".tar",
   bucket = "gs://debian-pkgs-tar/ubuntu16_04",
   sha256 = debian_pkgs_tar_pins()["UBUNTU16_04_DEBIAN_PKGS_TAR_SHA256"],
)
