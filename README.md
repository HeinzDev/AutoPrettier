# AutoPrettier

AutoPrettier is a project automation script developed to simplify the process of setting up projects with ESLint and Prettier. If you've encountered issues while trying to configure Prettier alongside ESLint, this script can streamline the setup process for you.

## Script Customization

The recommended way to use AutoPrettier is by keeping the AutoPrettier folder parallel to your projects, and utilizing the `autoprettier_custom.sh` script to create your configuration files just once (if they don't already exist) and add them to the `config/` directory of this project. You can also choose to use the `autoprettier.sh` script with my default configuration embedded.

### Files in the `/config` Directory

When using the custom script, add the following configuration files to the `/config` directory of your project:

- **Eslint Configuration:**

  - `.eslintrc.js` or `.eslintrc.cjs` or `.eslintrc.json`

  You can also generate one with `npm init @eslint/config`.

- **Prettier Configuration:**

  - `.prettierrc.js` or `.prettierrc.cjs`

- **VSCode Settings (Optional):**

  - `settings.json`

  (The IDE settings configuration file is included here because VSCode requires specific formatting configurations for Prettier to work seamlessly with ESLint. You'll find an example file in the `config/` folder.)

## Running the script

1. Clone the AutoPrettier repository and place it parallel to your projects directory.

```bash
 $ git clone https://github.com/HeinzDev/ | cd AutoPrettier
```

2. If you plan to use your own configurations (recommended), add the configuration files to the `config/` directory.

3. Enable execution permissions for the script:

```bash
 $ chmod +x autoprettier_custom.sh
```

or

```bash
 $ chmod +x autoprettier.sh
```

4. Run the `autoprettier_custom.sh` with your configuration files, or use the `autoprettier.sh` script with my default configuration.

```bash
 $ ./autoprettier_custom.sh
```

or

```bash
 $ ./autoprettier.sh
```

4. The script will prompt you to either start a new project with Vite or run the script in an existing project. That's it!
