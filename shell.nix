with import <nixpkgs> {};

let
  pkgs = import <nixpkgs> {};
in
mkShell {
  allowUnfree = true;
  name = "game";
  nativeBuildInputs = with pkgs; [
    rustup pkgconfig lld_16
  ];
  buildInputs = with pkgs; [
    alsa-lib libudev-zero
  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath [ alsa-lib ];
  packages = with pkgs; [
    zsh
    trunk-io
  ];
  shellHook = ''
    echo "Welcome to h4rl's nix-shell :)"
  '';
  # Additional configuration (if needed)
  RUST_BACKTRACE = 1;
}