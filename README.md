# Dots, dots, more dots

Managed with [chezmoi](https://www.chezmoi.io)

## Setup dotfiles on a new machine

1. Install chezmoi.

   ```shell
   curl -sfL https://git.io/chezmoi | sh
   ```

2. Initialize chezmoi. Use `https` since we don't have creds yet.

   ```shell
   chezmoi init https://github.com/chadjvw/dotfiles.git
   ```

3. (Optional) Check the diff.

   ```shell
   chezmoi apply -nv
   ```

4. Install the dotfiles.

   ```shell
   chezmoi apply
   ```

Done! To keep up to date in the future:

```shell
chezmoi update
```
