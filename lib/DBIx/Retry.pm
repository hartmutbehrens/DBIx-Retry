package DBIx::Retry;
use parent qw(DBIx::Connector);
# ABSTRACT: DBIx::Retry - DBIx::Connector with the ability to retry the run method for a specified amount of time.

use strict;
use warnings;

#modules
use Moo;
use Data::Dumper;
use Try::Tiny;

has timeout => (is => 'rw', default => sub { return 30 });
has verbose => (is => 'rw', default => sub { return 1 });

before run => sub {
	my $self = shift;
	my $i = 1;
	$self->_try_connect;
	while (! $self->connected) {
		warn "DBIx::Retry retry $i\n" if $self->verbose;
		sleep(1);
		$self->_try_connect;
		last if $i >= $self->timeout;
		$i++;
	}	
};

sub _try_connect {
	my $self = shift;
	try {	
		$self->dbh;		#connect to the database
	}
}

sub BUILDARGS {} #just pass all the construction arguments to DBIx::Connector	
1;
__END__