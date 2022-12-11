#!/bin/sh
helpFunction() {
    echo ""
    echo "Usage: $0 -p path where create project -n name of project"
    exit 1 # Exit script after printing help
}
while getopts "p:n:" opt; do
    case "$opt" in
    p) parameterA="$OPTARG" ;;
    n) parameterB="$OPTARG" ;;
    ?) helpFunction ;; # Print helpFunction in case parameter is non-existent
    esac
done
# Print helpFunction in case parameters are empty
if [ -z "$parameterA" ] || [ -z "$parameterB" ]; then
    echo "Some or all of the parameters are empty"
    helpFunction
fi

mkdir -p "$parameterA/$parameterB"
mkdir -p "$parameterA/$parameterB/dist"
mkdir -p "$parameterA/$parameterB/src"
mkdir -p "$parameterA/$parameterB/src/styles"
mkdir -p "$parameterA/$parameterB/src/components"
touch "$parameterA/$parameterB/src/app.pug"
touch "$parameterA/$parameterB/src/styles/app.sass"
echo "{\"name\": \"$parameterB\",\"version\": \"1.0.0\",\"main\": \"index.js\",\"license\": \"MIT\",\"devDependencies\": {\"pug\": \"^3.0.2\",\"sass\": \"^1.56.1\"},\"scripts\": {\"build\": \"pug src/app.pug --out ./dist/\",\"pug_watch\": \"pug -w src/app.pug --out ./dist/\",\"sass_watch\": \"sass --watch src/styles/app.sass ./dist/app.css\"}}" >> "$parameterA/$parameterB/package.json"
cd "$parameterA/$parameterB"
exec "yarn"
echo "New project has been created!\nWith name: $parameterB\nPath: $parameterA"
