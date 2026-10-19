#!/usr/bin/env bash
set -e
echo "##### $(basename $BASH_SOURCE) #####"

./setup-gitconfig.sh
./setup-symlinks.sh
./setup-homebrew.sh
./setup-deps.sh
./setup-osx.sh

echo "✅ ✅ ✅"
echo "🎉 🎉 🎉"
