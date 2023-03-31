#!/usr/local/bin/perl -w

use strict;


if ($#ARGV !=0) {
  die "Usage: perl_module_version.pl PERL_MODULE     eg perl_module_version.pl DBI.\n";
}

foreach my $module ( @ARGV ) {
  eval "require $module";
  printf( "%-20s: %s\n", $module, $module->VERSION ) unless ( $@ );
}

## End of Script
