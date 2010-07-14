package Catalyst::Model::MongoDB;
use MongoDB;
use MongoDB::OID;
use Moose;

BEGIN { extends 'Catalyst::Model' }

our $VERSION = '0.04';

has hostname => ( isa => 'Str', is => 'ro', default => 'localhost' );
has port     => ( isa => 'Int', is => 'ro', default => 27017 );
has dbname   => ( isa => 'Str', is => 'ro' );

has 'connection' => (
    isa => 'MongoDB::Connection',
    is => 'rw',
    lazy_build => 1
);

has 'dbh' => (
    isa => 'MongoDB::Database',
    is => 'rw',
    lazy_build => 1,
);

sub _build_connection {
    my ($self) = @_;
    return MongoDB::Connection->new(
        host => $self->hostname,
        port => $self->port,
    );
}

sub _build_dbh {
    my ($self) = @_;
    return $self->connection->get_database($self->dbname);
}

sub dbnames {
  MongoDB::Connection->new->database_names();
}

sub oid {
  my($self, $_id) = @_;
  return MongoDB::OID->new( value => $_id );
}

no Moose;

__PACKAGE__->meta->make_immutable;

1;

=pod

=head1 NAME

Catalyst::Model::MongoDB - MongoDB model class for Catalyst

=head1 SYNOPSIS

    # Config
    #
    <Model::MyModel>
        hostname localhost
        port 27017
        dbname mydatabase
    </Model::MyModel>

    # Model
    #
    package MyApp::Model::MyModel;
    use Moose;
    use MooseX::Method::Signatures;
    BEGIN { extends 'Catalyst::Model::MongoDB' };

    method my_collection {
        $self->dbh->get_collection('MyCollection');
    }

    method records($query = {}) {
      $self->my_collection->query($query)->all;
    }

    method add($object = {}) {
        # XXX: Figure out and add hex code for color automatically
        $self->my_collection->insert($object);
    }

    method remove($where  = {}) {
        $self->my_collection->remove($where);
    }

    method remove_all {
        $self->my_collection->drop;
    }

    # Controller
    #
    $c->model('MyModel')->add({ name => 'Foo' });
    $foo = $c->model('MyModel')->records({ name => 'Foo' });
    @records = $c->model('MyModel')->records();
    $c->model('MyModel')->remove({ name => 'Foo' });

	
=head1 DESCRIPTION

This model class exposes L<MongoDB::Connection> as a Catalyst model.

=head1 CONFIGURATION

You can pass the same configuration fields as when you make a new L<MongoDB::Connection>.

=head1 METHODS

=head2 dbnames

List of databases.

=head2 oid

Creates MongoDB::OID object

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de>
Soren Dossing <netcom@sauber.net>

=head1 BUGS 

Please report any bugs or feature requests to me on IRC Getty at irc.perl.org, or make a pull request
at http://github.com/Getty/catalyst-model-mongodb

=head1 COPYRIGHT & LICENSE 

Copyright 2010 Torsten Raudssus, all rights reserved.

This library is free software; you can redistribute it and/or modify it under the same terms as 
Perl itself, either Perl version 5.8.8 or, at your option, any later version of Perl 5 you may 
have available.

=cut
