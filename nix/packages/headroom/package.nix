{
  inputs,
  pkgs,
}: let
  inherit (pkgs) lib;

  workspace = inputs.uv2nix.lib.workspace.loadWorkspace {
    workspaceRoot = ./.;
  };

  overlay = workspace.mkPyprojectOverlay {
    sourcePreference = "wheel";
  };

  python = pkgs.python313;

  pythonSet =
    (pkgs.callPackage inputs.pyproject-nix.build.packages {
      inherit python;
    })
    .overrideScope (lib.composeManyExtensions [
      inputs.pyproject-build-systems.overlays.default
      overlay
      # ビルド依存を宣言していない古い sdist パッケージへの workaround
      (final: prev: {
        antlr4-python3-runtime = prev.antlr4-python3-runtime.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or []) ++ [final.setuptools];
        });
      })
    ]);

  venv = pythonSet.mkVirtualEnv "headroom-env" workspace.deps.default;
in
  pkgs.runCommand "headroom" {
    nativeBuildInputs = [pkgs.makeWrapper];
    passthru = {inherit venv;};
    meta = {
      description = "Headroom: context compression layer for AI agents (uv2nix build)";
      mainProgram = "headroom";
    };
  } ''
    mkdir -p $out/bin
    # headroom が内部で `python3 -m headroom.cli` を spawn しても解決できるよう
    # venv の site-packages を PYTHONPATH に渡す
    makeWrapper ${venv}/bin/headroom $out/bin/headroom \
      --set PYTHONPATH ${venv}/${python.sitePackages}
  ''
