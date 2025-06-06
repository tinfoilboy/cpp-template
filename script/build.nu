#!/usr/bin/env nu

const projectName = "{CHANGE_ME}"
const validBuildTypes = [debug, release, relwithdebinfo, minsizerel]
const buildDirname = "build"
const binariesDirname = "bin"

let projectRoot = $env.FILE_PWD | path join .. | path expand
let buildRoot = $projectRoot | path join $buildDirname
let binariesRoot = $projectRoot | path join $binariesDirname

let osName = (sys host | get name) | str downcase

# Validates a given type string against the known list of build types. Returns true if build type is valid, false otherwise.
def validateType [type: string] {
	return (($type | str downcase) in $validBuildTypes)
}

# Generates and compiles the project
#
# Generates CMake build files and compiles the actual project binary.
def "main build" [
	type: string # Build type to use for compilation, can be debug, release, relwithdebinfo, or minsizerel
] {
	if not (validateType $type) {
		let span = (metadata $type).span
		error make {
			msg: "Invalid build type",
			label: {
				text: "Must be debug, release, relwithdebinfo, or minsizerel",
				span: $span
			}
		}
	}

	let binPath = $binariesRoot | path join ($type | str downcase)
	
	if not ($buildRoot | path exists) {
		mkdir $buildRoot
	}

	if not ($binPath | path exists) {
		mkdir $binPath
	}

	let cmakeGenerateArgs = [-DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=($type) -B $buildRoot -S $projectRoot]
	let cmakeBuildArgs = [--build $buildRoot --config $type]
	
	cmake ...$cmakeGenerateArgs; cmake ...$cmakeBuildArgs
}

# Runs the project binary
#
# Runs the resulting executable for the given build type for this project.
def "main run" [
	type: string # Build type of the executable to run, can be debug, release, relwithdebinfo, or minsizerel
] {
	if not (validateType $type) {
		let span = (metadata $type).span
		error make {
			msg: "Invalid build type",
			label: {
				text: "Must be debug, release, relwithdebinfo, or minsizerel",
				span: $span
			}
		}
	}

	let binPath = $binariesRoot | path join ($type | str downcase)
	mut exePath = $binPath | path join $projectName
	if osName == "windows" {
		$exePath = $exePath | append ".exe" | str join ""
	}

	start ($exePath)
}

# Clean build and binary files
#
# Removes both build and binary directories for this project. If no type is specified, then the root of the binaries
# directory is removed. Otherwise, just the build type specified is removed.
def "main clean" [
	type?: string # Build type to clean, can be debug, release, relwithdebuginfo, minsizerel, or omitted for all types
] {
	let binPath = match $type {
		null => $binariesRoot
		_ => {
			if not ($type | is-empty) and not ($type == "all") {
				if not (validateType $type) {
					let span = (metadata $type).span
					error make {
						msg: "Invalid build type",
						label: {
							text: "Must be debug, release, relwithdebinfo, or minsizerel",
							span: $span
						}
					}
				}
			
				$binariesRoot | path join ($type | str downcase)
			}
		}
	}

	if ($buildRoot | path exists) {
		rm -p -r $buildRoot
	}

	if ($binPath | path exists) {
		rm -p -r $binPath
	}
}

def main [] {
	error make {
		msg: "Must specify either build, run, or clean"
	}
}

