{
  lib,
  pkgs,
  isDarwin,
  ...
}:

{
  # Cross-platform container client tooling. The engine is platform specific:
  # on Darwin it comes from OrbStack (modules/darwin/orbstack.nix); on Linux we
  # run rootless Podman.
  home.packages =
    with pkgs;
    [
      lazydocker # container TUI
      dive # inspect image layers
    ]
    # `podman` itself is added by `services.podman` below; only the extras here.
    ++ lib.optionals (!isDarwin) [
      podman-compose
    ];

  services.podman = lib.mkIf (!isDarwin) {
    enable = true;
    settings.registries.search = [
      "docker.io"
      "ghcr.io"
    ];
  };

  home.shellAliases = lib.mkIf (!isDarwin) {
    docker = "podman";
    docker-compose = "podman-compose";
  };

  # For tools that need the Docker REST API (testcontainers, the docker CLI's
  # remote mode, etc.), point them at Podman's rootless socket. The socket is
  # socket-activated, so enable it once per machine:
  #   systemctl --user enable --now podman.socket
  home.sessionVariables = lib.mkIf (!isDarwin) {
    DOCKER_HOST = "unix://\${XDG_RUNTIME_DIR}/podman/podman.sock";
  };
}
