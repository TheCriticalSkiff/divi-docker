# How to Use Testnet Mode with Divi Docker Image

This guide demonstrates how to run the Divi Docker container to connect to the Divi testnet.

## Basic Usage

To run the Divi Docker container with testnet mode, use the following format:

```bash
docker run -d --name divid_container \
    -e "DIVI_TESTNET=true" \
    divi_v2
```

