use strict;
use warnings;
use 5.008;

use Module::Build;

Module::Build->new(
  module_name        => 'XML::MinWriter',
  license            => 'perl',
  configure_requires => { 'Module::Build' => 0.30 },
  dist_abstract      => 'Perl extension for writing XML',
)->create_build_script;
