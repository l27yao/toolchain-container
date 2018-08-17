package(default_visibility = ["//visibility:public"])
filegroup(
    name = "file",
    srcs = ["%{DOWNLOADED_FILE_PATH}"],
)
