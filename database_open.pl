#!/usr/local/bin/perl -w

format top =
                 Database Opening Report
                 +++++++++++++++++++++++
 Time                                    OPEN MODE
 __________________                      _________
.
format STDOUT =
@<<<<<<<<<<<<<<<<<<                      @<<<<<<<<<<<<
substr("$TEST",0,19), $SEQ[$#$SEQ]
.
print "Oracle Home : $ENV{ORACLE_HOME} \n";
print "Oracle Sid  : $ENV{ORACLE_SID} \n";

if ( ! $ENV{"ALERT"} ) {
  print "Set environment variable ALERT to Alert Log file location ! \n";
  exit(1);
}

open (FH,$ENV{"ALERT"});
while (<FH>) {
    if (/Mon|Tue|Wed|Thu|Fri|Sat|Sun/) {
       $TEST = $_;
       next;
    }
    @SEQ = split / /;
    write if /Complete.*OPEN/;
    write if /Complete.*open/;
}
close(FH);

