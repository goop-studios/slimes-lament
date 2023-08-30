with import <nixpkgs> {};

let
  pkgs = import <nixpkgs> {};
in
mkShell rec {
  allowUnfree = true;
  name = "game";
  nativeBuildInputs = with pkgs; [
    pkg-config
  ];
  buildInputs = with pkgs; [
    udev alsa-lib vulkan-loader
    xorg.libX11 xorg.libXcursor xorg.libXi xorg.libXrandr # To use the x11 feature
    libxkbcommon wayland # To use the wayland feature
  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
  packages = with pkgs; [
    zsh
  ];
  shellHook = ''
    echo "Welcome to h4rl's nix-shell :)"
  '';
  # Additional configuration (if needed)
  RUST_BACKTRACE = 1;
}