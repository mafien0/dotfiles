_: {
  settings = {
    debug = {
      disable-cursor-plane = _: {};
      honor-xdg-activation-with-invalid-serial = _: {};
    };

    screenshot-path = "~/Pictures/Screenshots/sc-%Y-%m-%d_%H-%M-%S.png";

    workspaces = {
      main = _: {};
      browser = _: {};
      messenger = _: {};
      misc = _: {};
    };
  };

  windowRules = [
    {
      background-effect = {
        blur = true;
        xray = false;
      };
    }
  ];

  layerRules = [
    {
      matches = [
        {namespace = "^noctalia-(background|launcher-overlay|dock)-.*$";}
      ];
      background-effect = {
        xray = false;
      };
    }
  ];
}
