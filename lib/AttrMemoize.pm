use strict;
use warnings;
package AttrMemoize;

use Attribute::Handlers;

my $cache = {};

sub ClassMemoize :ATTR {
  my ($package, $symbol, $referent) = @_;
  
  my $name = *{$symbol}{NAME};
  my $sub_name = "$package\::$name";
  _setup_wrapper(
    cache_key => $package,
    sub_name  => $sub_name,
    code      => $referent,
  );
}

sub InstanceMemoize : ATTR {

}

sub _setup_wrapper {
  my (%params) = @_;
  no strict 'refs';
  *{$params{sub_name}} = sub {
    $cache->{$params{cache_key}} ||= $params{code}->(@_);
  };
}

1;
