FROM ubuntu:22.04

# ARGs used during docker-compose build, from .env
ARG POTOS_FULL_DISK_ENCRYPTION_INITIAL_PASSWORD
ARG POTOS_INITIAL_HOSTNAME

# ENVs used inside of the container at start docker-compose up, from potos_env file
ENV POTOS_SPECS_REPOSITORY=$POTOS_SPECS_REPOSITORY
ENV POTOS_ADJOIN=$POTOS_ADJOIN
ENV POTOS_ENV=$POTOS_ENV

WORKDIR /potos-iso

# Install ISO creation depencies
RUN apt update && apt install -y gfxboot p7zip-full xorriso wget curl libhtml-parser-perl cpio

COPY potos-iso .

# Copy all the ARGs and ENVs, to make them available the Potos ISO at boot.
COPY potos_env contrib/scripts/potos_env
COPY .env contrib/scripts/.env

# Overwrite LUKS Install Key according .env
RUN sed -i "s/key: .*/key: $POTOS_FULL_DISK_ENCRYPTION_INITIAL_PASSWORD/g" "autoinstall/desktop-bios/user-data"
RUN sed -i "s/key: .*/key: $POTOS_FULL_DISK_ENCRYPTION_INITIAL_PASSWORD/g" "autoinstall/desktop-uefi/user-data"

# Overwrite Initial Hostname, according .env
RUN sed -i "s/hostname: .*/hostname: $POTOS_INITIAL_HOSTNAME/g" "autoinstall/desktop-bios/user-data"
RUN sed -i "s/hostname: .*/hostname: $POTOS_INITIAL_HOSTNAME/g" "autoinstall/desktop-uefi/user-data"

CMD ["./create-iso", "-p"]
