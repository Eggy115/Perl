#!/usr/local/bin/perl -w

#use strict;

$interval=60;         # How many seconds before we check to see if data has been written to the logfile;
$email_threshold=3;   # How many errors within the interval before an email gets sent;
$hostname=`uname -n`; # Get the hostname from the OS
$file="$ENV{'ORACLE_HOME'}".'/network/log/listener.log'; # Get the Oracle Home from the OS Environment

open(filePtr, $file) or die "Can't find $file\n";

for (;;) {  
@errors=("Subject: Listener Password  Errors for $hostname\n");  
$currTime = localtime(time);  
push(@errors,"Here are some errors found at $currTime for $hostname.\n");  
while (<filePtr>) {   
  chop $_;   
  if (/TNS-01190/ || /TNS-01169/ || /TNS-12508/) {       
  push(@errors, "$_\n");    
  }  
}  

if ($#errors > $email_threshold)  {   
$rndExt = time;   
$rndFile = "alert_errors_$rndExt";   
open (TMPFILE, ">/tmp/$rndFile");   

foreach $error (@errors) {        
print TMPFILE $error;   
}   
close(TMPFILE);   
system ("mailx -s \"Listener Errors for $hostname\" name\@address.com < /tmp/$rndFile");   
system ("rm /tmp/$rndFile");  
}  
sleep $interval;  
seek filePtr, 0, 1;
}

## End of Script

