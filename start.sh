#!/bin/sh
docker system prune -af
docker build --no-cache -f P1/routeur_anvincen_eedy -t p1-routeur ./P1 && \
docker build --no-cache -f P2/docker_file/routeur_anvincen_eedy_1 -t p2-routeur1 ./P2 && \
docker build --no-cache -f P2/docker_file/routeur_anvincen_eedy_2 -t p2-routeur2 ./P2 && \
docker build --no-cache -f P3/docker_file/r1 -t p3-routeur1 ./P3 && \
docker build --no-cache -f P3/docker_file/r2 -t p3-routeur2 ./P3 && \
docker build --no-cache -f P3/docker_file/r3 -t p3-routeur3 ./P3 && \
docker build --no-cache -f P3/docker_file/r4 -t p3-routeur4 ./P3 && \
docker pull alpine:latest && \
docker images && \
/home/antoine/Documents/bgp/gns3/bin/gns3
