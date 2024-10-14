#!/bin/bash

# Purpose: This script concatenates multiple text files into a single output file.
# Usage: ./concat_files.sh -o outputfile.txt file1.txt file2.txt ...
# Example: ./concat_files.sh -o combined.txt file1.txt file2.txt
#Author: Jacob Berlekamp

# Function to display help
function usage() {
    echo "Usage: $0 -o outputfile [file1 file2 ...]"
    echo "Concatenate multiple text files into a single output file."
    echo ""
    echo "Options:"
    echo "  -o    Specify the output file name."
    echo "  -h    Show this help message."
    exit 1
}

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: No arguments provided."
    usage
fi

# Use getopt to parse options
output_file=""
while getopts "o:h" opt; do
    case ${opt} in
        o)
            output_file=$OPTARG
            ;;
        h)
            usage
            ;;
        *)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Check if output file is provided
if [ -z "$output_file" ]; then
    echo "Error: Output file not specified."
    usage
fi

# Check if at least one input file is provided
if [ $# -eq 0 ]; then
    echo "Error: No input files provided."
    usage
fi

# Handle invalid file paths
for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "Error: File $file does not exist." >&2
        exit 1
    fi
done

# Concatenate files
echo "Concatenating files into $output_file..."
cat "$@" > "$output_file"
echo "Concatenation complete. Output saved to $output_file."

# Using a regular expression to validate that the output file is a .txt file
if [[ ! "$output_file" =~ \.txt$ ]]; then
    echo "Warning: Output file does not have a .txt extension. Consider renaming it."
fi
