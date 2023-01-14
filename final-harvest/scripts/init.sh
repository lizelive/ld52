#!/bin/bash
echo "setting up minetest"

minetest="/config/.minetest/"
world="${minetest}worlds/world/"

mkdir -p /config/.minetest/main-config/
mkdir -p $world

# minetest_conf="${minetest}main-config/minetest.conf"
minetest_conf="/config/.minetest/main-config/minetest.conf"
rm $minetest_conf
echo "server_name = ${SERVER_NAME}" >> $minetest_conf
echo "server_description = ${SERVER_DESCRIPTION}" >> $minetest_conf
echo "server_address = ${SERVER_ADDRESS}" >> $minetest_conf
echo "server_url = ${SERVER_URL}" >> $minetest_conf
echo "server_announce = ${SERVER_ANNOUNCE}" >> $minetest_conf
echo "motd = ${MOTD}" >> $minetest_conf
echo "max_users = ${MAX_USERS}" >> $minetest_conf
cat $minetest_conf

world_mt="${world}world.mt"
echo "gameid = ${GAME_ID}" >> $world_mt
echo "backend = postgresql" >> $world_mt
echo "pgsql_connection = host=postgres port=5432 user=${POSTGRES_USER} password=${POSTGRES_PASSWORD} dbname=${POSTGRES_DB}" >> $world_mt

chown -R abc:abc $world

echo "setup minetest"
# To improve PostgreSQL's performance with Minetest servers, please configure postgresql.conf with a minimum shared_buffer of 512MB, with a maximum of 50% of your server's available RAM. 

