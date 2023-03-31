#!/usr/local/bin/perl

print "A # has ASCII value ", ord("#"), "\n";
print "A * has ASCII value ", ord("*"), "\n";

$ascii = 000;
while ($ascii <= 128) {
  print "Ascii for $ascii is ", chr("$ascii"), "\n";
$ascii = $ascii + 1;}

## End of Script
