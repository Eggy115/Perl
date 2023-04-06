#!/usr/bin/perl
#
# Entry Completion
#
# GtkEntryCompletion provides a mechanism for adding support for completion in GtkEntry.
#
# Perl version by Dave M <dave.nerd@gmail.com>

use strict;
use warnings;

use Gtk3 '-init';
use Glib 'TRUE', 'FALSE';

my $window = Gtk3::Dialog->new();
$window->add_button( 'gtk-close', 1 );
$window->set_title('Entry Completion');

$window->set_resizable(FALSE);
$window->signal_connect( response => sub { Gtk3->main_quit } );
$window->signal_connect( destroy  => sub { Gtk3->main_quit } );

my $icon = 'gtk-logo-rgb.gif';
if ( -e $icon ) {
    my $pixbuf = Gtk3::Gdk::Pixbuf->new_from_file($icon);
    my $transparent = $pixbuf->add_alpha( TRUE, 0xff, 0xff, 0xff );
    $window->set_icon($transparent);
}

my $box = Gtk3::Box->new( 'vertical', 5 );
$box->set_border_width(5);
$box->set_homogeneous(FALSE);
$window->get_content_area()->add($box);

my $label = Gtk3::Label->new('');
$label->set_markup( 'Completion demo: try writing <b>total</b>'
        . ' or <b>gnome</b> for example.' );
$box->pack_start( $label, FALSE, FALSE, 0 );

# Create our entry
my $entry = Gtk3::Entry->new();
$box->pack_start( $entry, FALSE, FALSE, 0 );

# Create the completion object
my $completion = Gtk3::EntryCompletion->new();

# Assign completion to the entry
$entry->set_completion($completion);

my $completion_model = create_completion_model();
$completion->set_model($completion_model);
$completion->set_text_column(0);

$window->show_all();

Gtk3->main();

sub create_completion_model {
    my $liststore = Gtk3::ListStore->new('Glib::String');

    my $iter = $liststore->append;

    $liststore->append($iter);
    $liststore->set( $iter, 0, 'GNOME' );

    $iter = $liststore->append;
    $liststore->set( $iter, 0, 'total' );

    $iter = $liststore->append;
    $liststore->set( $iter, 0, 'totally' );

    return $liststore;
}

# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Library General Public License
# as published by the Free Software Foundation; either version 2.1 of
# the License, or (at your option) any later version.
