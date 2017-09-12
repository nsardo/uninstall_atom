#!/usr//bin/env perl

=pod

=head1 AUTHOR

nsardo - L<https://www.linkedin.com/in/nicksardo/>

=head1 DESCRIPTION

A quick and dirty script to root out the known file
locations that the Atom editor creates, and delete
them as well as the Atom.app itself.

Basically, an "Uninstall Script" for the Atom Editor.

I should probably note that I knocked this script out
using Atom ;-) lol.

Usage:

(Terminal from within the uninstall_atom folder):

  chmod a+x uninstall_atom.pl
  ./uninstall_atom.pl <your user name>

=cut

use strict;
use warnings;
use 5.010;

use Term::ANSIColor;


my $user_n = "";
$user_n = $ARGV[0];

if ( ! $user_n ) {
  print color( 'bold red' );
  say "\nUsage: ./uninstall_atom.pl <your user name>\n";
  print color( 'reset' );
  exit(1);
}

print color( 'bold green' );
say "\n\nchecking for user {$user_n}'s Home directory...";
print color( 'reset' );

if( -e "/Users/$user_n" ) {
  print color( 'bold blue' );
  say "directory exists, beginning removal of Atom";
  print color( 'reset' );
} else {
  my $help = <<EOT;
  Possibly you mis-spelled your username?
  If you're not sure, open a terminal and type in:
  whoami
EOT
  print color( 'bold red' );
  say "\n$help";
  print color( 'reset' );
  exit(1);
}

#known non-user directories
my @files = qw| /usr/local/bin/atom
                /usr/local/bin/apm
                /Applications/Atom.app
              |;

foreach my $line ( @files ) {
    if( -e $line ) {
    `rm -rf "$line" `;
    print color( 'bold green' );
    say "[REMOVED FILE]: $line";
    print color( 'reset' );
  } else {
    print color( 'bold blue' );
    say "[FILE NOT PRESENT, MOVING ON]: $line";
    print color( 'reset' );
  }
}

#known user directory files
my @user_files = (
                    "/Users/$user_n/.atom",
                    "/Users/$user_n/Library/Preferences/com.github.atom.plist",
                    "/Users/$user_n/Library/Application Support/com.github.atom.ShipIt",
                    "/Users/$user_n/Library/Application Support/Atom",
                    "/Users/$user_n/Library/Saved Application State/com.github.atom.savedState",
                    "/Users/$user_n/Library/Caches/com.github.atom",
                    "/Users/$user_n/Library/Caches/com.github.atom.Shipit",
                    "/Users/$user_n/Library/Caches/Atom"
                  );

foreach my $line ( @user_files ) {
  if( -e $line ) {
    `rm -rf "$line" `;
    print color( 'bold green' );
    say "[REMOVED FILE]: $line";
    print color( 'reset' );
  } else {
    print color( 'bold blue' );
    say "[FILE NOT PRESENT, MOVING ON]: $line";
    print color( 'reset' );
  }
}

print color( 'bold green' );
say "\nAll known artifacts of Atom have been removed from your system.";
print color('reset');
