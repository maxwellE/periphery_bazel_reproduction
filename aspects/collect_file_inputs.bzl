load(
    "//aspects:collect_periphery_info.bzl",
    "PeripheryInfo",
)

def collect_file_inputs(ctx):
    runfiles = ctx.runfiles(
        files = [
            ctx.executable._periphery_tool,
        ],
    )
    periphery_file_target_mapping_files = []
    periphery_indexstore_files = []
    srcs_files = []
    for dep in ctx.attr.deps:
        dep_runfiles = []
        periphery_file_target_mapping_runfiles = ctx.runfiles(transitive_files = dep[PeripheryInfo].periphery_file_target_mapping)
        periphery_file_target_mapping_files.extend(dep[PeripheryInfo].periphery_file_target_mapping.to_list())
        dep_runfiles.append(periphery_file_target_mapping_runfiles)
        periphery_indexstore_paths_depset = ctx.runfiles(transitive_files = dep[PeripheryInfo].periphery_indexstore)
        periphery_indexstore_files.extend(dep[PeripheryInfo].periphery_indexstore.to_list())
        dep_runfiles.append(periphery_indexstore_paths_depset)
        srcs_depset = ctx.runfiles(transitive_files = dep[PeripheryInfo].srcs)
        srcs_files.extend(dep[PeripheryInfo].srcs.to_list())
        dep_runfiles.append(srcs_depset)
        for dep_runfile in dep_runfiles:
            runfiles = runfiles.merge(dep_runfile)
    return struct(
        runfiles = runfiles,
        periphery_file_target_mapping_files = periphery_file_target_mapping_files,
        periphery_indexstore_files = periphery_indexstore_files,
        srcs_files = srcs_files,
    )
