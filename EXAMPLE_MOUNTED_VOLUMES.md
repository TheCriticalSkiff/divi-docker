# How to mounted volumes with Divi Docker Image

This guide demonstrates how to run the Divi Docker container with mounted volumes.

## Basic Usage

To run the Divi Docker container with mounted volumes, use the following format:

```bash
docker run -d --name divid_container \
    -v /path/to/divi:/var/lib/divid \
    divi_v2
```

## Extended Usage

You can also mount multiple volumes by using the same format:

```bash
docker run -d --name divid_container \
    -v /path/to/divi:/var/lib/divid \
    -v /path/to/config:/etc/divi \
    divi_v2
```