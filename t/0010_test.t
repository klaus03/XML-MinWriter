use strict;
use warnings;

use Test::More tests => 352;

use_ok('XML::MinWriter');

{
    my (undef, @xlines) = get_xml_list('XML::MinWriter', 'ZZ');

    is(scalar(@xlines),  69,                                                          'Test-ZZ-0010 - Number of elements is correct');

    is($xlines[  0], q{},                                                             'Test-ZZ-0020');
    is($xlines[  1], q{<?xml.version="1.0".encoding="iso-8859-1"?>},                  'Test-ZZ-0030');
    is($xlines[  2], q{%n},                                                           'Test-ZZ-0040');
    is($xlines[  3], q{<!DOCTYPE.delta.PUBLIC."public"."system">},                    'Test-ZZ-0050');
    is($xlines[  4], q{%n},                                                           'Test-ZZ-0060');
    is($xlines[  5], q{<delta>},                                                      'Test-ZZ-0070');
    is($xlines[  6], q{},                                                             'Test-ZZ-0080');
    is($xlines[  7], q{<dim.alter="511">},                                            'Test-ZZ-0090');
    is($xlines[  8], q{},                                                             'Test-ZZ-0100');
    is($xlines[  9], q{<gamma.parm1="abc".parm2="def"./>},                            'Test-ZZ-0110');
    is($xlines[ 10], q{},                                                             'Test-ZZ-0120');
    is($xlines[ 11], q{<beta>},                                                       'Test-ZZ-0130');
    is($xlines[ 12], q{car},                                                          'Test-ZZ-0140');
    is($xlines[ 13], q{</beta>},                                                      'Test-ZZ-0150');
    is($xlines[ 14], q{},                                                             'Test-ZZ-0160');
    is($xlines[ 15], q{<alpha>},                                                      'Test-ZZ-0170');
    is($xlines[ 16], q{},                                                             'Test-ZZ-0180');
    is($xlines[ 17], q{<?tt.dat?>},                                                   'Test-ZZ-0190');
    is($xlines[ 18], q{},                                                             'Test-ZZ-0200');
    is($xlines[ 19], q{</alpha>},                                                     'Test-ZZ-0210');
    is($xlines[ 20], q{},                                                             'Test-ZZ-0220');
    is($xlines[ 21], q{<epsilon>},                                                    'Test-ZZ-0230');
    is($xlines[ 22], q{},                                                             'Test-ZZ-0240');
    is($xlines[ 23], q{<!--.remark.-->},                                              'Test-ZZ-0250');
    is($xlines[ 24], q{},                                                             'Test-ZZ-0260');
    is($xlines[ 25], q{</epsilon>},                                                   'Test-ZZ-0270');
    is($xlines[ 26], q{},                                                             'Test-ZZ-0280');
    is($xlines[ 27], q{<omega.type1="a".type2="b".type3="c">},                        'Test-ZZ-0290');
    is($xlines[ 28], q{fkfdsjhkjhkj},                                                 'Test-ZZ-0300');
    is($xlines[ 29], q{</omega>},                                                     'Test-ZZ-0310');
    is($xlines[ 30], q{},                                                             'Test-ZZ-0320');
    is($xlines[ 31], q{</dim>},                                                       'Test-ZZ-0330');
    is($xlines[ 32], q{},                                                             'Test-ZZ-0340');
    is($xlines[ 33], q{<kappa>},                                                      'Test-ZZ-0350');
    is($xlines[ 34], q{dsk\\njfh....yy},                                              'Test-ZZ-0360');
    is($xlines[ 35], q{</kappa>},                                                     'Test-ZZ-0370');
    is($xlines[ 36], q{},                                                             'Test-ZZ-0380');
    is($xlines[ 37], q{<test>},                                                       'Test-ZZ-0390');
    is($xlines[ 38], q{u.&amp;.&lt;.&gt;.&amp;amp;.&amp;gt;.&amp;lt;.Z},              'Test-ZZ-0400');
    is($xlines[ 39], q{</test>},                                                      'Test-ZZ-0410');
    is($xlines[ 40], q{},                                                             'Test-ZZ-0420');
    is($xlines[ 41], q{<test1>},                                                      'Test-ZZ-0430');
    is($xlines[ 42], q{},                                                             'Test-ZZ-0440');
    is($xlines[ 43], q{</test1>},                                                     'Test-ZZ-0450');
    is($xlines[ 44], q{},                                                             'Test-ZZ-0460');
    is($xlines[ 45], q{<one>},                                                        'Test-ZZ-0470');
    is($xlines[ 46], q{},                                                             'Test-ZZ-0480');
    is($xlines[ 47], q{<two>},                                                        'Test-ZZ-0490');
    is($xlines[ 48], q{},                                                             'Test-ZZ-0500');
    is($xlines[ 49], q{<three>},                                                      'Test-ZZ-0510');
    is($xlines[ 50], q{},                                                             'Test-ZZ-0520');
    is($xlines[ 51], q{<four>},                                                       'Test-ZZ-0530');
    is($xlines[ 52], q{},                                                             'Test-ZZ-0540');
    is($xlines[ 53], q{</four>},                                                      'Test-ZZ-0550');
    is($xlines[ 54], q{},                                                             'Test-ZZ-0560');
    is($xlines[ 55], q{</three>},                                                     'Test-ZZ-0570');
    is($xlines[ 56], q{},                                                             'Test-ZZ-0580');
    is($xlines[ 57], q{</two>},                                                       'Test-ZZ-0590');
    is($xlines[ 58], q{},                                                             'Test-ZZ-0600');
    is($xlines[ 59], q{<one-and-a-half.yo="man".ding="dong"./>},                      'Test-ZZ-0610');
    is($xlines[ 60], q{},                                                             'Test-ZZ-0620');
    is($xlines[ 61], q{</one>},                                                       'Test-ZZ-0630');
    is($xlines[ 62], q{},                                                             'Test-ZZ-0640');
    is($xlines[ 63], q{<root>},                                                       'Test-ZZ-0650');
    is($xlines[ 64], q{..test1.\\n.\\t.\\.\\\\.\\\\\\.a%tb...test2},                  'Test-ZZ-0660');
    is($xlines[ 65], q{</root>},                                                      'Test-ZZ-0670');
    is($xlines[ 66], q{},                                                             'Test-ZZ-0680');
    is($xlines[ 67], q{</delta>},                                                     'Test-ZZ-0690');
    is($xlines[ 68], q{%n},                                                           'Test-ZZ-0700');
}

{
    my (undef, @xlines) = get_xml_list('XML::MinWriter', 'LM');

    is(scalar(@xlines),  69,                                                          'Test-LM-0010 - Number of elements is correct');

    is($xlines[  0], q{},                                                             'Test-LM-0020');
    is($xlines[  1], q{<?xml.version="1.0".encoding="iso-8859-1"?>},                  'Test-LM-0030');
    is($xlines[  2], q{%n},                                                           'Test-LM-0040');
    is($xlines[  3], q{<!DOCTYPE.delta.PUBLIC."public"."system">},                    'Test-LM-0050');
    is($xlines[  4], q{%n},                                                           'Test-LM-0060');
    is($xlines[  5], q{<delta>},                                                      'Test-LM-0070');
    is($xlines[  6], q{%n..},                                                         'Test-LM-0080');
    is($xlines[  7], q{<dim.alter="511">},                                            'Test-LM-0090');
    is($xlines[  8], q{%n....},                                                       'Test-LM-0100');
    is($xlines[  9], q{<gamma.parm1="abc".parm2="def"./>},                            'Test-LM-0110');
    is($xlines[ 10], q{%n....},                                                       'Test-LM-0120');
    is($xlines[ 11], q{<beta>},                                                       'Test-LM-0130');
    is($xlines[ 12], q{%n......car%n....},                                            'Test-LM-0140');
    is($xlines[ 13], q{</beta>},                                                      'Test-LM-0150');
    is($xlines[ 14], q{%n....},                                                       'Test-LM-0160');
    is($xlines[ 15], q{<alpha>},                                                      'Test-LM-0170');
    is($xlines[ 16], q{%n......},                                                     'Test-LM-0180');
    is($xlines[ 17], q{<?tt.dat?>},                                                   'Test-LM-0190');
    is($xlines[ 18], q{%n....},                                                       'Test-LM-0200');
    is($xlines[ 19], q{</alpha>},                                                     'Test-LM-0210');
    is($xlines[ 20], q{%n....},                                                       'Test-LM-0220');
    is($xlines[ 21], q{<epsilon>},                                                    'Test-LM-0230');
    is($xlines[ 22], q{%n......},                                                     'Test-LM-0240');
    is($xlines[ 23], q{<!--.remark.-->},                                              'Test-LM-0250');
    is($xlines[ 24], q{%n....},                                                       'Test-LM-0260');
    is($xlines[ 25], q{</epsilon>},                                                   'Test-LM-0270');
    is($xlines[ 26], q{%n....},                                                       'Test-LM-0280');
    is($xlines[ 27], q{<omega.type1="a".type2="b".type3="c">},                        'Test-LM-0290');
    is($xlines[ 28], q{%n......fkfdsjhkjhkj%n....},                                   'Test-LM-0300');
    is($xlines[ 29], q{</omega>},                                                     'Test-LM-0310');
    is($xlines[ 30], q{%n..},                                                         'Test-LM-0320');
    is($xlines[ 31], q{</dim>},                                                       'Test-LM-0330');
    is($xlines[ 32], q{%n..},                                                         'Test-LM-0340');
    is($xlines[ 33], q{<kappa>},                                                      'Test-LM-0350');
    is($xlines[ 34], q{%n....dsk\\njfh..%n......yy%n..},                              'Test-LM-0360');
    is($xlines[ 35], q{</kappa>},                                                     'Test-LM-0370');
    is($xlines[ 36], q{%n..},                                                         'Test-LM-0380');
    is($xlines[ 37], q{<test>},                                                       'Test-LM-0390');
    is($xlines[ 38], q{%n....u.&amp;.&lt;.&gt;.&amp;amp;.&amp;gt;.&amp;lt;.Z%n..},    'Test-LM-0400');
    is($xlines[ 39], q{</test>},                                                      'Test-LM-0410');
    is($xlines[ 40], q{%n..},                                                         'Test-LM-0420');
    is($xlines[ 41], q{<test1>},                                                      'Test-LM-0430');
    is($xlines[ 42], q{%n..},                                                         'Test-LM-0440');
    is($xlines[ 43], q{</test1>},                                                     'Test-LM-0450');
    is($xlines[ 44], q{%n..},                                                         'Test-LM-0460');
    is($xlines[ 45], q{<one>},                                                        'Test-LM-0470');
    is($xlines[ 46], q{%n....},                                                       'Test-LM-0480');
    is($xlines[ 47], q{<two>},                                                        'Test-LM-0490');
    is($xlines[ 48], q{%n......},                                                     'Test-LM-0500');
    is($xlines[ 49], q{<three>},                                                      'Test-LM-0510');
    is($xlines[ 50], q{%n........},                                                   'Test-LM-0520');
    is($xlines[ 51], q{<four>},                                                       'Test-LM-0530');
    is($xlines[ 52], q{%n........},                                                   'Test-LM-0540');
    is($xlines[ 53], q{</four>},                                                      'Test-LM-0550');
    is($xlines[ 54], q{%n......},                                                     'Test-LM-0560');
    is($xlines[ 55], q{</three>},                                                     'Test-LM-0570');
    is($xlines[ 56], q{%n....},                                                       'Test-LM-0580');
    is($xlines[ 57], q{</two>},                                                       'Test-LM-0590');
    is($xlines[ 58], q{%n....},                                                       'Test-LM-0600');
    is($xlines[ 59], q{<one-and-a-half.yo="man".ding="dong"./>},                      'Test-LM-0610');
    is($xlines[ 60], q{%n..},                                                         'Test-LM-0620');
    is($xlines[ 61], q{</one>},                                                       'Test-LM-0630');
    is($xlines[ 62], q{%n..},                                                         'Test-LM-0640');
    is($xlines[ 63], q{<root>},                                                       'Test-LM-0650');
    is($xlines[ 64], q{%n......test1.\\n.\\t.\\.\\\\.\\\\\\.a%tb.%n......test2%n..},  'Test-LM-0660');
    is($xlines[ 65], q{</root>},                                                      'Test-LM-0670');
    is($xlines[ 66], q{%n},                                                           'Test-LM-0680');
    is($xlines[ 67], q{</delta>},                                                     'Test-LM-0690');
    is($xlines[ 68], q{%n},                                                           'Test-LM-0700');
}

{
    my (undef, @xlines) = get_xml_list('XML::MinWriter', 'DM');

    is(scalar(@xlines),  69,                                                          'Test-DM-0010 - Number of elements is correct');

    is($xlines[  0], q{},                                                             'Test-DM-0020');
    is($xlines[  1], q{<?xml.version="1.0".encoding="iso-8859-1"?>},                  'Test-DM-0030');
    is($xlines[  2], q{%n},                                                           'Test-DM-0040');
    is($xlines[  3], q{<!DOCTYPE.delta.PUBLIC."public"."system">},                    'Test-DM-0050');
    is($xlines[  4], q{%n},                                                           'Test-DM-0060');
    is($xlines[  5], q{<delta>},                                                      'Test-DM-0070');
    is($xlines[  6], q{%n..},                                                         'Test-DM-0080');
    is($xlines[  7], q{<dim.alter="511">},                                            'Test-DM-0090');
    is($xlines[  8], q{%n....},                                                       'Test-DM-0100');
    is($xlines[  9], q{<gamma.parm1="abc".parm2="def"./>},                            'Test-DM-0110');
    is($xlines[ 10], q{%n....},                                                       'Test-DM-0120');
    is($xlines[ 11], q{<beta>},                                                       'Test-DM-0130');
    is($xlines[ 12], q{car},                                                          'Test-DM-0140');
    is($xlines[ 13], q{</beta>},                                                      'Test-DM-0150');
    is($xlines[ 14], q{%n....},                                                       'Test-DM-0160');
    is($xlines[ 15], q{<alpha>},                                                      'Test-DM-0170');
    is($xlines[ 16], q{},                                                             'Test-DM-0180');
    is($xlines[ 17], q{<?tt.dat?>},                                                   'Test-DM-0190');
    is($xlines[ 18], q{},                                                             'Test-DM-0200');
    is($xlines[ 19], q{</alpha>},                                                     'Test-DM-0210');
    is($xlines[ 20], q{%n....},                                                       'Test-DM-0220');
    is($xlines[ 21], q{<epsilon>},                                                    'Test-DM-0230');
    is($xlines[ 22], q{%n......},                                                     'Test-DM-0240');
    is($xlines[ 23], q{<!--.remark.-->},                                              'Test-DM-0250');
    is($xlines[ 24], q{%n....},                                                       'Test-DM-0260');
    is($xlines[ 25], q{</epsilon>},                                                   'Test-DM-0270');
    is($xlines[ 26], q{%n....},                                                       'Test-DM-0280');
    is($xlines[ 27], q{<omega.type1="a".type2="b".type3="c">},                        'Test-DM-0290');
    is($xlines[ 28], q{fkfdsjhkjhkj},                                                 'Test-DM-0300');
    is($xlines[ 29], q{</omega>},                                                     'Test-DM-0310');
    is($xlines[ 30], q{%n..},                                                         'Test-DM-0320');
    is($xlines[ 31], q{</dim>},                                                       'Test-DM-0330');
    is($xlines[ 32], q{%n..},                                                         'Test-DM-0340');
    is($xlines[ 33], q{<kappa>},                                                      'Test-DM-0350');
    is($xlines[ 34], q{dsk\\njfh....yy},                                              'Test-DM-0360');
    is($xlines[ 35], q{</kappa>},                                                     'Test-DM-0370');
    is($xlines[ 36], q{%n..},                                                         'Test-DM-0380');
    is($xlines[ 37], q{<test>},                                                       'Test-DM-0390');
    is($xlines[ 38], q{u.&amp;.&lt;.&gt;.&amp;amp;.&amp;gt;.&amp;lt;.Z},              'Test-DM-0400');
    is($xlines[ 39], q{</test>},                                                      'Test-DM-0410');
    is($xlines[ 40], q{%n..},                                                         'Test-DM-0420');
    is($xlines[ 41], q{<test1>},                                                      'Test-DM-0430');
    is($xlines[ 42], q{},                                                             'Test-DM-0440');
    is($xlines[ 43], q{</test1>},                                                     'Test-DM-0450');
    is($xlines[ 44], q{%n..},                                                         'Test-DM-0460');
    is($xlines[ 45], q{<one>},                                                        'Test-DM-0470');
    is($xlines[ 46], q{%n....},                                                       'Test-DM-0480');
    is($xlines[ 47], q{<two>},                                                        'Test-DM-0490');
    is($xlines[ 48], q{%n......},                                                     'Test-DM-0500');
    is($xlines[ 49], q{<three>},                                                      'Test-DM-0510');
    is($xlines[ 50], q{%n........},                                                   'Test-DM-0520');
    is($xlines[ 51], q{<four>},                                                       'Test-DM-0530');
    is($xlines[ 52], q{},                                                             'Test-DM-0540');
    is($xlines[ 53], q{</four>},                                                      'Test-DM-0550');
    is($xlines[ 54], q{%n......},                                                     'Test-DM-0560');
    is($xlines[ 55], q{</three>},                                                     'Test-DM-0570');
    is($xlines[ 56], q{%n....},                                                       'Test-DM-0580');
    is($xlines[ 57], q{</two>},                                                       'Test-DM-0590');
    is($xlines[ 58], q{%n....},                                                       'Test-DM-0600');
    is($xlines[ 59], q{<one-and-a-half.yo="man".ding="dong"./>},                      'Test-DM-0610');
    is($xlines[ 60], q{%n..},                                                         'Test-DM-0620');
    is($xlines[ 61], q{</one>},                                                       'Test-DM-0630');
    is($xlines[ 62], q{%n..},                                                         'Test-DM-0640');
    is($xlines[ 63], q{<root>},                                                       'Test-DM-0650');
    is($xlines[ 64], q{..test1.\\n.\\t.\\.\\\\.\\\\\\.a%tb...test2},                  'Test-DM-0660');
    is($xlines[ 65], q{</root>},                                                      'Test-DM-0670');
    is($xlines[ 66], q{%n},                                                           'Test-DM-0680');
    is($xlines[ 67], q{</delta>},                                                     'Test-DM-0690');
    is($xlines[ 68], q{%n},                                                           'Test-DM-0700');
}

{
    my (undef, @xlines) = get_xml_list('XML::MinWriter', 'NL');

    is(scalar(@xlines),  69,                                                          'Test-NL-0010 - Number of elements is correct');

    is($xlines[  0], q{},                                                             'Test-NL-0020');
    is($xlines[  1], q{<?xml.version="1.0".encoding="iso-8859-1"?>},                  'Test-NL-0030');
    is($xlines[  2], q{%n},                                                           'Test-NL-0040');
    is($xlines[  3], q{<!DOCTYPE.delta.PUBLIC."public"."system">},                    'Test-NL-0050');
    is($xlines[  4], q{%n},                                                           'Test-NL-0060');
    is($xlines[  5], q{<delta%n>},                                                    'Test-NL-0070');
    is($xlines[  6], q{},                                                             'Test-NL-0080');
    is($xlines[  7], q{<dim.alter="511"%n>},                                          'Test-NL-0090');
    is($xlines[  8], q{},                                                             'Test-NL-0100');
    is($xlines[  9], q{<gamma.parm1="abc".parm2="def"%n./>},                          'Test-NL-0110');
    is($xlines[ 10], q{},                                                             'Test-NL-0120');
    is($xlines[ 11], q{<beta%n>},                                                     'Test-NL-0130');
    is($xlines[ 12], q{car},                                                          'Test-NL-0140');
    is($xlines[ 13], q{</beta%n>},                                                    'Test-NL-0150');
    is($xlines[ 14], q{},                                                             'Test-NL-0160');
    is($xlines[ 15], q{<alpha%n>},                                                    'Test-NL-0170');
    is($xlines[ 16], q{},                                                             'Test-NL-0180');
    is($xlines[ 17], q{<?tt.dat?>},                                                   'Test-NL-0190');
    is($xlines[ 18], q{},                                                             'Test-NL-0200');
    is($xlines[ 19], q{</alpha%n>},                                                   'Test-NL-0210');
    is($xlines[ 20], q{},                                                             'Test-NL-0220');
    is($xlines[ 21], q{<epsilon%n>},                                                  'Test-NL-0230');
    is($xlines[ 22], q{},                                                             'Test-NL-0240');
    is($xlines[ 23], q{<!--.remark.-->},                                              'Test-NL-0250');
    is($xlines[ 24], q{},                                                             'Test-NL-0260');
    is($xlines[ 25], q{</epsilon%n>},                                                 'Test-NL-0270');
    is($xlines[ 26], q{},                                                             'Test-NL-0280');
    is($xlines[ 27], q{<omega.type1="a".type2="b".type3="c"%n>},                      'Test-NL-0290');
    is($xlines[ 28], q{fkfdsjhkjhkj},                                                 'Test-NL-0300');
    is($xlines[ 29], q{</omega%n>},                                                   'Test-NL-0310');
    is($xlines[ 30], q{},                                                             'Test-NL-0320');
    is($xlines[ 31], q{</dim%n>},                                                     'Test-NL-0330');
    is($xlines[ 32], q{},                                                             'Test-NL-0340');
    is($xlines[ 33], q{<kappa%n>},                                                    'Test-NL-0350');
    is($xlines[ 34], q{dsk\\njfh....yy},                                              'Test-NL-0360');
    is($xlines[ 35], q{</kappa%n>},                                                   'Test-NL-0370');
    is($xlines[ 36], q{},                                                             'Test-NL-0380');
    is($xlines[ 37], q{<test%n>},                                                     'Test-NL-0390');
    is($xlines[ 38], q{u.&amp;.&lt;.&gt;.&amp;amp;.&amp;gt;.&amp;lt;.Z},              'Test-NL-0400');
    is($xlines[ 39], q{</test%n>},                                                    'Test-NL-0410');
    is($xlines[ 40], q{},                                                             'Test-NL-0420');
    is($xlines[ 41], q{<test1%n>},                                                    'Test-NL-0430');
    is($xlines[ 42], q{},                                                             'Test-NL-0440');
    is($xlines[ 43], q{</test1%n>},                                                   'Test-NL-0450');
    is($xlines[ 44], q{},                                                             'Test-NL-0460');
    is($xlines[ 45], q{<one%n>},                                                      'Test-NL-0470');
    is($xlines[ 46], q{},                                                             'Test-NL-0480');
    is($xlines[ 47], q{<two%n>},                                                      'Test-NL-0490');
    is($xlines[ 48], q{},                                                             'Test-NL-0500');
    is($xlines[ 49], q{<three%n>},                                                    'Test-NL-0510');
    is($xlines[ 50], q{},                                                             'Test-NL-0520');
    is($xlines[ 51], q{<four%n>},                                                     'Test-NL-0530');
    is($xlines[ 52], q{},                                                             'Test-NL-0540');
    is($xlines[ 53], q{</four%n>},                                                    'Test-NL-0550');
    is($xlines[ 54], q{},                                                             'Test-NL-0560');
    is($xlines[ 55], q{</three%n>},                                                   'Test-NL-0570');
    is($xlines[ 56], q{},                                                             'Test-NL-0580');
    is($xlines[ 57], q{</two%n>},                                                     'Test-NL-0590');
    is($xlines[ 58], q{},                                                             'Test-NL-0600');
    is($xlines[ 59], q{<one-and-a-half.yo="man".ding="dong"%n./>},                    'Test-NL-0610');
    is($xlines[ 60], q{},                                                             'Test-NL-0620');
    is($xlines[ 61], q{</one%n>},                                                     'Test-NL-0630');
    is($xlines[ 62], q{},                                                             'Test-NL-0640');
    is($xlines[ 63], q{<root%n>},                                                     'Test-NL-0650');
    is($xlines[ 64], q{..test1.\\n.\\t.\\.\\\\.\\\\\\.a%tb...test2},                  'Test-NL-0660');
    is($xlines[ 65], q{</root%n>},                                                    'Test-NL-0670');
    is($xlines[ 66], q{},                                                             'Test-NL-0680');
    is($xlines[ 67], q{</delta%n>},                                                   'Test-NL-0690');
    is($xlines[ 68], q{%n},                                                           'Test-NL-0700');
}

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

    is(scalar(@xlines), 8,                                                                       'Test-0500: Number of lines in XML correct');

    is($xlines[ 0], q{<?xml version="1.0" encoding="iso-8859-1"?>},                              'Test-0510: XML-Declaration correct');
    is($xlines[ 1], q{<!DOCTYPE abc SYSTEM "test">},                                             'Test-0520: Doctype correct');
    is($xlines[ 2], q{<abc},                                                                     'Test-0530: Main opening tag correct');
    is($xlines[ 3], q{><smurf var1="blue" var2="white"},                                         'Test-0540: Smurf opening closing tag correct');
    is($xlines[ 4], q{ /><dim alter="511"},                                                      'Test-0550: Opening dim tag correct');
    is($xlines[ 5], q{>car<?high way?><!-- this is a comment --></dim},                          'Test-0570: Comment plus closing dim tag correct');
    is($xlines[ 6], q{></abc},                                                                   'Test-0580: Main closing tag correct');
    is($xlines[ 7], q{>},                                                                        'Test-0590: Final > correct');
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

sub get_xml_list {
    my ($module, $mode) = @_;

    open my $fh, '>', \my $xml or die "Error-0010: Can't open > xml because $!";

    my $wrt;
    if ($mode eq 'DM') {
        $wrt = $module->new(OUTPUT => $fh, DATA_MODE => 1, DATA_INDENT => 2);
    }
    elsif ($mode eq 'LM') {
        $wrt = $module->new(OUTPUT => $fh, LINE_MODE => 1, DATA_INDENT => 2);
    }
    elsif ($mode eq 'NL') {
        $wrt = $module->new(OUTPUT => $fh, NEWLINES => 1);
    }
    elsif ($mode eq 'ZZ') {
        $wrt = $module->new(OUTPUT => $fh);
    }
    else {
        die "Error-0010: Can't identify mode '$mode'";
    }

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
    $wrt->characters('dsk\\njfh  ');
    $wrt->characters('  yy');
    $wrt->endTag('kappa');
    $wrt->startTag('test');
    $wrt->characters('u & < > &amp; &gt; &lt; Z');
    $wrt->endTag('test');
    $wrt->startTag('test1');
    $wrt->endTag('test1');
    $wrt->startTag('one');
    $wrt->startTag('two');
    $wrt->startTag('three');
    $wrt->startTag('four');
    $wrt->endTag('four');
    $wrt->endTag('three');
    $wrt->endTag('two');
    $wrt->emptyTag('one-and-a-half', yo => 'man', ding => 'dong');
    $wrt->endTag('one');
    $wrt->startTag('root');
    $wrt->characters("  test1 \\n \\t \\ \\\\ \\\\\\ a\tb ");
    $wrt->characters("  test2");
    $wrt->endTag('root');
    $wrt->endTag('delta');

    $wrt->end;
    close $fh;

    my $orig = $xml;

    $xml =~ s{\n}"%n"xmsg;
    $xml =~ s{ [ ] }'.'xmsg;
    $xml =~ s{\t}"%t"xmsg;

    return $orig, split(m{(< [^>]* >)}xms, $xml);
}
