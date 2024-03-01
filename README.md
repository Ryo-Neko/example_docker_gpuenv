# Usage of the docker environment with Cuda
For server users in our Lab.

Last update: 1st Mar. 2024.

## Preparation
1. Create work directory at "."
2. Search your UID using `id -u` command.
3. In the `docker-compose.yml`, Change USERNAME, USERID(=UID), GROUPNAME, and GROUPID following your name and your ID.
```yaml
      args:
        USERNAME: "test"
        USERID: "1000"
        GROUPNAME: "test" # it's ok [same as USERNAME]
        GROUPID: "1000" # it's ok [same as USERID]
```
4. In the `docker-compose.uml`, change "user".
```yaml
        user: 1000:1000 # UID
```
5. Search YOUR GPU's UUID using `nvidia-smi -L` command.
```shell
→ nvidia-smi -L
GPU 0: NVIDIA A100 80GB PCIe (UUID: GPU-aaaaaaaaaaaaa)
  MIG 3g.40gb     Device  0: (UUID: MIG-bbbbbbbbbbbbb)
  MIG 1g.20gb     Device  1: (UUID: MIG-ccccccccccccc)
  MIG 1g.10gb     Device  2: (UUID: MIG-ddddddddddddd)
```
6. In the `docker-compose.yml`, fill NVIDIA_VISIBLE_DEVICES.
```yaml
      - NVIDIA_VISIBLE_DEVICES={FILL YOUR UUID}
```
7. build and up using docker compose
```shell
docker compose build # build the image.
docker compose up -d # start the container.
docker compose attach dlenv # attach the container (/bin/bash)
```