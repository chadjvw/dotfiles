# Dots, dots, more dots

Managed with [chezmoi](https://www.chezmoi.io). Primary target is CachyOS (niri + noctalia + ghostty + fish + helix); macOS bits are kept behind `.chezmoiignore`.

## New machine

```shell
sudo pacman -S chezmoi
chezmoi init https://github.com/chadjvw/dotfiles.git
chezmoi diff    # optional
chezmoi apply   # also installs packages (see .chezmoidata/packages.toml)
```

Update later with `chezmoi update`.

## Notes

- CLI tools live in one list, `.chezmoidata/packages.toml` (`[cli]`); GUI/fonts/apps are per-platform (`[gui]`). `run_onchange_before_10-packages.sh.tmpl` installs each tool missing from PATH with the native package manager (brew, paru, dnf), else with mise (binary first, then `cargo`), and reruns when the list changes. Tools installed through mise land in `~/.config/mise/conf.d/local.toml`, regenerated each run and not managed by chezmoi. `DRY_RUN=1` on the rendered script prints the native/mise split.
- Noctalia-generated files (niri `noctalia.kdl`, ghostty theme, starship palette block, GTK/Qt/btop/helix themes) are not tracked. Hand-written configs that reference them are gated on `.theme.noctalia` (set in `chezmoi.toml`, with the fallback themes under `[data.theme.fallback]`); `starship.toml` is a `modify_` template that preserves noctalia's palette block.
