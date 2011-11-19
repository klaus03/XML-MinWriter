use strict;
use warnings;

use Test::More tests => 73;

use_ok('XML::MinWriter');

{
    open my $fh, '>', \my $xml or die "Error-0010: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, DATA_MODE => 1, DATA_INDENT => 2);

    $wrt->xmlDecl('iso-8859-1');
    $wrt->doctype('delta', 'public', 'system');
    $wrt->startTag('delta');
    $wrt->startTag('dim', alter => '511');
    $wrt->emptyTag('gamma', parm1 => 'abc', parm2 => 'def');
    $wrt->startTag('beta');
    $wrt->characters('car');
    $wrt->endTag('beta');
    $wrt->startTag('alpha');
    $wrt->pi('tt', 'dat');
    $wrt->endTag('alpha');
    $wrt->startTag('epsilon');
    $wrt->comment('remark');
    $wrt->endTag('epsilon');
    $wrt->dataElement('omega', 'fkfdsjhkjhkj', type1 => 'a', type2 => 'b', type3 => 'c');
    $wrt->endTag('dim');
    $wrt->startTag('kappa');
    $wrt->characters('dsk\\njfh');
    $wrt->characters('uuu & < > &amp; &gt; &lt; ZZZ');
    $wrt->endTag('kappa');
    $wrt->startTag('root');
    $wrt->characters("  test1 \\n \\t \\ \\\\ \\\\\\ a\tb ");
    $wrt->characters("  test2");
    $wrt->endTag('root');
    $wrt->endTag('delta');

    $wrt->end;
    close $fh;

    my @xlines = split qq{\n}, $xml;

    is(scalar(@xlines), 15,                                                                          'Test-0010: Number of lines in XML correct');

    is($xlines[ 0], q{<?xml version="1.0" encoding="iso-8859-1"?>},                                  'Test-0012: xml decl correct');
    is($xlines[ 1], q{<!DOCTYPE delta PUBLIC "public" "system">},                                    'Test-0014: Doctype correct');
    is($xlines[ 2], q{<delta>},                                                                      'Test-0018: Main opening tag correct');
    is($xlines[ 3], q{  <dim alter="511">},                                                          'Test-0020: Second opening tag correct');
    is($xlines[ 4], q{    <gamma parm1="abc" parm2="def" />},                                        'Test-0022: open-close correct');
    is($xlines[ 5], q{    <beta>car</beta>},                                                         'Test-0024: Beta correct');
    is($xlines[ 6], q{    <alpha><?tt dat?></alpha>},                                                'Test-0026: Alpha correct');
    is($xlines[ 7], q{    <epsilon>},                                                                'Test-0027: opening epsilon correct');
    is($xlines[ 8], q{      <!-- remark -->},                                                        'Test-0028: Comment inside epsilon correct');
    is($xlines[ 9], q{    </epsilon>},                                                               'Test-0029: Closing epsilon correct');
    is($xlines[10], q{    <omega type1="a" type2="b" type3="c">fkfdsjhkjhkj</omega>},                'Test-0030: Omega correct');
    is($xlines[11], q{  </dim>},                                                                     'Test-0032: second closing tag correct');
    is($xlines[12], q{  <kappa>dsk\njfhuuu &amp; &lt; &gt; &amp;amp; &amp;gt; &amp;lt; ZZZ</kappa>}, 'Test-0034: Opening kappa correct');
    is($xlines[13], q{  <root>  test1 \n \t \\ \\\\ \\\\\\ a}.qq{\t}.q{b   test2</root>},            'Test-0036: Multiple backslashes correct');
    is($xlines[14], q{</delta>},                                                                     'Test-0038: Main closing tag correct');

    ok($xml =~ m{\S \n \z}xms,                                                                       'Test-0060: XML terminates with a newline');
}

{
    open my $fh, '>', \my $xml or die "Error-0015: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, LINE_MODE => 1, DATA_INDENT => 2);

    $wrt->xmlDecl('iso-8859-1');
    $wrt->doctype('delta', 'public', 'system');
    $wrt->startTag('delta');
    $wrt->startTag('dim', alter => '511');
    $wrt->emptyTag('gamma', parm1 => 'abc', parm2 => 'def');
    $wrt->startTag('beta');
    $wrt->characters('car');
    $wrt->endTag('beta');
    $wrt->startTag('alpha');
    $wrt->pi('tt', 'dat');
    $wrt->endTag('alpha');
    $wrt->startTag('epsilon');
    $wrt->comment('remark');
    $wrt->endTag('epsilon');
    $wrt->dataElement('omega', 'fkfdsjhkjhkj', type1 => 'a', type2 => 'b', type3 => 'c');
    $wrt->endTag('dim');
    $wrt->startTag('kappa');
    $wrt->characters('dsk\\njfh');
    $wrt->characters('uuu & < > &amp; &gt; &lt; ZZZ');
    $wrt->endTag('kappa');
    $wrt->startTag('root');
    $wrt->characters("  test1 \\n \\t \\ \\\\ \\\\\\ a\tb ");
    $wrt->characters("  test2");
    $wrt->endTag('root');
    $wrt->endTag('delta');

    $wrt->end;
    close $fh;

    my @xlines = split qq{\n}, $xml;

    is(scalar(@xlines), 27,                                                     'Test-0100: Number of lines in XML correct');

    is($xlines[ 0], q{<?xml version="1.0" encoding="iso-8859-1"?>},             'Test-0102: xml decl correct');
    is($xlines[ 1], q{<!DOCTYPE delta PUBLIC "public" "system">},               'Test-0104: Doctype correct');
    is($xlines[ 2], q{<delta>},                                                 'Test-0106: Main opening tag correct');
    is($xlines[ 3], q{  <dim alter="511">},                                     'Test-0108: Second opening tag correct');
    is($xlines[ 4], q{    <gamma parm1="abc" parm2="def" />},                   'Test-0110: open-close correct');
    is($xlines[ 5], q{    <beta>},                                              'Test-0112: Beta correct');
    is($xlines[ 6], q{      car},                                               'Test-0114: Character correct');
    is($xlines[ 7], q{    </beta>},                                             'Test-0116: Closing beta correct');
    is($xlines[ 8], q{    <alpha>},                                             'Test-0118: Alpha correct');
    is($xlines[ 9], q{      <?tt dat?>},                                        'Test-0120: ProcInst correct');
    is($xlines[10], q{    </alpha>},                                            'Test-0122: Closing alpha correct');
    is($xlines[11], q{    <epsilon>},                                           'Test-0124: opening epsilon correct');
    is($xlines[12], q{      <!-- remark -->},                                   'Test-0126: Remark correct');
    is($xlines[13], q{    </epsilon>},                                          'Test-0128: Closing epsilon correct');
    is($xlines[14], q{    <omega type1="a" type2="b" type3="c">},               'Test-0130: Omega correct');
    is($xlines[15], q{      fkfdsjhkjhkj},                                      'Test-0132: Text correct');
    is($xlines[16], q{    </omega>},                                            'Test-0134: Closing omega correct');
    is($xlines[17], q{  </dim>},                                                'Test-0136: second closing tag correct');
    is($xlines[18], q{  <kappa>},                                               'Test-0138: Opening kappa correct');
    is($xlines[19], q{    dsk\njfh},                                            'Test-0140: Text with \\n correct');
    is($xlines[20], q{    uuu &amp; &lt; &gt; &amp;amp; &amp;gt; &amp;lt; ZZZ}, 'Test-0142: Text with ampersand correct');
    is($xlines[21], q{  </kappa>},                                              'Test-0144: Closing kappa correct');
    is($xlines[22], q{  <root>},                                                'Test-0146: Opening root correct');
    is($xlines[23], q{      test1 \n \t \\ \\\\ \\\\\\ a}.qq{\t}.q{b },         'Test-0148: Multiple backslashes correct');
    is($xlines[24], q{      test2},                                             'Test-0150: Test2 correct');
    is($xlines[25], q{  </root>},                                               'Test-0152: Closing root correct');
    is($xlines[26], q{</delta>},                                                'Test-0154: Main closing tag correct');

    ok($xml =~ m{\S \n \z}xms,                                                  'Test-0160: XML terminates with a newline');
}

{
    open my $fh, '>', \my $xml or die "Error-0020: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, DATA_MODE => 1, DATA_INDENT => 2);

    $wrt->write_pyx('?xml version="1.0" encoding="iso-8859-1"');
    $wrt->write_pyx('(data');
    $wrt->write_pyx('(item');
    $wrt->write_pyx('Aattr1 p1');
    $wrt->write_pyx('Aattr2 p2');
    $wrt->write_pyx('-line');
    $wrt->write_pyx(')item');
    $wrt->write_pyx('(level');
    $wrt->write_pyx('#remark');
    $wrt->write_pyx(')level');
    $wrt->write_pyx(')data');

    $wrt->end;
    close $fh;

    my @xlines = split qq{\n}, $xml;

    is(scalar(@xlines), 7,                                                      'Test-0300: Number of lines in XML correct');

    is($xlines[ 0], q{<?xml version="1.0" encoding="iso-8859-1"?>},             'Test-0310: xml decl correct');
    is($xlines[ 1], q{<data>},                                                  'Test-0320: Main opening tag correct');
    is($xlines[ 2], q{  <item attr1="p1" attr2="p2">line</item>},               'Test-0330: Item attr correct');
    is($xlines[ 3], q{  <level>},                                               'Test-0360: Opening Level correct');
    is($xlines[ 4], q{    <!-- remark -->},                                     'Test-0370: Comment inside Level correct');
    is($xlines[ 5], q{  </level>},                                              'Test-0360: Closing Level correct');
    is($xlines[ 6], q{</data>},                                                 'Test-0390: Main closing tag correct');
}

{
    open my $fh, '>', \my $xml or die "Error-0030: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, NEWLINES => 1);

    $wrt->xmlDecl('iso-8859-1');
    $wrt->doctype('abc', undef, 'test');
    $wrt->startTag('abc');
    $wrt->emptyTag('smurf', var1 => 'blue', var2 => 'white');
    $wrt->startTag('dim', alter => '511');
    $wrt->characters('car');
    $wrt->pi('high', 'way');
    $wrt->comment('this is a comment');
    $wrt->endTag('dim');
    $wrt->endTag('abc');

    $wrt->end;
    close $fh;

    my @xlines = split qq{\n}, $xml;

    is(scalar(@xlines), 9,                                                      'Test-0500: Number of lines in XML correct');

    is($xlines[ 0], q{<?xml version="1.0" encoding="iso-8859-1"},               'Test-0510: xml decl correct');
    is($xlines[ 1], q{?><!DOCTYPE abc SYSTEM "test"},                           'Test-0520: Doctype correct');
    is($xlines[ 2], q{><abc},                                                   'Test-0530: Main opening tag correct');
    is($xlines[ 3], q{><smurf var1="blue" var2="white"},                        'Test-0540: Smurf opening closing tag correct');
    is($xlines[ 4], q{/><dim alter="511"},                                      'Test-0550: Opening dim tag correct');
    is($xlines[ 5], q{>car<?high way},                                          'Test-0560: Text plus ProcInst high tag correct');
    is($xlines[ 6], q{?><!-- this is a comment --></dim},                       'Test-0570: Comment plus closing dim tag correct');
    is($xlines[ 7], q{></abc},                                                  'Test-0580: Main closing tag correct');
    is($xlines[ 8], q{>},                                                       'Test-0590: Final > correct');
}

{
    open my $fh, '>', \my $xml or die "Error-0040: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, NEWLINES => 1);

    eval{
        $wrt->startTag('abc');
        $wrt->end;
    };

    like($@, qr{XML \s terminated \s with \s open \s tags}xms,                  'Test-0700: end() fails ok');

    close $fh;
}

{
    open my $fh, '>', \my $xml or die "Error-0050: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, NEWLINES => 1);

    eval{
        $wrt->startTag('abc');
        $wrt->endTag('abc');
        $wrt->endTag('abc');
        $wrt->end;
    };

    like($@, qr{Level \s underflow \s for \s end-tag}xms,                       'Test-0710: endTag() fails ok');

    close $fh;
}

{
    open my $fh, '>', \my $xml or die "Error-0060: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, NEWLINES => 1);

    eval{
        $wrt->startTag('abc');
        $wrt->write_pyx('');
        $wrt->endTag('abc');
        $wrt->end;
    };

    like($@, qr{Found \s empty \s string \s in \s write_pyx}xms,                'Test-0720: found empty string in write_pyx() fails ok');

    close $fh;
}

{
    open my $fh, '>', \my $xml or die "Error-0070: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, NEWLINES => 1);

    eval{
        $wrt->startTag('abc');
        $wrt->write_pyx('ZZZZ');
        $wrt->endTag('abc');
        $wrt->end;
    };

    like($@, qr{Invalid \s code \s = \s 'Z' \s in \s write_pyx}xms,             'Test-0730: Invalid code in write_pyx() fails ok');

    close $fh;
}

{
    open my $fh, '>', \my $xml or die "Error-0080: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, NEWLINES => 1);

    eval{
        $wrt->write_pyx('(abc');
        $wrt->write_pyx('A');
        $wrt->write_pyx(')abc');
        $wrt->end;
    };

    like($@, qr{Can't \s parse \s \(key, \s val\) \s \[code \s = \s 'A'\]}xms,    'Test-0740: Can t parse A fails ok');

    close $fh;
}

{
    open my $fh, '>', \my $xml or die "Error-0090: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, NEWLINES => 1);

    eval{
        $wrt->write_pyx('(abc');
        $wrt->write_pyx('?');
        $wrt->write_pyx(')abc');
        $wrt->end;
    };

    like($@, qr{Can't \s parse \s \(key, \s val\) \s \[code \s = \s '\?'\]}xms,   'Test-0750: Can t parse ? fails ok');

    close $fh;
}

{
    open my $fh, '>', \my $xml or die "Error-0100: Can't open > xml because $!";
    my $wrt = XML::MinWriter->new(OUTPUT => $fh, DATA_MODE => 1, DATA_INDENT => 2);

    $wrt->startTag('item');
    $wrt->characters('ccc');
    $wrt->endTag('item');

    $wrt->end;
    close $fh;

    my @xlines = split qq{\n}, $xml;

    is(scalar(@xlines), 1,                                                      'Test-0800: Number of lines in XML correct');

    is($xlines[ 0], q{<item>ccc</item>},                                        'Test-0810: Main opening tag correct');
}
