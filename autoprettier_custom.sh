#!/bin/bash

#Add your configuration files (eslint.json and .prettierrc.js) in the project config/ directory.

$CONFIG="AutoPrettier/config"

# Verifying if zenity is installed
if [ -x "$(command -v zenity)" ]; then
  zenity=true
else
  zenity=false
fi

# Exiting the script directory
cd ..

# Asking to create a project
if [ "$zenity" = true ]; then
  zenity_result=$(zenity --question --text="Create a project with vite?")
  if [ "$?" -eq 0 ]; then
    npm create vite
  fi
else
  echo "Create a project with vite?"
  read -p "type 'y' to create a project with vite." vite_option
  if [ "$vite_option" = "y" ]; then
    npm create vite
  fi
fi

# Project folder name
if [ "$zenity" = true ]; then
  project=$(zenity --entry --text="Type the project name:")
else
  echo "Type the project name:"
  read project
fi

# Finding the project
if [ -d "$project" ]; then
  cd "$project"
else
  echo -e "\e[91mProject not found.\e[0m"
  exit 1
fi

# Removing the default eslint file(s)
if [ -f .eslintrc.js ]; then
  rm .eslintrc.js
fi

if [ -f .eslintrc.cjs ]; then
  rm .eslintrc.cjs
fi

# Eslint files
if [ -f "../$CONFIG/.eslintrc.js" ]; then
  cat "../$CONFIG/.eslintrc.js" > .eslintrc.js
elif [ -f "../$CONFIG/.eslintrc.cjs" ]; then
  cat "../$CONFIG/.eslintrc.cjs" > .eslintrc.cjs
elif [ -f "../$CONFIG/.eslintrc.json" ]; then
  cat "../$CONFIG/.eslintrc.json" > .eslintrc.json
fi

# Prettier files
if [ -f "../$CONFIG/.prettierrc.js" ]; then
  cat "../$CONFIG/.prettierrc.js" > .prettierrc.js
elif [ -f "../$CONFIG/.prettierrc.cjs" ]; then
  cat "../$CONFIG/.prettierrc.cjs" > .prettierrc.cjs
fi

# Installing the eslint and prettier dependencies
npm install --save-dev eslint-plugin-prettier
npm install --save-dev --save-exact prettier
npm install -D eslint-plugin-react
npm install -D eslint-plugin-react-hooks

# Instaling the vscode extensions
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode

# Creating local vscode settings to add the default formatter

if [ -f "../$CONFIG/settings.json" ]; then
  mkdir .vscode
  cat "../$CONFIG/settings.json" > .vscode/settings.json
fi

echo "Configuration done."