# How to Use Regtest Mode with Divi Docker Image

This guide demonstrates how to run the Divi Docker container using REGTEST.

## Basic Usage

To run the Divi Docker container with regtest mode, use the following format:

```bash
docker run -d --name divid_container \
    -e "DIVI_REGTEST=true" \
    divi_v2
```

## Example - getinfo

```bash
/ # divi-cli getinfo
{
    "version" : "3.0.0.0",
    "protocolversion" : 70915,
    "walletversion" : 120200,
    "balance" : 0.00000000,
    "blocks" : 0,
    "timeoffset" : 0,
    "connections" : 0,
    "proxy" : "",
    "difficulty" : 0.00000000,
    "testnet" : false,
    "moneysupply" : 0.00000000,
    "relayfee" : 0.00010000,
    "staking status" : "Staking Not Active",
    "errors" : ""
}
```

## Example - setgenerate

```bash
/ # divi-cli setgenerate 1000
[
    "5ed6996b1b31aa2b66b5f3bd597bc9d4e2a15b6ce0709641662a4b9b293e73ff",
    "0f1138327c14d5ac38d432fdcf45644288fde575e7fdab6b18abd0e361be02d9",
...
    "21cd9c51ed5d17d86033405287e4dc1b83e1ccc10599faf2aaa97a6088a3fbb3",
    "561f618e62bac2e22867c4c54b752d37a0f0ef02941122682025b3a0fce6105b"
]
```
