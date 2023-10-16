load(
    "//rules:periphery_json_report.bzl",
    "periphery_json_report",
)
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "Sources",
    srcs = [
        "AppDelegate.swift",
    ],
    module_name = "App",
    deps = [
        "//src/module/sources:Module",
    ],
)

periphery_json_report(
    name = "app_json_report",
    deps = [
        ":app",
    ],
)

ios_application(
    name = "app",
    bundle_id = "com.example.hello-world-swift",
    families = [
        "iphone",
    ],
    infoplists = [":Info.plist"],
    minimum_os_version = "15.0",
    deps = [":Sources"],
)
