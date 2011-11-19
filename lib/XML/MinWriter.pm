package XML::MinWriter;

use strict;
use warnings;

use Carp;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw();

our @EXPORT = qw();

our $VERSION = '0.02';

sub new {
    shift;
    my $self = {};
    bless $self;

    my %hash = (OUTPUT => \*STDOUT, LINE_MODE => 0, DATA_MODE => 0, DATA_INDENT => 0, NEWLINES => 0, APOS => 0, @_);

    $self->{OUTPUT}      = $hash{OUTPUT};
    $self->{LINE_MODE}   = $hash{LINE_MODE};
    $self->{DATA_MODE}   = $hash{DATA_MODE};
    $self->{DATA_INDENT} = $hash{DATA_INDENT};
    $self->{NEWLINES}    = $hash{NEWLINES};
    $self->{DELIM}       = $hash{APOS} ? qq{'} : qq{"};
    $self->{LEVEL}       = 0;
    $self->{PYX_TYPE}    = '';
    $self->{PYX_TAG}     = '';
    $self->{PYX_ATTR}    = [];
    $self->{PRV_OC}      = '';

    if ($self->{LINE_MODE}) {
        $self->{NEWLINES} = 0;
    }

    return $self;
}

sub xmlDecl {
    my $self = shift;
    my ($encoding, $standalone) = @_;

    $self->flush_pyx;

    my @attrs = ('version', '1.0');
    if (defined $encoding) {
        push @attrs, 'encoding', $encoding;
    }
    if (defined $standalone) {
        push @attrs, 'standalone', $standalone;
    }

    $self->emitLine('<?', '?>', 'D', 'xml', @attrs);
}

sub doctype {
    my $self = shift;

    $self->flush_pyx;

    $self->emitDoc(@_);
}

sub comment {
    my $self = shift;

    $self->flush_pyx;

    $self->emitComment(@_);
}

sub procInst {
    my $self = shift;

    $self->flush_pyx;

    $self->emitLine('<?', '?>', 'D', @_);
}

sub pi {
    my $self = shift;

    $self->flush_pyx;

    $self->emitLine('<?', '?>', 'S', @_);
}

sub startTag {
    my $self = shift;

    $self->flush_pyx;

    $self->emitLine('<', '>', 'D', @_);
}

sub emptyTag {
    my $self = shift;

    $self->flush_pyx;

    $self->emitLine('<', '/>', 'D', @_);
}

sub endTag {
    my $self = shift;

    $self->flush_pyx;

    $self->emitLine('</', '>', 'D', @_);
}

sub characters {
    my $self = shift;

    $self->flush_pyx;

    $self->emitChars(@_);
}

sub dataElement {
    my $self = shift;

    my ($name, $data) = (shift, shift);

    $self->flush_pyx;

    $self->emitLine('<', '>', 'D', $name, @_);
    $self->emitChars($data);
    $self->emitLine('</', '>', 'D', $name);
}

sub write_pyx {
    my $self = shift;

    my $instr = shift;

    if ($instr eq '') {
        croak "Found empty string in write_pyx()";
    }

    my $code = substr($instr, 0, 1);
    my $text = substr($instr, 1);

    if ($code eq '(') {
        $self->flush_pyx;
        $self->{PYX_TYPE} = '(';
        $self->{PYX_TAG}  = $text;
        $self->{PYX_ATTR} = [];
    }
    elsif ($code eq 'A') {
        my ($key, $val) = $text =~ m{\A (\S+) \s+ (.*) \z}xms
          or croak "Can't parse (key, val) [code = 'A'] in '$text' in write_pyx()";
        push @{$self->{PYX_ATTR}}, $key, $val;
    }
    elsif ($code eq ')') {
        $self->flush_pyx;
        $self->emitLine('</', '>', 'D', $text);
    }
    elsif ($code eq '-') {
        $self->flush_pyx;
        $text =~ s{\\(.)}{
          $1 eq '\\' ? "\\" :
          $1 eq 'n'  ? "\n" :
          $1 eq 't'  ? "\t" :
          "\\".$1}xmsge;
        $self->emitChars($text);
    }
    elsif ($code eq '?') {
        $self->flush_pyx;
        my ($key, $val) = $text =~ m{\A (\S+) \s+ (.*) \z}xms
          or croak "Can't parse (key, val) [code = '?'] in '$text' in write_pyx()";
        $self->emitLine('<?', '?>', 'S', $key, $val);
    }
    elsif ($code eq '#') {
        $self->flush_pyx;
        $text =~ s{\\(.)}{
          $1 eq '\\' ? "\\" :
          $1 eq 'n'  ? "\n" :
          $1 eq 't'  ? "\t" :
          "\\".$1}xmsge;
        $self->emitComment($text);
    }
    else {
        croak "Invalid code = '$code' in write_pyx()";
    }
}

sub end {
    my $self = shift;
    $self->flush_pyx;

    unless ($self->{LEVEL} == 0) {
        croak "XML terminated with open tags (Level = ", $self->{LEVEL}, ")";
    }
}

sub flush_pyx {
    my $self = shift;

    if ($self->{PYX_TYPE} eq '(') {
        $self->emitLine('<', '>', 'D', $self->{PYX_TAG}, @{$self->{PYX_ATTR}});
    }

    $self->{PYX_TYPE}    = '';
    $self->{PYX_TAG}     = '';
    $self->{PYX_ATTR}    = [];
}

sub emitDoc {
    my $self = shift;
    my ($name, $publicId, $systemId) = @_;

    $self->ws_before('<!', '>');

    repl_quot($name);
    print {$self->{OUTPUT}} qq{<!DOCTYPE $name};
    if (defined $publicId) {
        repl_quot($publicId);
        print {$self->{OUTPUT}} qq{ PUBLIC }, $self->{DELIM}, $publicId, $self->{DELIM};
        if (defined $systemId) {
            repl_quot($systemId);
            print {$self->{OUTPUT}} qq{ }, $self->{DELIM}, $systemId, $self->{DELIM};
        }
    }
    elsif (defined $systemId) {
        repl_quot($systemId);
        print {$self->{OUTPUT}} qq{ SYSTEM }, $self->{DELIM}, $systemId, $self->{DELIM};
    }

    print {$self->{OUTPUT}} qq{\n} if $self->{NEWLINES};
    print {$self->{OUTPUT}} qq{>};

    $self->ws_after('<!', '>');
}

sub emitComment {
    my $self = shift;
    my ($data) = @_;

    $self->ws_before('<!--', '-->');

    $data =~ s{-->}'==>'xmsg;
    print {$self->{OUTPUT}} qq{<!-- $data -->};

    $self->ws_after('<!--', '-->');
}

sub emitLine {
    my $self = shift;
    my ($open, $close, $mode) = (shift, shift, shift);
    my $name = shift;

    if ($open eq '</' and $close eq '>') {
        $self->{LEVEL}--;
        if ($self->{LEVEL} < 0) {
            croak "Level underflow for end-tag </$name>";
        }
    }

    $self->ws_before($open, $close);

    repl_quot($name);
    print {$self->{OUTPUT}} $open, $name;

    if ($mode eq 'D') {
        while (1) {
            my ($attr, $value) = (shift, shift);
            last unless defined($attr) and defined($value);

            repl_quot($attr, $value);
            print {$self->{OUTPUT}} qq{ $attr=}, $self->{DELIM}, $value, $self->{DELIM};
        }
    }
    else {
        my $text = shift;
        if (defined $text) {
            repl_nrm($text);
            print {$self->{OUTPUT}} qq{ }, $text;
        }
    }

    print {$self->{OUTPUT}} qq{\n} if $self->{NEWLINES};
    print {$self->{OUTPUT}} qq{ }  if !$self->{NEWLINES} and $close eq '/>';
    print {$self->{OUTPUT}} $close;

    $self->ws_after($open, $close);

    if ($open eq '<' and $close eq '>') {
        $self->{LEVEL}++;
    }
}

sub emitChars {
    my $self = shift;
    my $text = shift;

    repl_nrm($text);

    if ($self->{LEVEL} > 0) {
        $self->ws_before('<T', 'T>');
        print {$self->{OUTPUT}} $text;
        $self->ws_after('<T', 'T>');
    }
}

sub ws_before {
    my $self = shift;
    my ($open, $close) = (shift, shift);

    my $curr_oc = $open.'*'.$close;

    if ($self->{DATA_MODE}) {
        if ((($curr_oc eq '<*>' or $curr_oc eq '<*/>' or $curr_oc eq '<!--*-->') and $self->{LEVEL} > 0)
        or  ($curr_oc eq '</*>' and ($self->{PRV_OC} eq '</*>' or $self->{PRV_OC} eq '<*/>' or $self->{PRV_OC} eq '<!--*-->'))) {
            print {$self->{OUTPUT}} qq{\n}, qq{ } x ($self->{DATA_INDENT} * $self->{LEVEL});
        }
    }
    elsif ($self->{LINE_MODE}) {
        print {$self->{OUTPUT}} qq{ } x ($self->{DATA_INDENT} * $self->{LEVEL});
    }

    $self->{PRV_OC} = $curr_oc;
}

sub ws_after {
    my $self = shift;
    my ($open, $close) = (shift, shift);

    my $curr_oc = $open.'*'.$close;

    if ($self->{DATA_MODE}) {
    }
    elsif ($self->{LINE_MODE}) {
        print {$self->{OUTPUT}} qq{\n};
    }

    if ($self->{NEWLINES}) {
        if ($self->{LEVEL} == 0 and $curr_oc eq '</*>') {
            print {$self->{OUTPUT}} qq{\n};
        }
    }
    elsif ($self->{LEVEL} == 0 and !$self->{LINE_MODE}) {
        if ($curr_oc eq '<!*>'
        or  $curr_oc eq '<?*?>'
        or  $curr_oc eq '</*>') {
            print {$self->{OUTPUT}} qq{\n};
        }
    }
}

sub repl_nrm {
    for my $w (@_) {
        $w =~ s{&}'&amp;'xmsg;
        $w =~ s{<}'&lt;'xmsg;
        $w =~ s{>}'&gt;'xmsg;
    }
}

sub repl_quot {
    for my $w (@_) {
        $w =~ s{&}'&amp;'xmsg;
        $w =~ s{<}'&lt;'xmsg;
        $w =~ s{>}'&gt;'xmsg;

        $w =~ s{"}'&quot;'xmsg;
        $w =~ s{'}'&apos;'xmsg;
    }
}

1;

__END__

=head1 NAME

XML::MinWriter - Perl extension for writing XML.

=head1 SYNOPSIS

Here is a simple example of how to use XML::MinWriter:

  use XML::MinWriter;

  open my $fh, '>', \my $xml or die $!;
  my $wrt = XML::MinWriter->new(OUTPUT => $fh, LINE_MODE => 1, DATA_INDENT => 2);

  $wrt->xmlDecl('iso-8859-1');
  $wrt->startTag('alpha');
  $wrt->startTag('beta', p1 => 'dat1', p2 => 'dat2');
  $wrt->characters('abcdefg');
  $wrt->endTag('beta');
  $wrt->write_pyx('(gamma');
  $wrt->write_pyx('-hijklmn');
  $wrt->write_pyx(')gamma');
  $wrt->endTag('alpha');

  $wrt->end;
  close $fh;

  print "The XML generated is as follows:\n\n";
  print $xml, "\n";

...and this is the output:

  <?xml version="1.0" encoding="iso-8859-1"?>
  <alpha>
    <beta p1="dat1" p2="dat2">
      abcdefg
    </beta>
    <gamma>
      hijklmn
    </gamma>
  </alpha>

Here is the same example, but with DATA_MODE => 1 instead of LINE_MODE => 1

  use XML::MinWriter;

  open my $fh, '>', \my $xml or die $!;
  my $wrt = XML::MinWriter->new(OUTPUT => $fh, DATA_MODE => 1, DATA_INDENT => 2);

  $wrt->xmlDecl('iso-8859-1');
  $wrt->startTag('alpha');
  $wrt->startTag('beta', p1 => 'dat1', p2 => 'dat2');
  $wrt->characters('abcdefg');
  $wrt->endTag('beta');
  $wrt->write_pyx('(gamma');
  $wrt->write_pyx('-hijklmn');
  $wrt->write_pyx(')gamma');
  $wrt->endTag('alpha');

  $wrt->end;
  close $fh;

  print "The XML generated is as follows:\n\n";
  print $xml, "\n";

...and this is the output:

  <?xml version="1.0" encoding="iso-8859-1"?>
  <alpha>
    <beta p1="dat1" p2="dat2">abcdefg</beta>
    <gamma>hijklmn</gamma>
  </alpha>

=head1 DESCRIPTION

XML::MinWriter is a module to write XML. It is largely compatible to XML::Writer, but XML::MinWriter
does not perform checks whether the XML is well formed. There is also additional support for writing XML
from a PYX data source (For example, both modules XML::TiePYX and XML::Reader can produce PYX which can
then be fed into XML::MinWriter to generate XML).

=head2 Object creation

To create an XML::MinWriter object, the following syntax is used:

  my $wrt = XML::MinWriter->new(OUTPUT => $fh, LINE_MODE => 1, DATA_INDENT => 2);

One or more of the following options can be used (those options are largely compatible
with XML::Writer):

=over

=item option OUTPUT =>

Option OUTPUT => $fh determines that the XML is written to filehandle $fh, the default is OUTPUT => \*STDOUT.

=item option LINE_MODE =>

The option LINE_MODE => 0|1 is a true or false value; if this parameter is present and its value is true (1), then
XML::MinWriter will enter a special line mode, inserting newlines automatically around elements. The default is
LINE_MODE => 0.

=item option DATA_MODE =>

The option DATA_MODE => 0|1 is a true or false value; if this parameter is present and its value is true (1), then
XML::MinWriter will enter a special Data mode, to be compatible with XML::Writer. The default is
DATA_MODE => 0.

=item option DATA_INDENT =>

Represents the indent step for elements in data mode (it will be ignored when not in data mode). The default is
DATA_INDENT => 0.

=item option NEWLINES =>

The option NEWLINES => 0|1 is a true or false value; if this parameter is present and its value is true (1), then
XML::MinWriter will insert an extra newline before the closing delimiter of start, end, and empty tags to guarantee
that the document does not end up as a single, long line. If the parameter is false (0), then the module will not
insert the newlines. The default is NEWLINES => 0.

=item option APOS =>

Determines whether apostrophes or quotes are used to write attribute values. APOS => 1 uses apostrophes,
APOS => 0 uses quotes. The default is APOS => 0. For example, with APOS => 0, attributes are written with
quotes as follows:

  <test attr1="t1" attr2="t2">

With APOS => 1, attributes are written with apostrophes as follows:

  <test attr1='t1' attr2='t2'>

=back

=head2 Methods

The following methods are compatible with XML::Writer:

=over

=item startTag ($name [, $aname1 => $value1, ...])

The startTag() method creates a start tag in the XML output. Given the following call:

  $wrt->startTag('st', attr1 => 'v1', attr2 => 'v2');

then the following tag will be written to the XML output file:

  <st attr1="v1" attr2="v2">

Of course, the attributes (attr1 => 'v1', attr2 => 'v2') are optional, so a call to startTag() with a simple
argument:

  $wrt->startTag('st');

produces the following tag in the XML output file:

  <st>

=item characters ($data)

The characters() method simply writes the text to the XML output file, with the additional transformation of the
special characters '<', '>' and '&'. For example, the following call:

  $wrt->characters('abc < > & def');

produces the following XML output:

  abc &lt; &gt; &amp; def

=item endTag ($name)

The endTag() method creates an end tag in the XML output. Given the following call:

  $wrt->endTag('st');

then the following tag will be written to the XML output file:

  </st>

=item dataElement ($name, $data [, $aname1 => $value1, ...])

The dataElement() method prints an entire element containing only character data. The following call:

  $wrt->dataElement('item', 'text123', attr1 => 'v1', attr2 => 'v2');

is equivalent to the following sequence:

  $wrt->startTag('item', attr1 => 'v1', attr2 => 'v2');
  $wrt->characters('text123');
  $wrt->endTag('item');

and produces the following XML output:

  <item attr1="v1" attr2="v2">
    text123
  </item>

=item emptyTag ($name [, $aname1 => $value1, ...])

The emptyTag() method creates an empty tag in the XML output. Given the following call:

  $wrt->emptyTag('st', attr1 => 'v1', attr2 => 'v2');

then the following tag will be written to the XML output file:

  <st attr1="v1" attr2="v2" />

Of course, the attributes (attr1 => 'v1', attr2 => 'v2') are optional, so a call to emptyTag() with a simple
argument:

  $wrt->emptyTag('st');

produces the following tag in the XML output file:

  <st />

=item doctype ($name, [$publicId, $systemId])

The doctype() method adds a DOCTYPE declaration to an XML document. For example, the following call:

  $wrt->doctype('delta', 'p1', 's1');

produces the following XML output:

  <!DOCTYPE delta PUBLIC "p1" "s1">

You can also pass $publicId = undef to emit $systemId only:

  $wrt->doctype('delta', undef, 's1');

That produces the following XML output:

  <!DOCTYPE delta SYSTEM "s1">

Or you can leave out $publicId and $systemId alltogether:

  $wrt->doctype('delta');

That produces the following XML output:

  <!DOCTYPE delta>

=item comment ($text)

The comment() method adds a comment to the XML output. The following call:

  $wrt->comment('This is a comment');

will produce the following XML output:

  <!-- This is a comment -->

=item pi ($target [, $data])

The pi() method adds a processing instruction to an XML document. The following call:

  $wrt->pi('xml-stylesheet', 'href="style.css" type="text/css"');

will produce the following XML output:

  <?xml-stylesheet href="style.css" type="text/css"?>

=item end ()

The end() method terminates writing to the XML output. It should be the last
call before closing the XML output file.

=back

There are two new methods that are not compatible with XML::Writer:

=over

=item procInst ($name [, $aname1 => $value1, ...])

The procInst() method adds a processing instruction to an XML document. It is very
similar to the pi() method, however, the parameters are passed differently. The
following call:

  $wrt->procInst('xml-stylesheet', href => 'style.css', type => 'text/css');

will produce the following XML output:

  <?xml-stylesheet href="style.css" type="text/css"?>

=item write_pyx ($pyx_data)

The write_pyx() method writes the XML for the given PYX data.

=back

=head2 Pyx

Pyx is a line-oriented text format to represent XML. The first character of a line in Pyx represents the
type. This first character type can be:

  '(' => a Start tag,          '(item'         translates into '<item>'
  ')' => an End  tag,          ')item'         translates into '</item>'
  '-' => Character data,       '-data'         translates into 'data'
  'A' => Attributes,           'Aattr v1'      translates into '<... attr="v1">'
  '?' => Process Instructions, '?xml dat="p1"' translates into '<?xml dat="p1"?>'
  '#' => Comments,             '#remark'       translates into '<!-- remark -->'

=head1 EXAMPLES

=head2 Example using Pyx

For example the following PYX code:

  use XML::MinWriter;

  open my $fh, '>', \my $xml or die $!;
  my $wrt = XML::MinWriter->new(OUTPUT => $fh, LINE_MODE => 1, DATA_INDENT => 2);

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

  print "The XML generated is as follows:\n\n";
  print $xml, "\n";

...generates the following XML:

  <?xml version="1.0" encoding="iso-8859-1"?>
  <data>
    <item attr1="p1" attr2="p2">
      line
    </item>
    <level>
      <!-- remark -->
    </level>
  </data>

=head2 Example using XML::Reader

A sample code fragment that uses XML::Reader together with XML::MinWriter:

  use XML::Reader;
  use XML::MinWriter;

  my $line = q{
  <data>
    <order>
      <database>
        <customer name="aaa" >one</customer>
        <customer name="bbb" >two</customer>
        <other>iuertyieruyt</other>
        <customer name="ccc" >three</customer>
        <customer name="ddd" >four</customer>
      </database>
    </order>
  </data>
  };

  my $rdr = XML::Reader->new(\$line, {
              using => '/data/order/database/customer',
              mode  => 'pyx',
            });

  open my $fh, '>', \my $xml or die "Error-0010: Can't open > xml because $!";
  my $wrt = XML::MinWriter->new(OUTPUT => $fh, DATA_MODE => 1, DATA_INDENT => 2);

  $wrt->xmlDecl('iso-8859-1');
  $wrt->doctype('delta', 'public', 'system');
  $wrt->startTag('delta');

  while ($rdr->iterate) {
      $wrt->write_pyx($rdr->pyx);
  }

  $wrt->endTag('delta');
  $wrt->end;

  close $fh;

  print $xml, "\n";

This is the resulting XML:

  <?xml version="1.0" encoding="iso-8859-1"?>
  <!DOCTYPE delta PUBLIC "public" "system">
  <delta>
    <customer name="aaa">one</customer>
    <customer name="bbb">two</customer>
    <customer name="ccc">three</customer>
    <customer name="ddd">four</customer>
  </delta>

=head1 AUTHOR

Klaus Eichner, October 2011

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Klaus Eichner

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<XML::TiePYX>,
L<XML::Reader>,
L<XML::Writer>.

=cut
