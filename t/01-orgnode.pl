#!/usr/bin/env perl6

use v6;

BEGIN { @*INC.push('../lib') }

use Orgmode::OrgNode;


my OrgNode $orgnode .= new(:title<The Title>, :level(1));
say $orgnode.perl;
say $orgnode;
