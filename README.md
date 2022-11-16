# Potos .iso building

To create your own Linux Client based on Potos, please follow this steps:

1. Clone this repository with `git clone` or download & unzip it.
2. Edit the environment variables in `.env` to fit your needs. To run the Continuous Configuration of your Potos based Linux Client on your own, don't forget to change the value of `POTOS_SPECS_REPOSITORY` towards your own git repository, otherwise your Linux Client is going to connect to the Potos Default Repository [ansible-specs-potos](https://github.com/projectpotos/ansible-specs-potos).
3. Build the installation .iso as described below.

## Create your Potos .iso

Make sure you have [Docker](https://docs.docker.com/get-docker) and [Docker-Compose](https://docs.docker.com/compose/install/) installed.

```
docker-compose build
docker-compose up # The container does stop after building the .iso image in /potos-images automatically.
```

Note: The time to generate the .iso image mainly depends on your internet bandwith, since an Ubuntu 22.04 image is downloaded and modified.

# Potos .iso installation

Boot from the previously generated Potos .iso image in your virtual or physical hardware and follow the instruction.

# PXE and iPXE Boot

Not implemented yet.
