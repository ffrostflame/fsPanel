---
sidebar_position: 2
---

# Installation

## With Wally

1. Install [Wally](https://wally.run)
2. Put fsPanel in the ``wally.toml`` file under ``[dependencies]``
```toml title="wally.toml"
[dependencies]
BridgeNet2 = ffrostflame/fspanel@0.1.0
```
3. Run ``wally install``

## Without Wally

## Option 1: Syncing with .rbxm:
1. Get the ``.rbxm`` file from the latest [release](https://github.com/ffrostflame/fsPanel/releases).
2. Sync manually or drop into studio manually

## Option 2: copying source folder:
1. Copy the `src` folder of the repository
2. Drop into your project
3. Rename the folder to `fsPanel`
