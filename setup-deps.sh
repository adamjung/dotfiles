#!/usr/bin/env bash
set -e

# set -o verbose
echo "##### $(basename $BASH_SOURCE) #####"

DOTFILES_ROOT="`pwd`"

########################################
# helpers
########################################
brew_install() {
    formula="$1"
    set +e
    already_installed="no"
    test -z "$(brew ls --versions $formula)" || already_installed="yes"
    set -e
    echo "$formula already installed with brew: $already_installed"
    [ $already_installed = "yes" ] || brew install $formula
}

npm_install() {
    formula="$1"
    set +e
    already_installed="no"
    npm list -g | grep -q "$formula@" && already_installed="yes"
    set -e
    echo "$formula already installed with npm: $already_installed"
    [ $already_installed = "yes" ] || npm install -g $formula
}

install_git_repo() {
    repo="$1"
    target_dir="$2"

    if ! test -d $target_dir; then
        echo "installing $repo"
        # legacy location, lots of deps remaining on this:
        git clone "$repo" "$target_dir"
        cd $target_dir
        git submodule update --init --recursive
        cd -
    fi

}

########################################
# libs
########################################
# xcode-select --install # must be install via app store now

brew_install cmake
brew_install git

brew_install python
brew_install tmux
brew_install languagetool
brew_install rbenv
brew_install vim
brew_install node
brew_install nvm


########################################
# misc
########################################
SRC_DIR="$HOME/src"
test -e $SRC_DIR || mkdir -p $SRC_DIR

########################################
# various symlinks
########################################
# test -L "/Applications/Screen Sharing.app" || ln -s "/System/Library/CoreServices/Screen Sharing.app" "/Applications/Screen Sharing.app"

########################################
# node modules
########################################
brew_install node

npm_install eslint
npm_install prettier

########################################
# ruby gems
########################################
test -e ~/.gemrc && grep -q "no-document" ~/.gemrc || echo "gem: --no-document" >> ~/.gemrc
# latest stable MRI that ruby-build knows about
RUBY_VERSION="$(rbenv install -l 2>/dev/null | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | tail -1)"
rbenv versions --bare | grep -qx "$RUBY_VERSION" || rbenv install "$RUBY_VERSION"
rbenv global "$RUBY_VERSION"
# put rbenv's shims on PATH so `gem` below isn't the system ruby
eval "$(rbenv init - bash)"

gem install rubocop

########################################
# vim
########################################
vim +PlugInstall +qall
