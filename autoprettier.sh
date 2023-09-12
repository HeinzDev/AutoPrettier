#!/usr/bin/env bash

# Verifying if zenity is installed
if [ -x "$(command -v zenity)" ]; then
  zenity=true
else
  zenity=false
fi

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

# Creating the eslintrc.json config
cat <<EOL > .eslintrc.json
{
  "env": {
    "browser": true,
    "es2021": true
  },
  "settings": {
    "react": {
      "version": "detect"
    }
  },
  "extends": [
    "standard-with-typescript",
    "plugin:react/recommended",
    "plugin:prettier/recommended",
    "plugin:react-hooks/recommended"
  ],
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "plugins": [
    "react",
    "prettier"
  ],
  "rules": {
    "react/prop-types": "off",
    "react/react-in-jsx-scope": "off",
    "@typescript-eslint/explicit-module-boundary-types": "off"
  }
}
EOL

# Installing the eslint and prettier dependencies
npm install --save-dev eslint-plugin-prettier
npm install --save-dev --save-exact prettier
npm install -D eslint-plugin-react
npm install -D eslint-plugin-react-hooks

# Instaling the vscode extensions
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode

# Creating local vscode settings to add the default formatter
mkdir .vscode

# Creating the vscode settings file
cat <<EOL > .vscode/settings.json
{
  "explorer.confirmDelete": false,
  "explorer.confirmDragAndDrop": false,
  "security.workspace.trust.untrustedFiles": "open",
  "git.autofetch": true,
  "workbench.colorTheme": "Sweet Dracula",
  "workbench.iconTheme": "material-icon-theme",
  "material-icon-theme.folders.theme": "classic",
  "material-icon-theme.folders.color": "#6273a6",
  "javascript.updateImportsOnFileMove.enabled": "always",
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "prettier.singleQuote": true,
  "explorer.compactFolders": false
}
EOL

echo "Configuration done."
