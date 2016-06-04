#!/bin/sh

#
# test.sh
#
# Runs this directory's copy of chext against a series of files in
# ./test_dir/ and checks the results
#

# Print arguments to file descriptor 2 (stderr)
perror() {
	printf "%b" "$*" >&2;
}

# Get this script's parent directory
parent_dir="${0%\/*}"

# Make sure ${parent_dir}/test_dir does not exist
## If it does, ask user for permission to overwrite
## If permission is denied, exit 1
test_dir="${parent_dir}/test_dir"
if [ -d "$test_dir" ]; then
	printf "%s" "$test_dir already exists. Remove it to continue (y/N)? "
	read -r delete_dir
	case "$delete_dir" in
		# Delete $test_dir if user input 'y' or 'Y'
		[yY]*)
			rm -r "$test_dir"
			;;
		# Else exit 1
		*)
			perror "%s" "$0 can not be run with pre-existing ${test_dir}\n"
			exit 1
	esac
fi
# Create $test_dir
mkdir "$test_dir"

# Get the parent directory's `chext`
chext="${parent_dir}/chext"

printf "Change foo.txt to foo.csv\n"
touch "${test_dir}/foo.txt"
"$chext" "-v" "${test_dir}/foo.txt" "csv"
if [ ! -e "${test_dir}/foo.csv" ]; then
	printf "Problem changing foo.txt to foo.csv\n"
	exit 2
fi

printf "Remove the extension from foo.csv\n"
"$chext" "-v" "${test_dir}/foo.csv" ""
if [ ! -e "${test_dir}/foo" ]; then
	printf "Problem removing extension from a file\n"
	exit 3
fi

printf "Add the txt extension to foo\n"
"$chext" "-v" "${test_dir}/foo" "txt"
if [ ! -e "${test_dir}/foo.txt" ]; then
	printf "Problem adding extension to a file\n"
	exit 3
fi

printf "Nothing should happen when changing to txt again\n"
"$chext" "-v" "${test_dir}/foo.txt" "txt"
if [ ! -e "${test_dir}/foo.txt" ]; then
	printf "Problem changing to same extension on a file\n"
	exit 3
fi

printf "Change .foo.txt to .foo.csv\n"
mv "${test_dir}/foo.txt" "${test_dir}/.foo.txt"
"$chext" "-v" "${test_dir}/.foo.txt" "csv"
if [ ! -e "${test_dir}/.foo.csv" ]; then
	printf "Problem changing extension for a hidden file\n"
	exit 4
fi

printf "Remove the extension from .foo.csv\n"
"$chext" "-v" "${test_dir}/.foo.csv" ""
if [ ! -e "${test_dir}/.foo" ]; then
	printf "Problem removing extension from a hidden file\n"
	exit 4
fi

printf "Add the txt extension to .foo\n"
"$chext" "-v" "${test_dir}/.foo" "txt"
if [ ! -e "${test_dir}/.foo.txt" ]; then
	printf "Problem adding extension to a hidden file\n"
	exit 3
fi

printf "Nothing should happen when changing to txt again\n"
"$chext" "-v" "${test_dir}/.foo.txt" "txt"
if [ ! -e "${test_dir}/.foo.txt" ]; then
	printf "Problem changing to same extension on a hidden file\n"
	exit 3
fi

# Delete $test_dir
rm -r "$test_dir"
