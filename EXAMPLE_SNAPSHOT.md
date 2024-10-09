# How to Use Snapshot Mode with Divi Docker Image

This guide demonstrates how to run the Divi Docker container while downloading the network snapshot to make startup quicker.

## Basic Usage

To run the Divi Docker container with snapshot mode, use the following format:

```bash
docker run -d --name divid_container \
    -e "DIVI_SNAPSHOT=true" \
    divi_v2
```

