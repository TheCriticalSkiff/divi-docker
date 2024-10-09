# How to Use Multiple Addnode Commands with Divi Docker Image

This guide demonstrates how to run the Divi Docker container with multiple `addnode` commands using environment variables.

## Basic Usage

To run the Divi Docker container with multiple `addnode` commands, use the following format:

```bash
docker run -d --name divid_container \
    -e "DIVI_ADDNODE_1=node1.example.com" \
    -e "DIVI_ADDNODE_2=node2.example.com" \
    -e "DIVI_ADDNODE_3=node3.example.com" \
    divi_v2
```

