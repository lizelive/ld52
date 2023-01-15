{
  description = "A very basic flake";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.11";
  # inputs.c_mobs_redo = "https://notabug.org/tenplus1/mobs_redo.git";
  # inputs.c_mobs_redo.flake = false;
  # inputs.c_hudbars = "https://codeberg.org/Wuzzy/minetest_hudbars.git";
  # inputs.c_hudbars.flake = false;
  # inputs.c_player_monoids = "https://github.com/minetest-mods/player_monoids.git";
  # inputs.c_player_monoids.flake = false;
  # inputs.c_hbhunger = "https://codeberg.org/Wuzzy/minetest_hbhunger.git";
  # inputs.c_hbhunger.flake = false;
  # inputs.c_i3 = "https://github.com/minetest-mods/i3.git";
  # inputs.c_i3.flake = false;
  # inputs.c_hbsprint = "https://github.com/minetest-mods/hbsprint.git";
  # inputs.c_hbsprint.flake = false;
  # inputs.c_3d_armor = "https://github.com/minetest-mods/3d_armor.git";
  # inputs.c_3d_armor.flake = false;
  # inputs.c_newplayer = "https://cheapiesystems.com/git/newplayer";
  # inputs.c_newplayer.flake = false;
  # inputs.c_textures = "https://github.com/MysticTempest/REFI_Textures.git";
  # inputs.c_textures.flake = false;
  # inputs.c_splooshy_bombs = "https://codeberg.org/ekl/splooshy_bombs.git";
  # inputs.c_splooshy_bombs.flake = false;
  # inputs.c_splooshy_bombs_api = "https://codeberg.org/ekl/splooshy_bombs_api.git";
  # inputs.c_splooshy_bombs_api.flake = false;
  # inputs.c_playereffects = "https://repo.or.cz/minetest_playereffects.git";
  # inputs.c_playereffects.flake = false;
  # inputs.c_creatura = "https://github.com/ElCeejo/creatura.git";
  # inputs.c_creatura.flake = false;
  # inputs.c_hudbars = "https://codeberg.org/Wuzzy/minetest_hudbars.git";
  # inputs.c_hudbars.flake = false;
  outputs = { self, nixpkgs }: 
  with nixpkgs.legacyPackages.x86_64-linux;
  let 
  c_i3 = callPackage ./i3 { };
  newDrv = stdenv.mkDerivation {
    name = "minetestserver";
    src = ./.; 
    buildInputs = [ minetestserver ];
    phases = [ "buildPhase" ];
    buildPhase = ''
      mkdir -p $out/bin
      ln -s ${minetestserver}/bin/minetestserver $out/bin/minetestserver
      cp -r ${minetestserver}/share/ $out/share/
      chmod +w $out/share/minetest/games/
      cp -r $src/ $out/share/minetest/games/ld52/
      ln -s ${c_i3}/ $out/share/minetest/games/ld52/mods/i3
    '';
  };
  in
  {
    packages.x86_64-linux.default = newDrv;

  };
}
