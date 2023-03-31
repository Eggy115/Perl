#!/usr/bin/perl
use strict;
use warnings;

use Spreadsheet::Read;

my $workbook = ReadData ("test.xls");
print $workbook->[1]{A3} . "\n";
