rm -rf /var/lib/minetest/.minetest/games/*
cp -r /home/lizelive/.minetest/games/ld52/ /var/lib/minetest/.minetest/games/
nano /var/lib/minetest/.minetest/minetest.conf
chown -R minetest /var/lib/minetest/.minetest/games/ld52


sudo systemctl stop minetest-server.service

sudo systemctl start minetest-server.service


journalctl -u -f minetest-server.service


# follow https://nixos.org/manual/nixos/stable/#ch-containers

sudo nixos-container create foo --config 'networking.firewall.allowedUDPPorts = [30000]; services.minetest-server.enable = true;'
sudo nixos-container start foo
nix-shell -p minetest --run "minetest --go --address $(nixos-container show-ip foo) --name human$(date +%s) --password nope"