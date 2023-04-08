#!/usr/bin/perl
use strict;
use warnings;

my $scalar_var = 'cat';
my @array_var  = (1,2,3,4,5);
my %hash_var   = ( 'car' => 'bmw', 'color' => 'blue' );

my $scalar_ref = \$scalar_var;
my $array_ref  = \@array_var;
my $hash_ref   = \%hash_var;

# deferencing is just prefixing another $,@,% depending on requirement
print "$$scalar_ref\n";
print "@$array_ref\n";
print "$$hash_ref{'color'}\n";
my @keys_hash_var = keys %$hash_ref;
print "keys of \%hash_var: @keys_hash_var\n";

# array of references
my @north = ( 'aloo tikki', 'baati', 'khichdi', 'makki roti', 'poha' );
my @south = ( 'appam', 'bisibele bath', 'dosa', 'koottu', 'sevai' );
my @west  = ( 'dhokla', 'khakhra', 'modak', 'shiro', 'vada pav' );
my @east  = ( 'hando guri', 'litti', 'momo', 'rosgulla', 'shondesh' );
my @zones = ( 'North', 'South', 'West', 'East' );

my @choose_dish = ( \@north, \@south, \@west, \@east );
my $rand_zone = int(rand(4));
my $rand_dish = int(rand(5));
print "Would you like to have '$zones[$rand_zone]' speciality '$choose_dish[$rand_zone]->[$rand_dish]' today?\n";
# -> is optional, used for clarity and readability
