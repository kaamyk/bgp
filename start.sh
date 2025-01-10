#!/bin/sh

docker system prune -af && \
docker build -f P1/routeur_anvincen_eedy -t p1-routeur ./P1 && \
docker pull alpine:latest && \
docker images && \
/home/antoine/Documents/bgp/bgp_env/bin/gns3