{ config, lib, pkgs, ... }:

{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake ~/.dotfiles#labellson@vostok";
      moshbu = "mosh --ssh=\"ssh -p 2222\" -p 60022 dani@sensity-burner";
      sshbu = "ssh -Y -p 2222 dani@sensity-burner -L 8002:localhost:8002 -L 8001:localhost:8001 -L 8000:localhost:8000 -L 8003:localhost:8003 -L 5432:localhost:5432 -L 8080:localhost:8080 -L 8089:localhost:8089
 -L 4443:localhost:4443 -L 7860:localhost:7860 -L 5432:localhost:5432 -L 8089:localhost:8089 -L 8889:localhost:8888 -L 7999:localhost:7999";
    };
  };
}
