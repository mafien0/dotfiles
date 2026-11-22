require("kotlin").setup({
  root_markers = { "settings.gradle.kts", "gradlew", "build.gradle", "build.gradle.kts", "pom.xml", "mvnw", ".git" },
  jvm_args = { "-Xmx4g" },
  inlay_hints = { enabled = true },
  folding = { enabled = true },
  code_lens = { enabled = true, align = true },
  java_files = true,
  file_templates = { enabled = true },
})