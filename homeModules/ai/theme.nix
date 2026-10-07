# MADE BY CLANKER
{config, ...}: let
  c = name: "#${config.lib.stylix.colors.${name}}";

  theme = {
    name = "stylix";

    colors = {
      accent = c "base0D";
      border = c "base02";
      borderAccent = c "base0D";
      borderMuted = c "base03";
      success = c "base0B";
      error = c "base08";
      warning = c "base0A";
      muted = c "base03";
      dim = c "base02";
      text = c "base05";
      thinkingText = c "base03";

      selectedBg = c "base02";
      userMessageBg = c "base01";
      customMessageBg = c "base01";
      toolPendingBg = c "base01";
      toolSuccessBg = c "base01";
      toolErrorBg = c "base01";
      statusLineBg = c "base01";

      userMessageText = c "base05";
      customMessageText = c "base05";
      customMessageLabel = c "base0D";
      toolTitle = c "base05";
      toolOutput = c "base04";

      mdHeading = c "base0D";
      mdLink = c "base0D";
      mdLinkUrl = c "base03";
      mdCode = c "base06";
      mdCodeBlock = c "base06";
      mdCodeBlockBorder = c "base03";
      mdQuote = c "base04";
      mdQuoteBorder = c "base03";
      mdHr = c "base03";
      mdListBullet = c "base0D";

      toolDiffAdded = c "base0B";
      toolDiffRemoved = c "base08";
      toolDiffContext = c "base03";

      syntaxComment = c "base03";
      syntaxKeyword = c "base0E";
      syntaxFunction = c "base0D";
      syntaxVariable = c "base05";
      syntaxString = c "base0B";
      syntaxNumber = c "base09";
      syntaxType = c "base0A";
      syntaxOperator = c "base0C";
      syntaxPunctuation = c "base04";

      thinkingOff = c "base02";
      thinkingMinimal = c "base03";
      thinkingLow = c "base0D";
      thinkingMedium = c "base0C";
      thinkingHigh = c "base0E";
      thinkingXhigh = c "base08";
      thinkingMax = c "base09";

      bashMode = c "base0C";
      pythonMode = c "base0E";

      statusLineSep = c "base03";
      statusLineModel = c "base0E";
      statusLinePath = c "base0D";
      statusLineGitClean = c "base0B";
      statusLineGitDirty = c "base0A";
      statusLineContext = c "base0C";
      statusLineSpend = c "base0D";
      statusLineStaged = c "base0B";
      statusLineDirty = c "base0A";
      statusLineUntracked = c "base08";
      statusLineOutput = c "base05";
      statusLineCost = c "base09";
      statusLineSubagents = c "base0E";
    };
  };
in {
  home.file.".omp/agent/themes/stylix.json".text = builtins.toJSON theme;
}
