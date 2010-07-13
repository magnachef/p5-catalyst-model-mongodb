use inc::Module::Install 0.64;

name 'Catalyst-Model-MongoDB';

perl_version '5.008';
license 'perl';
all_from 'lib/Catalyst/Model/MongoDB.pm';

requires 'Catalyst';
requires 'MongoDB';

WriteAll;
