#!/usr/local/bin/perl
# Print the environment

print "Content-type: text/plain\n\n";
foreach $var (sort(keys(%ENV))) {
  $val = $ENV{$var};
  $val =~ s|\n|\\n|g;
  $val =~ s|"|\\"|g;
  print "${var}=\"${var}\"\n";
}
