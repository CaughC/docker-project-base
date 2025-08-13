# Docker Project Base

This project provides a flexible and modular Docker environment, designed for easy switching between different build configurations and seamless execution of post-start scripts. It leverages `docker-compose` and external configuration files for a streamlined workflow.

## ✨ Features

*   **Flexible Build Configurations:** Easily switch between different Docker image builds (e.g., with or without Conda, different base images) using `.env` files.
*   **Automated Post-Start Scripts:** Automatically execute custom shell scripts upon container startup for environment setup, dependency installation, or application launch.
*   **Modular and Extensible:** Simple to add new configurations and post-start behaviors without modifying core Dockerfiles.

## 🚀 Quick Start

Follow these steps to get your Docker environment up and running:

1.  **Choose a Configuration:**
    Select one of the predefined environment configurations from the `configs/` directory.
    *   `gpu.env`: For GPU-enabled environments.
    *   `gpu-conda.env`: For GPU-enabled environments with Conda pre-installed.

2.  **Build and Run the Container:**
    Use `docker-compose` with the `--env-file` flag to specify your chosen configuration. This command will build the Docker image (if not already built) and start the container in detached mode (`-d`).

    ```bash
    # Example: Using the GPU with Conda configuration
    docker-compose --env-file configs/gpu-conda.env up --build -d
    ```

3.  **Access the Container:**
    Once the container is running, you can access its shell to interact with your environment.

    ```bash
    docker-compose exec app bash
    ```

4.  **Stop the Container:**
    To stop and remove the running container, use:

    ```bash
    docker-compose down
    ```

## ⚙️ How It Works

### Build Configurations

The `docker-compose.yml` file is set up to accept build arguments, specifically `BASE_IMAGE` and `INSTALL_CONDA`. The `.env` files located in the `configs/` directory define these arguments for various scenarios. By using the `--env-file` flag, you can effortlessly switch between these configurations without needing to modify the `Dockerfile.args` directly.

### Post-Start Scripts

The Docker image's `entrypoint.sh` script is designed to be smart. It automatically discovers and executes any `.sh` files placed within the `/docker-entrypoint.d` directory inside the container when it starts. The `docker-compose.yml` conveniently mounts your local `docker-entrypoint.d` directory into the container, allowing you to easily add your own custom post-start logic. Just create a new shell script in this directory, and it will be executed automatically.

## 🛠️ Customization

### Creating a New Build Configuration

1.  Create a new `.env` file in the `configs/` directory (e.g., `my-custom-config.env`).
2.  Define the `BASE_IMAGE` and `INSTALL_CONDA` variables within this new file according to your needs.
3.  Run `docker-compose` with your new configuration:
    ```bash
    docker-compose --env-file configs/my-custom-config.env up --build -d
    ```

### Adding a Post-Start Script

1.  Create a new `.sh` file in the `docker-entrypoint.d/` directory (e.g., `02-install-my-tool.sh`).
2.  Add your desired shell commands to this script.
3.  The script will be automatically executed the next time you start the container.
