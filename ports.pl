#!/usr/local/bin/perl

use IO::Socket;
my $port = 1;
$file = "/tmp/ports.txt";
while ($port <= 10000){
  $sock = IO::Socket::INET->new(PeerAddr => '170.198.227.63',
    PeerPort => $port,
    Proto => 'tcp',
    Timeout => '1');
open (LIST, ">>$file");
  if ($sock){
    close ($sock);
    print "$port -open\n";
    print LIST "$port -open\n";
    $port = $port + 1;
    }
  else{
    print "$port -closed\n";
    $port = $port + 1;
    }
}
close(LIST);
#