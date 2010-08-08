use v6;

BEGIN { @*INC.push('../lib') }

use Orgmode::OrgNode;
use Orgmode::Grammar;
use Orgmode::Actions;

my $delimiter = "#" x 80;
{
say $delimiter;
my Str $str = Q<<* first
* second>>;

my $actions = Orgmode::Actions.new;   
my $match = Orgmode::Grammar.parse($str, :$actions);
my @orgnodes = $match.ast;
say "OrgNode Dump:";
.perl.say for @orgnodes;
}


{
say $delimiter;
my Str $str = Q<<* first
** second>>;

my $actions = Orgmode::Actions.new;
my $match = Orgmode::Grammar.parse($str, :$actions);
my @orgnodes = $match.ast;
say "OrgNode Dump:";
.perl.say for @orgnodes;
say $delimiter;
}


