#!/usr/bin/env perl6

use v6;

BEGIN { @*INC.push('../lib') }

use Orgmode::OrgNode;

my OrgNode $orgnode .= new(:title<The Title>, :level(1));
my OrgNode $secondnode .= new(:title<Second title>, :level(2));
$orgnode.children.push($secondnode);
say $orgnode.perl;
say $orgnode;
