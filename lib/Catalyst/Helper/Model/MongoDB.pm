package Catalyst::Helper::Model::MongoDB;
use strict;
use warnings;

=pod

=head1 NAME

Catalyst::Helper::Model::MongoDB - Helper for MongoDB models

=head1 SYNOPSIS

  script/myapp_create.pl model MyModel MongoDB [host] [port] [dbname] [collectionname] [gridfs]

=head1 DESCRIPTION

Helper for the L<Catalyst> MongoDB model.

=head1 USAGE

=head1 METHODS

=head2 mk_compclass

Makes the model class.

=head2 mk_comptest

Makes tests.

=cut

sub mk_compclass {
    my ( $self, $helper, $host, $port, $dbname, $collectionname, $gridfs ) = @_;

	my %args = (
		host => $host,
		port => $port,
		dbname => $dbname,
		collectionname => $collectionname,
		gridfs => $gridfs,
	);
	
    $helper->render_file('modelclass', $helper->{file}, \%args);
    return 1;
}

sub mk_comptest {
    my ($self, $helper) = @_;
    $helper->render_file('modeltest', $helper->{test});
}

=pod

=head1 SUPPORT

IRC

  Join #catalyst on irc.perl.org and ask for Getty.

Repository

  http://github.com/Getty/p5-catalyst-model-mongodb
  Pull request and additional contributors are welcome
 
Issue Tracker

  http://github.com/Getty/p5-catalyst-model-mongodb/issues

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de>
Soren Dossing <netcom@sauber.net>

=head1 BUGS 

Please report any bugs or feature requests on the github issue tracker http://github.com/Getty/p5-catalyst-model-mongodb/issues
or to Getty or sauber on IRC at irc.perl.org, or make a pull request at http://github.com/Getty/p5-catalyst-model-mongodb

=head1 COPYRIGHT & LICENSE 

Copyright 2010 Torsten Raudssus, all rights reserved.

This library is free software; you can redistribute it and/or modify it under the same terms as 
Perl itself, either Perl version 5.8.8 or, at your option, any later version of Perl 5 you may 
have available.

=cut

1;

__DATA__

=begin pod_to_ignore

__modelclass__
package [% class %];

use Moose;
BEGIN { extends 'Catalyst::Model::MongoDB' };

__PACKAGE__->config(
	host => '[% host || 'localhost' %]',
	port => '[% port || '27017' %]',
	dbname => '[% dbname %]',
	collectionname => '[% collectionname %]',
	gridfs => '[% gridfs %]',
);

=head1 NAME

[% class %] - MongoDB Catalyst model component

=head1 SYNOPSIS

See L<[% app %]>.

=head1 DESCRIPTION

MongoDB Catalyst model component.

=head1 AUTHOR

[% author %]

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

no Moose;
__PACKAGE__->meta->make_immutable;

1;
__modeltest__
use strict;
use warnings;
use Test::More tests => 2;

use_ok('Catalyst::Test', '[% app %]');
use_ok('[% class %]');
