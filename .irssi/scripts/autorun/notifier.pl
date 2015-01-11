# == WHAT
# Simple script for irssi to trigger Mac OS X 10.8's Notification Center
#
# == WHO
# Patrick Kontschak 2012, Murilo Pereira 2015
#
# Forked from Nate Murray's irssi-growl: https://github.com/jashmenn/irssi-growl
#
# == CONFIG
#   /SET notifier_on_regex [regex]
#   /SET notifier_channel_regex [regex]
#
# == EXAMPLES
#
#   notifier on mynickname
#   /SET notifier_on_regex mynickname
#
#   notifier on everything:
#   /SET notifier_on_regex .*
#
#   everything but jdewey
#   /SET notifier_on_regex (?=^(?:(?!jdewey).)*$).*
#
#   only notifier things for mychannel1 and mychannel2
#   /SET notifier_channel_regex (mychannel1|mychannel2)
#
# == INSTALL
# Place notifier.pl in `~/.irssi/scripts/`.
# /script load notifier.pl

use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = '0.1';
%IRSSI = (
  authors     => 'Patrick Kontschak, Murilo Pereira',
  contact     => 'patrick.kontschak\@gmail.com, murilo\@murilopereira.com',
  name        => 'Notifier',
  description => 'Simple script that will trigger Mac OS X 10.8\'s Notification Center',
  license     => 'GPL',
  url         => 'http://www.codinggoat.com',
  changed     => 'Sun  11 Jan 2015 00:00:00 EDT'
);

sub notify {
  my ($server, $title, $subtitle, $message) = @_;
  $message =~ s/["';]//g;

  my $app_icon = Irssi::settings_get_str('notifier_app_icon');
  my $sound    = Irssi::settings_get_str('notifier_sound');

  my $command = "terminal-notifier -message '$message' -title '$title'";
  $command = $command . " -subtitle '$subtitle'" if $subtitle;
  $command = $command . " -appIcon  '$app_icon'" if $app_icon;
  $command = $command . " -sound    '$sound'"    if $sound   ;
  $command = $command . " >> /dev/null 2>&1";
  system($command);

  return 1;
}

sub notify_if_regex {
  my ($server, $title, $message, $channel, $nick) = @_;

  my $filter = Irssi::settings_get_str('notifier_on_regex');

  if ($filter && $message !~ /$filter/) {
    return 0;
  }

  my $subtitle = $channel;
  notify($server, $title, $subtitle, $message);
}

sub notify_if_channel_regex {
  my ($server, $title, $message, $channel, $nick) = @_;

  my $channel_name = $channel;
  $channel_name =~ s/#//g;

  my $channel_filter = Irssi::settings_get_str('notifier_channel_regex');

  if ($channel_filter && $channel_name !~ /$channel_filter/) {
    return 0;
  }

  my $subtitle = $channel;
  notify($server, $title, $subtitle, $message);
}

sub notify_if_privmsg {
  my ($server, $title, $message, $nick) = @_;

  my $notifier_on_privmsg = Irssi::settings_get_str('notifier_on_privmsg');

  if ($notifier_on_privmsg != 1) {
    return 0;
  }

  notify($server, $title, undef, $message);
}

sub maybe_notify {
  my ($server, $title, $message, $address, $nick) = @_;
  return if notify_if_regex($server, $title, $message, $address, $nick);
  notify_if_channel_regex($server, $title, $message, $address, $nick);
}

sub notify_message_public {
  my ($server, $message, $nick, $address, $address) = @_;
  my $title = $nick;
  maybe_notify($server, $title, $message, $address, $nick);
}

sub notify_message_private {
  my ($server, $message, $nick, $host) = @_;
  notify_if_privmsg($server, $nick, $message, $nick);
}

sub notify_message_join {
  my ($server, $channel, $nick, $address) = @_;
  my $title = 'Join';
  my $message = "$nick has joined";
  maybe_notify($server, $title, $message, $address, $nick);
}

sub notify_message_part {
  my ($server, $channel, $nick, $address, $reason) = @_;
  my $title = 'Part';
  my $message = "$nick has parted";
  maybe_notify($server, $title, $message, $address, $nick);
}

sub notify_message_quit {
  my ($server, $nick, $address, $reason) = @_;
  my $title = 'Quit';
  my $message = "$nick has quit: $reason";
  maybe_notify($server, $title, $message, $address, $nick);
}

sub notify_message_invite {
  my ($server, $channel, $nick, $address) = @_;
  my $title = 'Invite';
  my $message = "$nick has invited you on $channel";
  maybe_notify($server, $title, $message, $address, $nick);
}

sub notify_message_topic {
  my ($server, $channel, $topic, $nick, $address) = @_;
  my $title = 'Topic: $topic';
  my $message = "$nick has changed the topic to $topic on $channel";
  maybe_notify($server, $title, $message, $address, $nick);
}

Irssi::settings_add_str('misc', 'notifier_on_regex',      0);
Irssi::settings_add_str('misc', 'notifier_channel_regex', 0);
Irssi::settings_add_str('misc', 'notifier_on_nick',       1);
Irssi::settings_add_str('misc', 'notifier_on_privmsg',    0);
Irssi::settings_add_str('misc', 'notifier_sound',         '');
Irssi::settings_add_str('misc', 'notifier_app_icon',      '');

Irssi::signal_add('message public',  'notify_message_public');
Irssi::signal_add('message private', 'notify_message_private');
Irssi::signal_add('message join',    'notify_message_join');
Irssi::signal_add('message part',    'notify_message_part');
Irssi::signal_add('message quit',    'notify_message_quit');
Irssi::signal_add('message invite',  'notify_message_invite');
Irssi::signal_add('message topic',   'notify_message_topic');
