#!/usr/bin/perl
use strict;
use warnings;

# first, create your message
use Email::MIME;
my $message = Email::MIME->create(
  header_str => [
    From    => 'eggy115@example.com',
    To      => 'eggy116@example.com',
    Subject => 'Happy birthday!',
  ],
  attributes => {
    encoding => 'quoted-printable',
    charset  => 'ISO-8859-1',
  },
  body_str => "Happy birthday to you!\n",
);

# send the message
use Email::Sender::Simple qw(sendmail);
sendmail($message);
