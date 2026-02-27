#!/bin/bash
set -e

if [ -z "$name" ]; then
    echo "Error: You should provide the "name" argument"
    exit 1
fi

if [ -z "$path" ]; then
    echo "Error: You should provide the "path" argument"
    exit 1
fi

if [ ! -z "$path" ]; then
    if [ ! -d "$path" ]; then
        mkdir -p "$path"
    fi
    cd $path
fi

flutter create --template=package $1
cd $name && rm -rf LICENSE CHANGELOG.md README.md analysis_options.yaml pubspec.yaml lib/$name.dart test/ linux macos windows android ios

touch lib/$name.dart
echo "library $name;" > lib/$name.dart

touch pubspec.yaml
echo "name: $name
description: A $name package.
version: 0.0.1
publish_to: none
resolution: workspace

environment:
  sdk: ^3.9.2
  flutter: \">=3.0.0\"

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_lints: ^5.0.0
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true" > pubspec.yaml

if [ $? -eq 0 ]; then
    echo "Package $name created :)"
else
    echo "Error to create $name package"
fi