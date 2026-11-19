# Tighten Codex Brew Rules

Sam found the shared Codex rules allowing more Homebrew than the xpkg bootstrap needs. `brew install --HEAD` and `brew reinstall` were allowed for any formula, which let Codex build and install arbitrary software outside its sandbox without a prompt.

Those two rules and the `xpkg-git`-specific `brew info` and `brew postinstall` rules are gone. A plain `brew info` replaces them, since it only reads. Installing or reinstalling `xpkg-git` from Codex now asks for approval, which is the point at which a prompt belongs. `brew xpkg activate` and the Mint install rules are unchanged.
