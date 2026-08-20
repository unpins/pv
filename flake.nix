{
  description = "pv (pipe viewer) as a single self-contained binary";

  nixConfig = {
    extra-substituters = [ "https://unpins.cachix.org" ];
    extra-trusted-public-keys = [ "unpins.cachix.org-1:DDaShjbZ8VvcqxeTcAU3kV9vxZQBlyb7V/uLBHfTynI=" ];
  };

  inputs.unpins-lib.url = "github:unpins/nix-lib";

  # pv (pipe viewer) — show progress of data through a pipe. Single binary,
  # no aliases. Native from pkgsStatic.pv. Windows TBD: pv is heavily POSIX
  # (terminal ioctls, SIGWINCH, splice), so it likely needs cosmo if at all;
  # start with Linux + macOS and assess Windows separately.
  outputs = { self, unpins-lib }:
    let lib = unpins-lib.lib;
    in
    lib.mkStandaloneFlake {
      inherit self;
      name = "pv";

      # Build via the unpin-llvm engine + emit a bitcode multicall module.
      engine = "unpin-llvm";
      multicall = {
        programs = [{ name = "pv"; }];
        # pv is NLS-enabled, so it bakes its own $out/share/locale as the
        # gettext domain directory. The standalone ships bin/ only, so that
        # path is dead -- but Nix counted it as a runtime reference and dragged
        # the base build, and through its compiler wrapper the toolchain,
        # behind a self-contained binary. Scrubbing changes nothing at run time
        # (gettext already fell through to the untranslated strings); it does
        # not disable NLS, which stays compiled in for a future embedded catalog.
        removeReferences = [ "pv-static" "pv-x86_64-unknown-cosmo" ];
      };
      # `pv --version` → "pv 1.10.5\nCopyright … Andrew Wood\n…". Match the stable
      # author line rather than the version number (survives nixpkgs pv bumps).
      smoke = [ "--version" ];
      smokePattern = "Andrew Wood";
      # Windows via cosmocc (POSIX layer: termios, SIGWINCH, poll). ELF→pv.exe
      # via the cosmo apelink hook. doCheck=false: the cosmo cross keeps tests on
      # (APEs run on the build host) but we don't run them here.
      windowsBuild = pkgs:
        (lib.cosmoStaticCross pkgs).pv.overrideAttrs (_: { doCheck = false; });
    };
}
