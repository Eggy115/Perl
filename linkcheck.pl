#!/usr/local/bin/perl -w

   BEGIN { $diagnostics::PRETTY = 1 }

   $SIG{'INT'} = sub {print "\nExiting on $SIG{'INT'}\n";exit $SIG{'INT'}};

   use File::Find;
   use Getopt::Std;
   use Cwd;
   use POSIX qw(uname);
   my $host =  (uname)[1];

   use vars qw($opt_a $opt_H $opt_h $opt_l $opt_r $opt_v);
   my $options='aHhlrv';
   exit_usage("Invalid option!\n") unless (getopts($options));
   show_documentation()                 if ($opt_H); # Full documentation
   exit_usage()                         if ($opt_h); # or usage brief.
   exit_usage("Filesystem required.\n") if ($#ARGV < 0);

   if ($opt_v)
   {
      use diagnostics;
   }
   my $local_fs;
   my @search;
   foreach (@ARGV)
   {
      if ($local_fs = `df -lk $_`)
      {
         push(@search, $_);
      }
      else
      {
         print "File system $_ must be local to $host, not NFS mounted.",
               "\nSkipping $_.\n";
         $_ = "";
      }
   }

   open(OLDERR, ">&STDERR");
   open(STDERR, ">/dev/null") or die "Can't redirect stderr: $!";

   my $q = 0; # Found counter
   my $r = 0; # Removed counter
   find sub # [Anonymous] subroutine reference (called a coderef).
   {
      return unless -l "$_"; # Skip all but links.

      return if (
                   (lstat("$_"))[0] < 0
                ||
                   $File::Find::name =~ /\/proc/s
                ||
                   $File::Find::name =~ /\/cdrom/s
                );

      my $dir = cwd;
      return unless ($local_fs = `df -lk $dir`);

      $! = 0; # Clear error message variable
      return unless defined(my $target = readlink("$_"));

      my $error  = "$!";
         $error  = "($error)" if (defined($error) && $error ne "");

      my $ls_out = ($opt_l)
        ? `ls -albd $File::Find::name 2> /dev/null`
        : "$File::Find::name -> $target";

      chomp($ls_out);

      unless (-e "$target") # Unless the link is OK, do the following.
      {
         $q++;
         print "Broken link: $ls_out $error\n";
         if ($opt_r)
         {
            print  "rm '$File::Find::name'\n";
            if (unlink("$File::Find::name") == 0) # Zero = none deleted.
            {
               print "Unable to remove $File::Find::name!\n";
               return;
            }
            $r++;
            print "Removed '$File::Find::name'\n" if ($opt_v);
         }
         return;
      }

      return unless ($opt_a);

      if    (-f "$target") { print "Linked file: $ls_out $error\n"; }
      elsif (-d "$target") { print "Linked dir:  $ls_out $error\n"; }
      elsif (-l "$target") { print "Linked link: $ls_out $error\n"; }
      elsif (-p "$target") { print "Linked pipe: $ls_out $error\n"; }
      elsif (-S "$target") { print "Linked sock: $ls_out $error\n"; }
      elsif (-b "$target") { print "Linked dev:  $ls_out $error\n"; }
      elsif (-c "$target") { print "Linked char: $ls_out $error\n"; }
      elsif (-t "$target") { print "Linked tty:  $ls_out $error\n"; }
      else                 { print "Linked ???:  $ls_out $error\n"; }

      $error = "";
      return;
   }, @search; # find sub

   close(STDERR) or die "Can't close STDERR: $!";
   open( STDERR, ">&OLDERR") or die "Can't restore stderr: $!";
   close(OLDERR) or die "Can't close OLDERR: $!";

   print "$host: Found $q broken links.  Removed $r.\n";
   exit 1;


#----------------------------------------------------------------------#
sub exit_usage # Exits with non-zero status.                           #
               # Global vars:   $main::notify                          #
               #                $main::support                         #
#----------------------------------------------------------------------#
{
   my $fn_name = "exit_usage";
   my $txt     ;

   my $notify;
   if (defined($ENV{LOGNAME} )) { $notify = $ENV{LOGNAME}; }
   else                         { $notify = $ENV{USER};    }

   $txt =  "Usage:   $0 -$options fs ...\n";
   $txt =  "$_[0]\n$txt" if ($#_ >= 0); # Prefix message arguments
   $txt .= "\n         -a = Display All links."
        .  "\n         -H = Displays full documentation."
        .  "\n         -h = Gives usage brief."
        .  "\n         -l = Long list (e.g. 'ls -al')."
        .  "\n         -r = Remove broken links (use with caution)."
        .  "\n         -v = Verbose output."
        .  "\n         fs = Required filesystem for search."
        .  "\n              (multiple filesystems may be specified)\n"
        .  "\nPurpose: Search filesystem (descending directories) for"
        .  "\n         broken links, optionally displaying all links"
        .  "\n         (-a) and/or removing (-r) them.\n";

   print "$txt";

   exit 1;
}
__END__ 