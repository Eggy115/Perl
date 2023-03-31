#!/usr/local/bin/perl -w
format top =
                 LOG SWITCH REPORT
                 +++++++++++++++++
 Time                                    Sequence
 __________________                      _____________
.
format STDOUT =
@<<<<<<<<<<<<<<<<<<                      @<<<<<<<<<<<<
substr("$TEST",0,19), $SEQ[$#$SEQ]
.

if ( ! $ENV{"ALERT"} ) {
  print "Set environment variable ALERT to Alert Log file location ! \n";
  exit(1);
}

print "\n";
print "Oracle Home : $ENV{ORACLE_HOME} \n";
print "Oracle Sid  : $ENV{ORACLE_SID} \n";
print "Alert Log   : $ENV{ALERT} \n";
print "\n";

open (FH,$ENV{"ALERT"});
while (<FH>) {
    if (/Mon|Tue|Wed|Thu|Fri|Sat|Sun/) {
       $TEST = $_;
       next;
    }

    @SEQ = split / /;
    write if /Thread.*advanced/;
}
close(FH);

