#!/usr/local/bin/perl -w

use strict;

print "enter a hex number: ";
chomp(my $hexnum = <STDIN>);
print "converted to an int: ", hex($hexnum), "\n";

print "enter a octal number: ";
chomp(my $octal = <STDIN>);
print "converted to an int: ", oct($octal), "\n";

## End of Script
