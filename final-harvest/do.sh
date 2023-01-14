#!/bin/bash

docker compose down
docker volume rm -f final-harvest_minetest-data
docker compose up --build

