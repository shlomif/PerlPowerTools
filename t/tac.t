#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;

sub _lines2re
{
    return join( qq#\r?\n#, @_ ) . qq#\r?\n?#;
}

sub test_tac
{
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    my ($args) = @_;

    my @files = @{ $args->{files} };
    my @flags = @{ $args->{flags} };

    # die "@flags @files";
    my $re = _lines2re( @{ $args->{lines} } );
    return like( scalar(`$^X -Ilib bin/tac @flags @files`),
        qr#\A$re\z#ms, $args->{blurb} );
}

# TEST
test_tac(
    {
        blurb => "multiple files tac",
        files => [
            qw( t/data/sort/three-words.txt t/data/sort/ints1.txt t/data/sort/letters1.txt )
        ],
        flags => [qw/ /],
        lines => [ split /\n/, <<'EOF'],
column by pencil
row by row
mooing yodelling dog
mooing persistent cat
a little love
the meta protocol
based little mint
the wonderful unicorn
15
100
48
33
12
35
44
17
59
92
53
29
46
2
70
64
54
13
85
23
82
57
38
32
56
99
34
83
19
77
9
79
60
4
89
86
1
52
45
78
95
11
90
40
98
81
43
93
91
8
21
22
39
69
96
24
68
67
31
87
72
16
5
76
62
71
6
42
97
27
49
50
94
61
88
30
14
65
3
73
74
26
58
80
47
37
41
36
75
63
7
51
28
25
84
10
18
55
20
66
e
f
c
a
d
b
EOF
    }
);

# TEST
test_tac(
    {
        blurb => "-s flag",
        files => [qw( t/data/tac/a-sep.txt )],
        flags => [qw/ -s a /],
        lines => [ split /\n/, <<'EOF'],
threeatwoaonea
EOF
    }
);

# TEST
test_tac(
    {
        blurb => "-s and -r flags",
        files => [qw( t/data/tac/a-sep.txt )],
        flags => [qw/ -rs "[az]" /],
        lines => [ split /\n/, <<'EOF'],
threeatwoaonea
EOF
    }
);

# TEST
test_tac(
    {
        blurb => "-n flag",
        files => [ qw( t/data/sort/three-words.txt ), ],
        flags => [qw/ -n /],
        lines => [ split /\n/, <<'EOF'],
     8	column by pencil
     7	row by row
     6	mooing yodelling dog
     5	mooing persistent cat
     4	a little love
     3	the meta protocol
     2	based little mint
     1	the wonderful unicorn
EOF
    }
);

# TEST
test_tac(
    {
        blurb => "multiple files tac -n",
        files => [
            qw( t/data/sort/three-words.txt t/data/sort/ints1.txt t/data/sort/letters1.txt )
        ],
        flags => [qw/ -n /],
        lines => [ split /\n/, <<'EOF'],
   114	column by pencil
   113	row by row
   112	mooing yodelling dog
   111	mooing persistent cat
   110	a little love
   109	the meta protocol
   108	based little mint
   107	the wonderful unicorn
   106	15
   105	100
   104	48
   103	33
   102	12
   101	35
   100	44
    99	17
    98	59
    97	92
    96	53
    95	29
    94	46
    93	2
    92	70
    91	64
    90	54
    89	13
    88	85
    87	23
    86	82
    85	57
    84	38
    83	32
    82	56
    81	99
    80	34
    79	83
    78	19
    77	77
    76	9
    75	79
    74	60
    73	4
    72	89
    71	86
    70	1
    69	52
    68	45
    67	78
    66	95
    65	11
    64	90
    63	40
    62	98
    61	81
    60	43
    59	93
    58	91
    57	8
    56	21
    55	22
    54	39
    53	69
    52	96
    51	24
    50	68
    49	67
    48	31
    47	87
    46	72
    45	16
    44	5
    43	76
    42	62
    41	71
    40	6
    39	42
    38	97
    37	27
    36	49
    35	50
    34	94
    33	61
    32	88
    31	30
    30	14
    29	65
    28	3
    27	73
    26	74
    25	26
    24	58
    23	80
    22	47
    21	37
    20	41
    19	36
    18	75
    17	63
    16	7
    15	51
    14	28
    13	25
    12	84
    11	10
    10	18
     9	55
     8	20
     7	66
     6	e
     5	f
     4	c
     3	a
     2	d
     1	b
EOF
    }
);
__END__

=head1 COPYRIGHT & LICENSE

Copyright 2018 by Shlomi Fish

This code is licensed under the Artistic License 2.0
L<https://opensource.org/licenses/Artistic-2.0>, or at your option any later
version of the Artistic License from TPF ( L<https://www.perlfoundation.org/> )
.
