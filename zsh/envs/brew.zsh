if [[ -a ~/.homebrew/bin/brew ]]; then
  function {
    local brew_prefix="$HOME/.homebrew"
    path=($brew_prefix/bin $path)
    path=($(brew --prefix coreutils)/libexec/gnubin $brew_prefix/sbin $path)
    manpath=($brew_prefix/share/man $manpath)

    # Homebrew Python setup
    path=($(python -c "from sys import prefix; print prefix")/bin $path)
    path=($brew_prefix/share/python $path)
  }
fi