use v6;

BEGIN { @*INC.push('../lib'); }

use Orgmode::OrgNode;
use Orgmode::Grammar;
use Orgmode::Actions;

sub usage() {
    say "usage: perl6 06-parse-file.t <file>";
    die;
}

sub parse_file($file) {
    my $handle = open $file;
    my $str = $handle.slurp;

    say $str;
    my $actions = Orgmode::Actions.new;
    my $match = Orgmode::Grammar.parse($str, :$actions);
    my @orgnodes = $match.ast;
    say "OrgNode Dump:";
    .perl.say for @orgnodes;
}

my @ARGS = <test.org>;
say @ARGS.perl;

die unless @ARGS.elems != 0;

for @ARGS -> $file {
    say $file;
    parse_file($file);
}
