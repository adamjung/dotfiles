### Installation

    cd ~
    cd ~/code
    git clone https://github.com/adamjung/dotfiles.git
    cd dotfiles
    ./setup.sh

You should see the following output on sucessful install:
    
    ✅ ✅ ✅
    🎉 🎉 🎉

`setup.sh` will run all of the following setup scripts: 

* `setup-homebrew.sh` - install and update homebrew.
* `setup-deps.sh` - install all dependencies, such as `docker` and other libs and packages.
* `setup-symlinks.sh` - create symlinks from your home directory to any files that begin with a `.` in your `~/dotfiles` directory.
* `setup-osx.sh` - configure some osx preferences.

Each of this scripts can also be run independently (which may be faster for making small changes).

### Other

* Install the Xcode command line tools (`xcode-select --install`) before running `./setup.sh`

### Themes

    # install terminal theme
    open "themes/tomorrow-theme/OS X Terminal/Tomorrow Night.terminal"

