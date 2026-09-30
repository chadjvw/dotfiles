# Dots, dots, more dots

Managed with [chezmoi](https://www.chezmoi.io). Primary target is CachyOS (niri + noctalia + ghostty + fish + helix); macOS bits are kept behind `.chezmoiignore`.

## New machine

```shell
sudo pacman -S chezmoi
chezmoi init https://github.com/chadjvw/dotfiles.git
chezmoi diff    # optional
chezmoi apply   # also installs packages via paru (see .chezmoidata/packages.toml)
```

Update later with `chezmoi update`.

## Notes

- Packages live in `.chezmoidata/packages.toml`; editing the list reruns `run_onchange_linux-01-packages.sh.tmpl`.
- Noctalia-generated files (niri `noctalia.kdl`, ghostty theme, starship palette block, GTK/Qt/btop/helix themes) are not tracked. Hand-written configs that reference them are gated on `.theme.noctalia` (set in `chezmoi.toml`, with the fallback themes under `[data.theme.fallback]`); `starship.toml` is a `modify_` template that preserves noctalia's palette block.
