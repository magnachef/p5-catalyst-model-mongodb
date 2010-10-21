use inc::Module::Install 0.64;

name 'Catalyst-Model-MongoDB';

perl_version '5.008';
license 'perl';
all_from 'lib/Catalyst/Model/MongoDB.pm';

requires 'Catalyst::Runtime' => 5.80;
requires 'MongoDB';

test_requires 'Test::More' => '0.47';

WriteAll;
