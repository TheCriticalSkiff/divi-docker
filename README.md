# Divi Daemon Docker Image

This Docker image provides a containerized setup for running the Divi daemon (divid). It's based on Alpine Linux and includes the necessary dependencies to run the Divi node.

## Features

- Divi daemon version 3.0.0
- Configurable RPC settings
- Support for testnet and regtest modes
- Optional snapshot download for faster synchronization
- Supervisor for running the Divi daemon and other services

## Usage

### Cloning the repository

```bash
git clone https://github.com/TheCriticalSkiff/divi-docker.git
```

### Building the Image

```bash
docker build -t divi_v2 .
```

### Running the Container

To run the container with the default configuration:

```bash
docker run -d --name divid_container divi_v2
```

### Running the Container with Snapshot

To run the container with a snapshot for faster synchronization:

```bash
docker run -d --name divid_container divi_v2 -e DIVI_SNAPSHOT=true
```

### Environment Variables

- `DIVI_RPCUSER`: Set the RPC username (default: `divirpc`)
- `DIVI_RPCPASSWORD`: Set the RPC password (default: random)
- `DIVI_OPENRPC`: Allow all IP addresses to connect to the RPC server (default: `false`)
- `DIVI_RPCPORT`: Set the RPC port (default: `51473`)
- `DIVI_PORT`: Set the P2P port (default: `51472`)
- `DIVI_TESTNET`: Enable testnet mode (default: `false`)
- `DIVI_REGTEST`: Enable regtest mode (default: `false`)
- `DIVI_SNAPSHOT`: Enable snapshot mode for faster synchronization (default: `false`)
- `DIVI_SNAPSHOT_URL`: Set the URL for the snapshot (default: `https://snapshots.diviproject.org/dist/DIVI-snapshot.tar.gz`)
- `DIVI_SNAPSHOT_FILENAME`: Set the filename for the snapshot (default: `DIVI-snapshot.tar.gz`)
- `DIVI_CONF`: Set the configuration file (default: `/etc/divi/divi.conf`)
- `DIVI_DATADIR`: Set the data directory (default: `/var/lib/divid`)
- `DIVI_ADDNODE_0`: Set the addnode command
- `DIVI_CONNECT_0`: Set the connect command

### File Structure

- `/usr/local/bin/start.sh`: Script to start the Divi daemon and Supervisor
- `/etc/supervisord.conf`: Supervisor configuration file
- `/usr/bin/divi-cli`: Original Divi CLI binary
- `/usr/bin/divid`: Original Divi daemon binary
- `/usr/local/bin/divi-cli`: Wrapper Divi CLI binary
- `/usr/local/bin/divid`: Wrapper Divi daemon binary
- `/etc/divi/divi.conf`: Default configuration file
- `/var/lib/divid`: Default data directory

## Example Usage

For detailed examples of various usage scenarios, please refer to the following files:

1. [EXAMPLE_ADDNODE.md](EXAMPLE_ADDNODE.md): Demonstrates how to run the Divi Docker container with multiple `addnode` commands using environment variables.

2. [EXAMPLE_TESTNET.md](EXAMPLE_TESTNET.md): Shows how to run the Divi Docker container to connect to the Divi testnet.

3. [EXAMPLE_MOUNTED_VOLUMES.md](EXAMPLE_MOUNTED_VOLUMES.md): Illustrates how to run the Divi Docker container with mounted volumes for persistent data storage.

4. [EXAMPLE_SNAPSHOT.md](EXAMPLE_SNAPSHOT.md): Explains how to run the Divi Docker container while downloading the network snapshot for quicker startup.

5. [EXAMPLE_REGTEST.md](EXAMPLE_REGTEST.md): Details how to run the Divi Docker container in regtest mode for local testing.

6. [EXAMPLE_REGTEST_COMPOSE.md](EXAMPLE_REGTEST_COMPOSE.md): Shows how to use Docker Compose to run the Divi Docker container in regtest mode with multiple services.

These example files provide specific use cases and command-line instructions to help you configure the Divi Docker container for various scenarios.
