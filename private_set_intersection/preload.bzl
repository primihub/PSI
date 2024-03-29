#
# Copyright 2020 the authors listed in CONTRIBUTORS.md
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")


def psi_preload(external = True, repo_mapping = {}):

    maybe(
        http_archive,
        name = "rules_foreign_cc",
        url = "https://github.com/bazelbuild/rules_foreign_cc/archive/0.5.1.tar.gz",
        sha256 = "33a5690733c5cc2ede39cb62ebf89e751f2448e27f20c8b2fbbc7d136b166804",
        strip_prefix = "rules_foreign_cc-0.5.1",
        repo_mapping = repo_mapping,
    )

    if external:
        maybe(
            git_repository,
            name = "com_github_3rdparty_bazel_rules_openssl",
            remote = "https://github.com/3rdparty/bazel-rules-openssl",
            commit = "fd41d1a19c75dd82979c76fc0b2aadd6c4393e89",
            shallow_since = "1632212203 +0000",
            repo_mapping = repo_mapping,
        )

    
    if "rules_proto" not in native.existing_rules():
        http_archive(
            name = "rules_proto",
            sha256 = "602e7161d9195e50246177e7c55b2f39950a9cf7366f74ed5f22fd45750cd208",
            strip_prefix = "rules_proto-97d8af4dc474595af3900dd85cb3a29ad28cc313",
            urls = [
                "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/97d8af4dc474595af3900dd85cb3a29ad28cc313.tar.gz",
                "https://github.com/bazelbuild/rules_proto/archive/97d8af4dc474595af3900dd85cb3a29ad28cc313.tar.gz",
            ],
        )

    if "io_bazel_rules_go" not in native.existing_rules():
        http_archive(
            name = "io_bazel_rules_go",
            sha256 = "69de5c704a05ff37862f7e0f5534d4f479418afc21806c887db544a316f3cb6b",
            urls = [
                "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.27.0/rules_go-v0.27.0.tar.gz",
                "https://github.com/bazelbuild/rules_go/releases/download/v0.27.0/rules_go-v0.27.0.tar.gz",
            ],
        )


    if "bazel_gazelle" not in native.existing_rules():
        http_archive(
            name = "bazel_gazelle",
            sha256 = "62ca106be173579c0a167deb23358fdfe71ffa1e4cfdddf5582af26520f1c66f",
            urls = [
                "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
                "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
            ],
        )


    if "rules_pkg" not in native.existing_rules():
        RULES_PKG_VER = "0.2.6"
        RULES_PKG_SHA256 = "aeca78988341a2ee1ba097641056d168320ecc51372ef7ff8e64b139516a4937"
        http_archive(
            name = "rules_pkg",
            urls = [
                "https://github.com/bazelbuild/rules_pkg/releases/download/%s-1/rules_pkg-%s.tar.gz" % (RULES_PKG_VER, RULES_PKG_VER),
                "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/%s/rules_pkg-%s.tar.gz" % (RULES_PKG_VER, RULES_PKG_VER),
            ],
            sha256 = RULES_PKG_SHA256,
        )

    if "pybind11_bazel" not in native.existing_rules():
        pybind11_bazel_rev = "26973c0ff320cb4b39e45bc3e4297b82bc3a6c09"
        http_archive(
            name = "pybind11_bazel",
            strip_prefix = "pybind11_bazel-" + pybind11_bazel_rev,
            urls = ["https://github.com/pybind/pybind11_bazel/archive/" + pybind11_bazel_rev + ".zip"],
            sha256 = "a5666d950c3344a8b0d3892a88dc6b55c8e0c78764f9294e806d69213c03f19d",
        )

    if "pybind11" not in native.existing_rules():
        http_archive(
            name = "pybind11",
            build_file = "@pybind11_bazel//:pybind11.BUILD",
            strip_prefix = "pybind11-2.6.0",
            urls = ["https://github.com/pybind/pybind11/archive/v2.6.0.zip"],
            sha256 = "c2ed3fc84db08f40a36ce1d03331624ed6977497b35dfed36a1423396928559a",
        )

    if "rules_python" not in native.existing_rules():
        http_archive(
            name = "rules_python",
            url = "https://github.com/bazelbuild/rules_python/releases/download/0.1.0/rules_python-0.1.0.tar.gz",
            sha256 = "b6d46438523a3ec0f3cead544190ee13223a52f6a6765a29eae7b7cc24cc83a0",
        )

    if "io_bazel_rules_rust" not in native.existing_rules():
        http_archive(
            name = "io_bazel_rules_rust",
            sha256 = "75b29ba47ff4ef81f48574d1109bb6612788212524afe99e21467c71c980baa5",
            strip_prefix = "rules_rust-8cfa049d478ad33e407d572e260e912bdb31796a",
            urls = [
                # Master branch as of 25/07/2020
                # "https://github.com/bazelbuild/rules_rust/archive/8cfa049d478ad33e407d572e260e912bdb31796a.tar.gz",
                "https://primihub.oss-cn-beijing.aliyuncs.com/tools/rules_rust-8cfa049d478ad33e407d572e260e912bdb31796a.tar.gz",
            ],
        )

    if "bazel_skylib" not in native.existing_rules():
        http_archive(
            name = "bazel_skylib",
            sha256 = "e5d90f0ec952883d56747b7604e2a15ee36e288bb556c3d0ed33e818a4d971f2",
            strip_prefix = "bazel-skylib-1.0.2",
            url = "https://github.com/bazelbuild/bazel-skylib/archive/1.0.2.tar.gz",
        )

    # gRPC for PJC.
    if "com_github_grpc_grpc" not in native.existing_rules():
        http_archive(
            name = "com_github_grpc_grpc",
            # sha256 = "2060769f2d4b0d3535ba594b2ab614d7f68a492f786ab94b4318788d45e3278a",
            strip_prefix = "grpc-v1.42.x-openssl",
            urls = [
                # "https://github.com/grpc/grpc/archive/v1.33.2.tar.gz",
                "https://primihub.oss-cn-beijing.aliyuncs.com/tools/grpc-v1.42.x-openssl.tar.gz"
            ],
        )

    # For gRPC.
    # if "build_bazel_rules_apple" not in native.existing_rules():
    #     http_archive(
    #         name = "build_bazel_rules_apple",
    #         strip_prefix = "rules_apple-b869b0d3868d78a1d4ffd866ccb304fb68aa12c3",
    #         sha256 = "bdc8e66e70b8a75da23b79f1f8c6207356df07d041d96d2189add7ee0780cf4e",
    #         urls = [
    #             "https://storage.googleapis.com/grpc-bazel-mirror/github.com/bazelbuild/rules_apple/archive/b869b0d3868d78a1d4ffd866ccb304fb68aa12c3.tar.gz",
    #             "https://github.com/bazelbuild/rules_apple/archive/b869b0d3868d78a1d4ffd866ccb304fb68aa12c3.tar.gz",
    #         ],
    #     )

    # if "build_bazel_apple_support" not in native.existing_rules():
    #     http_archive(
    #         name = "build_bazel_apple_support",
    #         urls = [
    #             "https://storage.googleapis.com/grpc-bazel-mirror/github.com/bazelbuild/apple_support/releases/download/0.7.1/apple_support.0.7.1.tar.gz",
    #             "https://github.com/bazelbuild/apple_support/releases/download/0.7.1/apple_support.0.7.1.tar.gz",
    #         ],
    #         sha256 = "122ebf7fe7d1c8e938af6aeaee0efe788a3a2449ece5a8d6a428cb18d6f88033",
    #     )

    if "upb" not in native.existing_rules():
        http_archive(
            name = "upb",
            sha256 = "7992217989f3156f8109931c1fc6db3434b7414957cb82371552377beaeb9d6c",
            strip_prefix = "upb-382d5afc60e05470c23e8de19b19fc5ad231e732",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/protocolbuffers/upb/archive/382d5afc60e05470c23e8de19b19fc5ad231e732.tar.gz",
                "https://github.com/protocolbuffers/upb/archive/382d5afc60e05470c23e8de19b19fc5ad231e732.tar.gz",
            ],
        )
    if "rules_proto_grpc" not in native.existing_rules():
        http_archive(
            name = "rules_proto_grpc",
            urls = [
              #"https://github.com/rules-proto-grpc/rules_proto_grpc/archive/2.0.0.tar.gz",
              "https://primihub.oss-cn-beijing.aliyuncs.com/tools/rules_proto_grpc-2.0.0.tar.gz"
            ],
            sha256 = "d771584bbff98698e7cb3cb31c132ee206a972569f4dc8b65acbdd934d156b33",
            strip_prefix = "rules_proto_grpc-2.0.0",
        )
