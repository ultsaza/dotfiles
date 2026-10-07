# nix build --impure --file ./tools/waybar-hyprlua.nix --out-link ~/.local/share/waybar-hyprlua
let
  pkgs = (builtins.getFlake "github:NixOS/nixpkgs/ef34387ddd751e1ab8857adf4676492d32eb24ec").legacyPackages.x86_64-linux;
in pkgs.waybar.overrideAttrs (old: {
  version = "0.15.0";
  src = builtins.fetchGit {
    url = "https://github.com/Alexays/Waybar.git";
    rev = "8ebc788e802b1bf0d96b53e4b3815a9cee8a67c9";
  };
  buildInputs = old.buildInputs ++ [ pkgs.modemmanager ];
  # This desktop uses custom/cava_mviz + the existing external cava process.
  # Upstream's optional integrated libcava >= 1.0 is not in this nixpkgs.
  mesonFlags = old.mesonFlags ++ [ "-Dcava=disabled" ];
})
