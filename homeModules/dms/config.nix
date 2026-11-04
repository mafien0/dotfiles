{
  programs.dank-material-shell.settings = {
    clockFormat = "24h";
    lockScreenWidgetInstances = [
      {
        id = "lock_clock";
        widgetType = "desktopClock";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          style = "expressive";
          transparency = 0;
          weight = 0;
          twoTone = true;
          showDate = false;
          showDigitalSeconds = false;
          showAnalogNumbers = false;
          showAnalogSeconds = true;
          autoPosition = true;
          colorMode = "default";
          customColor = "#ffffff";
        };
      }
      {
        id = "lock_date";
        widgetType = "lockDate";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          format = "short";
          colorMode = "default";
          customColor = "#ffffff";
        };
      }
      {
        id = "lock_auth";
        widgetType = "lockAuth";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          style = "expressive";
          profileVisibility = "always";
          passwordVisibility = "always";
        };
      }
      {
        id = "lock_notifications";
        widgetType = "lockNotifications";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          mode = 2;
        };
      }
      {
        id = "lock_status";
        widgetType = "lockStatus";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          showMediaPlayer = true;
          showWeather = true;
          background = false;
        };
      }
      {
        id = "lock_power";
        widgetType = "lockPower";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          shape = "round";
        };
      }
    ];

    greeterWidgetInstances = [
      {
        id = "lock_clock";
        widgetType = "desktopClock";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          style = "expressive";
          transparency = 0;
          weight = 0;
          twoTone = true;
          showDate = false;
          showDigitalSeconds = false;
          showAnalogNumbers = false;
          showAnalogSeconds = true;
          autoPosition = true;
          colorMode = "default";
          customColor = "#ffffff";
        };
      }
      {
        id = "lock_date";
        widgetType = "lockDate";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          format = "short";
          colorMode = "default";
          customColor = "#ffffff";
        };
      }
      {
        id = "lock_auth";
        widgetType = "lockAuth";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          style = "expressive";
          profileVisibility = "always";
          passwordVisibility = "always";
        };
      }
      {
        id = "lock_status";
        widgetType = "lockStatus";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          showMediaPlayer = true;
          showWeather = true;
          background = false;
        };
      }
      {
        id = "lock_power";
        widgetType = "lockPower";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
          shape = "round";
        };
      }
      {
        id = "greeter_session";
        widgetType = "greeterSession";
        enabled = true;
        config = {
          displayPreferences = ["all"];
          syncPositionAcrossScreens = true;
        };
      }
    ];

    currentThemeName = "custom";
    wallpaperBackgroundColorMode = "black";
    lockScreenShowPowerActions = true;

    dockConfigs = [
      {
        id = "dock";
        name = "Dock";
        enabled = false;
        screenPreferences = ["all"];
        showOnLastDisplay = true;
        position = 1;
        mode = "compact";
        taskbarAlign = "center";
        widgetExpansion = "popout";
        iconSize = 40;
        spacing = 4;
        itemSpacing = 4;
        margin = 0;
        bottomGap = 0;
        transparency = 1;
        followInterfaceStyle = true;
        autoHide = false;
        smartAutoHide = false;
        useOverlayLayer = false;
        editOnRightClick = false;
        showOnFullscreen = false;
        openOnOverview = false;
        groupByApp = false;
        separatePinnedAndRunningApps = false;
        restoreSpecialWorkspaceOnClick = false;
        isolateDisplays = false;
        indicatorStyle = "circle";
        borderEnabled = false;
        borderColor = "surfaceText";
        borderOpacity = 1;
        borderThickness = 1;
        launcherEnabled = false;
        launcherLogoMode = "apps";
        launcherLogoCustomPath = "";
        launcherLogoColorOverride = "";
        launcherLogoSizeOffset = 0;
        launcherLogoBrightness = 0.5;
        launcherLogoContrast = 1;
        maxVisibleApps = 0;
        maxVisibleRunningApps = 0;
        showOverflowBadge = true;
        showTrash = false;
        trashFileManager = "default";
        trashCustomCommand = "";
        magnification = false;
        magnificationScale = 130;
        magnificationProfile = "parabolic";
        magnificationExpand = false;
        order = [];
        widgets = [
          {
            id = "dock_launcher";
            widgetId = "dockLauncher";
            enabled = true;
          }
          {
            id = "dock_apps";
            widgetId = "appsDock";
            enabled = true;
          }
          {
            id = "dock_trash";
            widgetId = "dockTrash";
            enabled = true;
          }
        ];
      }
    ];

    dmsWindowsFloatingSeeded = ["hyprland"];
    widgetBackgroundColor = "default";
    hyprlandWindowOpacity = 100;
    hyprlandTilingLayout = "";
    barElevationEnabled = false;
    launcherStyle = "spotlight";

    barConfigs = [
      {
        id = "default";
        name = "Main Bar";
        enabled = true;
        position = 0;
        screenPreferences = ["all"];
        showOnLastDisplay = true;
        leftWidgets = [
          {
            id = "launcherButton";
            enabled = true;
            launcherLogoMode = "os";
          }
          {
            id = "workspaceSwitcher";
            enabled = true;
            workspaceIndicatorStyle = "pills";
            showWorkspaceIndex = false;
            workspaceIndicatorCompact = true;
            showWorkspacePadding = true;
            workspacePaddingCount = 10;
            workspaceOccupiedColorMode = "primaryContainer";
            workspaceUnfocusedColorMode = "sch";
            workspaceUnfocusedCustomColor = "#49454E";
            workspaceOccupiedCustomColor = "#625B71";
          }
          {
            id = "systemTray";
            enabled = true;
            trayUseInlineExpansion = false;
            trayAutoOverflow = true;
          }
        ];
        centerWidgets = ["music" "clock" "weather"];
        rightWidgets = [
          {
            id = "privacyIndicator";
            enabled = true;
            privacyShowMicIcon = true;
            privacyShowCameraIcon = true;
            privacyShowScreenShareIcon = true;
          }
          {
            id = "keyboard_layout_name";
            enabled = true;
            keyboardLayoutNameCompactMode = true;
          }
          {
            id = "cpuUsage";
            enabled = true;
            minimumWidth = true;
          }
          {
            id = "memUsage";
            enabled = true;
            minimumWidth = true;
            showSwap = false;
            showInGb = false;
          }
          "notificationButton"
          "controlCenterButton"
        ];
        spacing = 0;
        innerPadding = 2;
        bottomGap = 0;
        transparency = 1;
        widgetTransparency = 1;
        squareCorners = true;
        noBackground = false;
        gothCornersEnabled = false;
        gothCornerRadiusOverride = false;
        gothCornerRadiusValue = 12;
        borderEnabled = false;
        borderColor = "surfaceText";
        borderOpacity = 1;
        borderThickness = 1;
        fontScale = 1;
        autoHide = false;
        autoHideDelay = 250;
        openOnOverview = false;
        visible = true;
        popupGapsAuto = true;
        popupGapsManual = 4;
        followInterfaceStyle = true;
        widgetFollowInterfaceStyle = true;
        dot = false;
        islandNotch = false;
        islandFloating = false;
        islandPlacement = "edge";
        islandHighContrast = false;
        islandPalette = "default";
        islandCompactThickness = 38;
        barInsetPadding = -1;
        iconScale = 1;
        islandSatellitePosition = "edges";
        islandSatellitesEnabled = true;
        islandSatelliteBackground = false;
        widgetStyle = "segments";
        widgetPadding = 8;
        widgetOutlineEnabled = false;
        attachToScreenEdge = false;
        shadowIntensity = 0;
        hoverPopouts = false;
      }
    ];

    builtInPluginSettings = {
      dms_qr_generator = {
        trigger = "qrg";
      };
      dms_power = {
        trigger = "pw";
      };
      dms_clipboard_search = {
        trigger = "cb";
      };
      dms_settings_search = {
        trigger = "?";
      };
    };

    configVersion = 42;
  };
}
