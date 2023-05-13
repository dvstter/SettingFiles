#!/bin/bash

git init .
curl -o .gitignore --fail --show-error --silent --location https://raw.github.com/github/gitignore/master/Python.gitignore
echo -e ".idea/\n.DS_Store\n" >> .gitignore
git add .gitignore && git commit -m "Added gitignore from GitHub."
