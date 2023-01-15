{ nixpkgs }: 
  with pkgs;
  fetchFromGitHub {
    owner = "minetest-mods";
    repo = "i3";
    rev = "38f1d7c96003466b18c2d66b06b7f68904f61868";
    hash = "sha256-PsjJzAzihSEZ2Qh+IZWGxUGedI9aOAE8Ymzxj3BIe5Y=";
  }
