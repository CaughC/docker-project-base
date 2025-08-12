# Docker Project Base

This project provides a flexible and modular Docker environment. It uses `docker-compose` along with external configuration files to easily switch between different build configurations and run post-start scripts.

## Quick Start

1.  **Choose a configuration:**

    Select one of the available configurations in the `configs` directory (e.g., `gpu.env`, `gpu-conda.env`).

2.  **Build and run the container:**

    Use the `--env-file` flag with `docker-compose` to specify your chosen configuration.

    ```bash
    # Example using the gpu-conda configuration
    docker-compose --env-file configs/gpu-conda.env up --build -d
    ```

3.  **Access the container:**

    ```bash
    docker-compose exec app bash
    ```

4.  **Stop the container:**

    ```bash
    docker-compose down
    ```

## How it Works

### Build Configurations

*   The `docker-compose.yml` is configured to accept build arguments (`BASE_IMAGE`, `INSTALL_CONDA`).
*   The `configs` directory contains `.env` files that define these build arguments for different configurations.
*   By using the `--env-file` flag, you can easily switch between configurations without modifying any Dockerfiles.

### Post-Start Scripts

*   The Docker image is built with an `entrypoint.sh` script.
*   This script automatically executes any `.sh` files found in the `/docker-entrypoint.d` directory when the container starts.
*   The `docker-compose.yml` mounts the local `docker-entrypoint.d` directory into the container.
*   To add your own post-start logic, simply create a new shell script in the `docker-entrypoint.d` directory.

## Customization

*   **To create a new build configuration:**

    1.  Create a new `.env` file in the `configs` directory (e.g., `my-config.env`).
    2.  Define the `BASE_IMAGE` and `INSTALL_CONDA` variables in your new file.
    3.  Run `docker-compose` with `--env-file configs/my-config.env`.

*   **To add a post-start script:**

    1.  Create a new `.sh` file in the `docker-entrypoint.d` directory.
    2.  Add your desired commands to the script.
    3.  The script will be automatically executed the next time you start the container.