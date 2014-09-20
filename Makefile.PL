use 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'XML::MinWriter',
    VERSION_FROM      => 'lib/XML/MinWriter.pm', # finds $VERSION
    PREREQ_PM         => { 'XML::Writer' => 0 }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/XML/MinWriter.pm', # retrieve abstract from module
       AUTHOR         => 'Klaus Eichner <klaus03@gmail.com>') : ()),
    (eval { ExtUtils::MakeMaker->VERSION(6.46) } ? (META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
               type => 'git',
               url  => 'https://github.com/klaus03/XML-MinWriter.git',
               web  => 'https://github.com/klaus03/XML-MinWriter',
           }
        }})
        : ()
    ),
);
