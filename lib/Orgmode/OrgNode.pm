#!/usr/bin/env perl6

use v6;

class OrgNode {
    has Str $.title is rw;
    has Int $.level is rw;

    method Str(){
        "*" x $.level ~ " " ~ $.title;
    }
}
