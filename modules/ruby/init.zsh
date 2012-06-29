#
# Configures Ruby local gem installation, loads version managers, and defines
# aliases.
#
# Authors: Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load RVM into the shell session.
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  # Unset AUTO_NAME_DIRS since auto adding variable-stored paths to ~ list
  # conflicts with RVM.
  unsetopt AUTO_NAME_DIRS

  # Source RVM.
  source "$HOME/.rvm/scripts/rvm"

# Load manually installed rbenv into the shell session.
elif [[ -s "$HOME/.rbenv/bin/rbenv" ]]; then
  path=("$HOME/.rbenv/bin" $path)
  eval "$(rbenv init - zsh)"

# Load package manager installed rbenv into the shell session.
elif (( $+commands[rbenv] )); then
  eval "$(rbenv init - zsh)"

# Install local gems according to operating system conventions.
else
  if [[ "$OSTYPE" == darwin* ]]; then
    export GEM_HOME="$HOME/Library/Ruby/Gems/1.8"
    path=("$GEM_HOME/bin" $path)
  fi
fi

# Aliases

# Bundler
alias b='bundle'
alias be='b exec'
alias bi='b install --path vendor/bundle'
alias bl='b list'
alias bo='b open'
alias bp='b package'
alias bu='b update'
alias bI='bi \
  && b package \
  && print .bundle       >>! .gitignore \
  && print vendor/bundle >>! .gitignore \
  && print vendor/cache  >>! .gitignore'

# Rail performance
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

