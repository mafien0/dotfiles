{pkgs, ...}: let
  flakePath = "/home/mafien0/nix";
in {
  programs.nh = {
    enable = true;
    flake = flakePath;
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };

  home.packages = [
    # Really silly wrapper around nh[https://github.com/nix-community/nh] (you should check it out)
    # Made because im lazy to type 3 commands on update
    (pkgs.writers.writePython3Bin "build" {}
      /*
      python
      */
      ''
        from argparse import ArgumentParser
        import subprocess
        import os
        import sys

        RESET = "\033[0m"
        RED = "\033[31m"
        GREEN = "\033[32m"
        CYAN = "\033[36m"

        parser = ArgumentParser(add_help=False, description="Simple Nixos build script")
        parser.add_argument("-b", "--boot", action="store_true")

        parser.add_argument("-f", "--flake", action="store_true")
        parser.add_argument("-h", "--home", action="store_true")
        parser.add_argument("-o", "--os", action="store_true")

        args = parser.parse_args()


        def run(args: list[str], name: str):
            print(f"Running {name}")
            print("-" * 50)

            try:
                result = subprocess.run(args, text=True)
            except KeyboardInterrupt:
                print("\ninterrupted by the user")
                sys.exit(1)

            if result.returncode != 0:
                raise RuntimeError(f"{name} failed!")
            print(f"{CYAN}--- {name} finished ---{RESET}\n")


        if __name__ == "__main__":
            if len(sys.argv) == 1:
                print(f"{RED}No arguments were provided.{RESET}")
                sys.exit(1)

            user_flake = ${flakePath}

            if args.os:
                print(f"{RED}Building os requires sudo{RESET}")
                subprocess.run(["sudo", "-v"], check=True)

            operation = "switch"
            if args.boot:
                operation = "boot"

            if args.flake:
                run(["${pkgs.nix}", "flake", "update", "--flake", user_flake], "flake inputs update")

            if args.os:
                run(["${pkgs.nh}", "os", operation, user_flake], "os rebuild")

            if args.home:
                run([${pkgs.nh}, "home", operation, user_flake], "home rebuild")

            print(f"{GREEN}Succesfully built!{RESET}")
      '')
  ];
}
