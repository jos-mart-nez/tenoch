#!venv/bin/python


import os
import shutil
import subprocess
import time
from argparse import ArgumentParser, Namespace
from pathlib import Path

GLOBALS = {"build_base": Path("build").resolve()}


def warning(msg: str) -> None:
    print(f"Warning: {msg}")


def clean(_: Namespace) -> bool:
    print("Cleaning...")
    try:
        shutil.rmtree(GLOBALS["build_base"])
        print(
            f"Directory '{GLOBALS["build_base"]}' and its contents have been removed successfully."
        )
    except FileNotFoundError:
        warning(f"Directory '{GLOBALS["build_base"]}' not found.")
    except Exception as exception:
        return panic(
            f"Could not remove directory '{GLOBALS["build_base"]}'. Reason: {exception}"
        )
    return True


def configure(args: Namespace) -> bool:
    print("Configuring...")
    if args.build_type is None:
        return panic("No build type provided")
    match args.build_type:
        case "debug":
            print("Configuring debug build...")
        case "release":
            print("Configuring release build...")
        case _:
            return panic(
                f"Unknown build type '{args.build_type}' expected 'debug' or 'release'"
            )
    GLOBALS["build_dir"] = GLOBALS["build_base"].joinpath(args.build_type)
    result = subprocess.run(
        [
            "cmake",
            "-S",
            ".",
            "-B",
            GLOBALS["build_dir"],
            "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
            "-DCMAKE_C_COMPILER=clang",
            "-DCMAKE_CXX_COMPILER=clang++",
            "-G",
            "Ninja",
        ],
    )
    if result.returncode != 0:
        return panic(f"Failed to configure")
    try:
        src = GLOBALS["build_dir"].joinpath("compile_commands.json")
        dst = GLOBALS["build_base"].joinpath("compile_commands.json")
        shutil.copy2(src, dst)
    except Exception as e:
        return panic("Failed to copy compile_commands.json")
    return True


def build_only(_: Namespace) -> bool:
    print("Building...")
    result = subprocess.run(
        ["cmake", "--build", GLOBALS["build_dir"], "--parallel", f"{os.cpu_count()}"]
    )
    if result.returncode != 0:
        return panic(f"Failed to build")
    return True


def build(args: Namespace) -> bool:
    if not measure(configure, "Configure", args):
        return False
    return measure(build_only, "Build only", args)


def run_only(args: Namespace) -> bool:
    print("Running...")
    if args.run_target is None:
        return panic("No run target provided")
    GLOBALS["bin_dir"] = GLOBALS["build_dir"].joinpath("bin")
    GLOBALS["run_dir"] = GLOBALS["bin_dir"].joinpath(args.run_target)
    GLOBALS["run_target"] = GLOBALS["run_dir"].joinpath(args.run_target)
    os.chdir(GLOBALS["run_dir"])
    result = subprocess.run([GLOBALS["run_target"]])
    if result.returncode != 0:
        warning(f"Run returned: {result.returncode}")
        return False
    return True


def run(args: Namespace) -> bool:
    if not measure(build, "Build", args):
        return False
    return measure(run_only, "Run only", args)


def freeze(args: Namespace) -> bool:
    print("Freezing...")
    result = subprocess.run(["pip", "freeze"])
    if result.returncode != 0:
        return panic(f"Failed to freeze")
    print(result.stdout)
    return True


def panic(msg: str) -> bool:
    print(f"Error! {msg}")
    return False


def main() -> None:
    print("Tenoch management script")
    parser = ArgumentParser(description="tenoch management script")
    parser.add_argument(
        "--action",
        type=str,
        help="action to perform: build, run, configure, clean, freeze",
    )
    parser.add_argument("--build-type", type=str, help="debug or release")
    parser.add_argument("--run-target", type=str, help="target to run")
    args = parser.parse_args()
    if args.action is None:
        return panic("No action provided")
    match args.action:
        case "build":
            return measure(build, "Build", args)
        case "run":
            return measure(run, "Run", args)
        case "configure":
            return measure(configure, "Configure", args)
        case "clean":
            return measure(clean, "Clean", args)
        case "freeze":
            return measure(freeze, "Freeze", args)
        case _:
            return panic(f"Unknown action '{args.action}'")


def measure(fun, name: str = "Function", *args, **kwargs):
    start = time.perf_counter()
    ret = fun(*args, **kwargs)
    end = time.perf_counter()
    print(f"{name} took {end-start:.3f} seconds")
    return ret


if __name__ == "__main__":
    if not measure(main, "All"):
        exit(1)
