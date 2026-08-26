{
  inputs,
  system,
  ...
}: {
  home.packages = [
    inputs.flint.packages.${system}.default
  ];
}
