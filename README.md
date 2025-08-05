# linux-aliases
My linux aliases

## Setup

### Zshrc

```zsh
cp ./.aliases ~ && grep -Fxq '# Personal aliases' ~/.zshrc || printf '\n# Personal aliases\nif [ -f ~/.aliases ]; then\n    . ~/.aliases\nfi\n' >> ~/.zshrc
```

### Bash

```bash
cp ./.aliases ~ && grep -Fxq '# Personal aliases' ~/.bashrc || printf '\n# Personal aliases\nif [ -f ~/.aliases ]; then\n    . ~/.aliases\nfi\n' >> ~/.bashrc
```
