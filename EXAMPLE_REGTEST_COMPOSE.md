# How to Use Regtest Mode with Divi Docker Compose

This guide demonstrates how to run the Divi Docker container using REGTEST, with Docker Compose.

## Basic Usage

To run the Divi Docker container with regtest mode in Docker Compose, use the following format:

```bash
docker-compose -f docker-compose-regtest.yml up -d
```

## Example

```bash
me@my_host:~/code/divi-docker$ docker-compose -f docker-compose-regtest.yml up -d
WARN[0000] /home/me/code/divi-docker/docker-compose-regtest.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
[+] Running 4/4
 ✔ Network divi-docker_default           Created                                                                                                                                      0.0s
 ✔ Container divi-docker-divid_node_3-1  Started                                                                                                                                      0.8s
 ✔ Container divi-docker-divid_node_1-1  Started                                                                                                                                      0.6s
 ✔ Container divi-docker-divid_node_2-1  Started                                                                                                                                      0.7s
me@my_host:~/code/divi-docker$ docker exec -it divi-docker-divid_node_1-1 /bin/sh
/ # divi-cli getpeerinfo
[
    {
        "id" : 2,
        "addr" : "172.18.0.4:45444",
        "services" : "0000000000000005",
        "lastsend" : 1731691205,
        "lastrecv" : 1731691205,
        "bytessent" : 337,
        "bytesrecv" : 357,
        "conntime" : 1731691205,
        "pingtime" : 0.09686500,
        "version" : 70915,
        "subver" : "DIVI Core: 3.0.0.0",
        "inbound" : true,
        "startingheight" : 0,
        "banscore" : 0,
        "synced_headers" : -1,
        "synced_blocks" : -1,
        "inflight" : [
        ],
        "whitelisted" : false
    },
    {
        "id" : 3,
        "addr" : "172.18.0.3:37032",
        "services" : "0000000000000005",
        "lastsend" : 1731691205,
        "lastrecv" : 1731691205,
        "bytessent" : 244,
        "bytesrecv" : 357,
        "conntime" : 1731691205,
        "pingtime" : 0.09110300,
        "version" : 70915,
        "subver" : "DIVI Core: 3.0.0.0",
        "inbound" : true,
        "startingheight" : 0,
        "banscore" : 0,
        "synced_headers" : -1,
        "synced_blocks" : -1,
        "inflight" : [
        ],
        "whitelisted" : false
    }
]
/ # divi-cli getinfo
{
    "version" : "3.0.0.0",
    "protocolversion" : 70915,
    "walletversion" : 120200,
    "balance" : 0.00000000,
    "blocks" : 0,
    "timeoffset" : 0,
    "connections" : 2,
    "proxy" : "",
    "difficulty" : 0.00000000,
    "testnet" : false,
    "moneysupply" : 0.00000000,
    "relayfee" : 0.00010000,
    "staking status" : "Staking Not Active",
    "errors" : ""
}
/ # divi-cli setgenerate 10
[
    "75aeacb05250408b28073c802c6294a5843ef6eace6b2504bdbe1347587c266a",
    "6d3fe749fa40d3133888384d8020d986ed44d92cfe1cd820db06a0e9fd0d6a43",
    "77bfa00cf3de349b5b350e81a7c484cd3917165c2f4bf87a84f0865b78f89e89",
    "382663c54159fc9037421b75d909f3b61f960a9dbaf97399939e881f44daa3f4",
    "6f8c8957b99da3b9fc702fad61ac4c7ca85277bb823c4284fc2ba6874187a943",
    "6747f5a6639969503043b648484ca4535c5d3b1a628ff4c75445c544b99518bb",
    "16b0af73f625a31b8738a017f4cf40977c1b145625d0b01518ea21a04f59066d",
    "19bbcd22dc43733f5637e321b21a08cd5d48718baaeb40f220768dc8f666b114",
    "3cb79fbb1813e27d52f20273b7d7d405d643d4930c030fa687b8f92501818826",
    "0d99e89747a890156304cdaaca29350011d489668c5499974696900dafad3282"
]
/ # divi-cli getinfo
{
    "version" : "3.0.0.0",
    "protocolversion" : 70915,
    "walletversion" : 120200,
    "balance" : 0.00000000,
    "blocks" : 10,
    "timeoffset" : 0,
    "connections" : 2,
    "proxy" : "",
    "difficulty" : 0.00000000,
    "testnet" : false,
    "moneysupply" : 12500.00000000,
    "relayfee" : 0.00010000,
    "staking status" : "Staking Not Active",
    "errors" : ""
}
/ # exit
me@my_host:~/code/divi-docker$ docker exec -it divi-docker-divid_node_2-1 /bin/sh
/ # divi-cli getinfo
{
    "version" : "3.0.0.0",
    "protocolversion" : 70915,
    "walletversion" : 120200,
    "balance" : 0.00000000,
    "blocks" : 10,
    "timeoffset" : 0,
    "connections" : 2,
    "proxy" : "",
    "difficulty" : 0.00000000,
    "testnet" : false,
    "moneysupply" : 12500.00000000,
    "relayfee" : 0.00010000,
    "staking status" : "Staking Not Active",
    "errors" : ""
}
/ # exit
me@my_host:~/code/divi-docker$ docker-compose -f docker-compose-regtest.yml down --volumes --remove-orphans
WARN[0000] /home/me/code/divi-docker/docker-compose-regtest.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
[+] Running 4/4
 ✔ Container divi-docker-divid_node_1-1  Removed                                                                                                                                     11.0s
 ✔ Container divi-docker-divid_node_2-1  Removed                                                                                                                                     10.7s
 ✔ Container divi-docker-divid_node_3-1  Removed                                                                                                                                     10.8s
 ✔ Network divi-docker_default           Removed
```
