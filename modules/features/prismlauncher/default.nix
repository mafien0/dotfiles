{moduleWithSystem, ...}: let
	glfwPatches = [
		./glfw/0001-Key-Modifiers-Fix.patch
		./glfw/0002-Fix-Window-size-on-unset-fullscreen.patch
		./glfw/0003-Avoid-error-on-startup.patch
		./glfw/0004-Dismiss-warnings-about-window-position-being-unavail.patch
		./glfw/0005-Fix-test-native-target.patch
		./glfw/0006-Implement-glfwSetCursorPosWayland-via-pointer-constr.patch
		./glfw/0007-GLFW_PLATFORM-env-var.patch
		./glfw/0008-glfwPlatformSupported-X11-DISPLAY.patch
		./glfw/0009-Fix-xdg-decoration-visible.patch
	];
in {
	flake.nixosModules.prismlauncher =
		moduleWithSystem (
			{config, ...}: _: {
				environment.systemPackages = [config.packages.myPrismlauncher];
			}
		);

	perSystem = {pkgs, ...}: let
		lwjglGlfw = final: prev: {
			glfw3-minecraft =
				prev.glfw3.overrideAttrs (old: {
						pname = "glfw-minecraft";
						version = "3.5-unstable-2026-04-02";
						src =
							prev.fetchFromGitHub {
								owner = "LWJGL-CI";
								repo = "GLFW";
								rev = "0e6ee09b1c777968eb5a1da924794c6f4602fdc8";
								hash = "sha256-/H0Rscp4zTXn5k3A+134fzVzBdtfZ6q/3DJytuRshLc=";
							};
						patches = (old.patches or []) ++ glfwPatches;
						postPatch =
							(old.postPatch or "")
							+ ''
								H=src/wl_platform.h

								sed -i '/^+$/d' "$H"
								sed -i '/^#define wp_pointer_warp_v1_interface/d' "$H"
								sed -i '/struct wp_pointer_warp_v1\*  pointerWarp;/d' "$H"
								grep -q 'askedCursorPosX' "$H" || \
								  sed -i '/^    } fallback;/a\    double                      askedCursorPosX, askedCursorPosY;\n    GLFWbool                    didAskForSetCursorPos;' "$H"

								# Fix: when EGL context clear fails (e.g. NVIDIA Wayland), still
								# clear the TLS so subsequent makeContextCurrent(window) works.
								sed -i '/EGL: Failed to clear current context/,/^        }$/{
								/^            return;$/d
								}' src/egl_context.c
							'';
					});
		};
		myPkgs = pkgs.extend lwjglGlfw;
	in {
		packages.myPrismlauncher =
			(myPkgs.prismlauncher.override {
					jdks = with myPkgs; [
						temurin-bin-25
						temurin-bin-21
						temurin-bin-17
						temurin-bin-11
						temurin-bin-8
					];
				}).overrideAttrs
			(
				old: let
					glfwLib = "${myPkgs.glfw3-minecraft}/lib/libglfw.so";
				in {
					qtWrapperArgs =
						old.qtWrapperArgs
						++ [
							"--set JDK_JAVA_OPTIONS -Dorg.lwjgl.glfw.libname=${glfwLib}"
							"--set JAVA_TOOL_OPTIONS -Dorg.lwjgl.glfw.libname=${glfwLib}"
							"--set XDG_SESSION_TYPE wayland"
							"--set GLFW_PLATFORM wayland"
							"--set __GL_THREADED_OPTIMIZATIONS 0"
						];
				}
			);
	};
}
