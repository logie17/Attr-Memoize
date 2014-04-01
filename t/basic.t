use Test::Most;

my $class = 'AttrMemoize'; 
use_ok($class);

subtest "General memoize subclass test" => sub {
  {
    package Test;
    use parent 'AttrMemoize';
    sub new : ClassMemoize { bless {} };

  }
  my $test;
  lives_ok { $test = Test->new }; 
  is ref $test, 'Test';
};

done_testing;
