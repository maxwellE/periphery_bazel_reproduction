load(
    "//aspects:collect_periphery_info.bzl",
    "collect_periphery_info_aspect",
)
load("//aspects:collect_file_inputs.bzl", "collect_file_inputs")

PeripheryReportInfo = provider(
    doc = "Provides periphery report information for usage by other targets.",
    fields = {
        "json_report": "A File containing a JSON periphery report.",
    },
)

def _periphery_json_report_impl(ctx):
    periphery_file_inputs = collect_file_inputs(ctx)
    args = ctx.actions.args()
    args.add_all([
        "--skip-build",
        "--format=json",
    ])
    if ctx.attr.report_exclude_globs:
        glob = "|".join(ctx.attr.report_exclude_globs)
        args.add("--report-exclude=%s" % glob)
    args.add_all("--file-targets-path", periphery_file_inputs.periphery_file_target_mapping_files)
    args.add_all("--index-store-path", periphery_file_inputs.periphery_indexstore_files, expand_directories = False)
    output_file = ctx.actions.declare_file(ctx.label.name + "_periphery_report.json")
    ctx.actions.run_shell(
        tools = [
            ctx.executable._periphery_tool,
        ] + periphery_file_inputs.runfiles.files.to_list(),
        arguments = [args],
        outputs = [output_file],
        command = "{executable} scan $@ | /usr/bin/sed -e \"s@$PWD/@@g\" > {output_path}".format(
            executable = ctx.executable._periphery_tool.path,
            output_path = output_file.path,
        ),
        mnemonic = "PeripheryJsonReport",
    )
    return [
        DefaultInfo(
            files = depset([output_file]),
            runfiles = periphery_file_inputs.runfiles,
        ),
        PeripheryReportInfo(
            json_report = output_file,
        ),
    ]

periphery_json_report = rule(
    implementation = _periphery_json_report_impl,
    doc = "Creates a periphery json report for the given targets.",
    attrs = {
        "deps": attr.label_list(
            aspects = [collect_periphery_info_aspect],
            doc = "The targets to generate a periphery json report from.",
        ),
        "report_exclude_globs": attr.string_list(
            default = [],
            doc = "A list of file globs to exclude from the report.",
        ),
        "_periphery_tool": attr.label(
            default = "@com_github_peripheryapp_periphery//:periphery_tool",
            executable = True,
            cfg = "exec",
        ),
    },
)
