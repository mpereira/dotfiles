# dotfiles

[mpereira](https://github.com/mpereira)'s configuration files.

## Installation
    $ git clone git://github.com/mpereira/dotfiles ~/.dotfiles
    $ cd ~/.dotfiles
    $ rake install \
      [BACKUP=yes|no] \
      [IRC_FREENODE_USERNAME='username'] \
      [IRC_FREENODE_PASSWORD='password'] \
      [IRC_SONIAN_USERNAME='username'] \
      [IRC_NOTIFIER_CHANNEL_REGEX='(channel1|channel2)'] \
      [IRC_IRSSINOTIFIER_API_TOKEN='token'] \
      [IRC_SONIAN_PASSWORD='password'] \
      [LASTFM_PASSWORD='password'] \
      [LIBREFM_PASSWORD='password']

If you pass `BACKUP=no` your dotfiles will be overwritten. Anything other than
that will create a `.dotfiles.bak` directory with your dotfiles under your
home directory.

## Author
  [Murilo Pereira](http://murilopereira.com)

## License
  [MIT](http://opensource.org/licenses/MIT)
