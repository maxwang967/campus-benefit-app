#!/bin/bash
# Publish the web to Gitee immediately.
echo -e "Building Flutter Web..."
flutter build web --release
echo -e "Git committing and pushing..."
cd build/web
git add .
git commit -m "auto-commit"
git push
open https://gitee.com/morningstarwang/static_website/pages
echo -e "Done. \n"
