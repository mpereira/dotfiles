# dotfiles

## Installation
    $ git clone git://github.com/mpereira/dotfiles ~/.dotfiles
    $ cd ~/.dotfiles
    $ rake install \
      [BACKUP=yes|no] \
      [GITHUB_TOKEN='token'] \
      [IRC_FREENODE_PASSWORD='passwd'] \
      [LASTFM_PASSWORD='passwd'] \
      [LIBREFM_PASSWORD='passwd'] \
      [EXTERNAL_DRIVE_PATH='/path/to/external/drive']

If you pass `BACKUP=no` your dotfiles will be overwritten. Anything other than
that will create a `.dotfiles.bak` directory with your dotfiles under your
home directory.
