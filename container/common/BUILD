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

licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

exports_files(glob(["*.yaml"]))

load(
    "//third_party/clang:revision.bzl",
    "clang_pins",
)
load(
    "//third_party/golang:revision.bzl",
    "go_pins",
)
load(
    "//third_party/openjdk:revision.bzl",
    "JDK_VERSION",
    "JDK_VERSION_DECODED",
)

genrule(
    name = "generate_clang_yaml",
    srcs = ["clang.yaml.tpl"],
    outs = ["clang.yaml"],
    cmd = "sed 's|{_CLANG_REVISION}|" + clang_pins()['CLANG_REVISION'].lstrip("r") + "|' <$< >$@",
)

genrule(
    name = "generate_go_yaml",
    srcs = ["go.yaml.tpl"],
    outs = ["go.yaml"],
    cmd = "sed 's|{_GOLANG_REVISION}|" + go_pins()['GOLANG_REVISION'] + "|' <$< >$@",
)

genrule(
    name = "generate_java_yaml",
    srcs = ["java.yaml.tpl"],
    outs = ["java.yaml"],
    cmd = (
        "sed 's|{_JDK_VERSION}|" + JDK_VERSION + "|g; s|{_JDK_VERSION_DECODED}|" + JDK_VERSION_DECODED + "|g' <$< >$@"
    ),
)
