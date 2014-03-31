use strict;
use warnings;
package AttrMemoize;

use Attribute::Handlers;

my $cache = {};

sub Memoize :ATTR {
  my ($package, $symbol, $referent) = @_;

  my $name = *{$symbol}{NAME};
  no strict 'refs';
  *{"$package\::$name"} = sub {
    $cache->{$package} ||= $referent->(@_);
  };
}

1;
