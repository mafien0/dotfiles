{
  inputs,
  system,
  ...
}: {
  home.packages = [inputs.mfetch.packages.${system}.default];
}
