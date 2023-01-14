sudo systemctl stop minetest-server.service ; sudo rm -rf /var/lib/minetest/.minetest/games/ld52 ;sudo cp -r /home/lizelive/.minetest/games/ld52/ /var/lib/minetest/.minetest/games/; sudo chown -R minetest:minetest /var/lib/minetest/.minetest/games/ld52; sudo systemctl start minetest-server.service


sudo systemctl stop minetest-server.service
sudo rm -rf /var/lib/minetest/.minetest/worlds/world
sudo systemctl start minetest-server.service




journalctl -fu minetest-server.service


# follow https://nixos.org/manual/nixos/stable/#ch-containers

sudo nixos-container create foo --config 'networking.firewall.allowedUDPPorts = [30000]; services.minetest-server.enable = true;'
sudo nixos-container start foo
nix-shell -p minetest --run "minetest --go --address $(nixos-container show-ip foo) --name human$(date +%s) --password nope"