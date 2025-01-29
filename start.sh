#!/bin/sh
docker image rm -f p2-routeur1:latest p2-routeur2:latest p1-routeur:latest && \
docker build --no-cache -f P1/routeur_anvincen_eedy -t p1-routeur ./P1 && \
docker build --no-cache -f P2/docker_file/routeur_anvincen_eedy_1 -t p2-routeur1 ./P2 && \
docker build --no-cache -f P2/docker_file/routeur_anvincen_eedy_2 -t p2-routeur2 ./P2 && \
docker pull alpine:latest && \
docker images && \
/home/antoine/Documents/bgp/gns3/bin/gns3
