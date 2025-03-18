# embark-jinx

Simple package to make [`Embark`](https://github.com/oantolin/embark) aware of [`Jinx`](https://github.com/minad/jinx) spellchecker misspellings.


When installed, running `embark-act` (`C-.`) on a misspelled word should bring up the `embark-jinx-map` keymap.

# Install

Recommended install  with [`use-package`](https://github.com/jwiegley/use-package)

```elisp
(use-package embark-jinx
  :after (embark jinx)
  :ensure t
  :vc (:url "https://github.com/ImFstAsFckBoi/embark-jinx"))
```
