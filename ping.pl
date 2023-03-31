#!/usr/local/bin/perl

$subnet = 000;
while ($subnet <= 255) {
  system("ping 170.198.42.$subnet");
$subnet = $subnet + 1;}

