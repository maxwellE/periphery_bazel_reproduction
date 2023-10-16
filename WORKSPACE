load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "build_bazel_rules_apple",
    sha256 = "20da675977cb8249919df14d0ce6165d7b00325fb067f0b06696b893b90a55e8",
    url = "https://github.com/bazelbuild/rules_apple/releases/download/3.0.0/rules_apple.3.0.0.tar.gz",
)

load(
    "@build_bazel_rules_apple//apple:repositories.bzl",
    "apple_rules_dependencies",
)

apple_rules_dependencies()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()

load(
    "@build_bazel_rules_swift//swift:extras.bzl",
    "swift_rules_extra_dependencies",
)

swift_rules_extra_dependencies()

load(
    "@build_bazel_apple_support//lib:repositories.bzl",
    "apple_support_dependencies",
)

apple_support_dependencies()

http_archive(
    name = "com_github_peripheryapp_periphery",
    build_file_content = """
load("@bazel_skylib//rules:native_binary.bzl", "native_binary")

native_binary(
    name = "periphery_tool",
    src = "periphery",
    out = "periphery_tool-bazel",
    visibility = ["//visibility:public"],
)
            """,
    sha256 = "8e43ad4fb238b0debbb15d89c7026243a4a600db37170bd7a8076e53d156245d",
    type = "zip",
    url = "https://github.com/peripheryapp/periphery/releases/download/2.16.0/periphery-2.16.0.zip",
)
