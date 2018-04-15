NAME
====

DBIx::NamedQueries - a predefined sql framework for Perl6

SYNOPSIS
========

Build a class for yout predefined SQL-Statements

    use Bailador;
    use Bailador::Plugin::NamedQueries;
     
    get '/' => sub {
        template 'index.html', _html_render_fix {
            result  => self.plugins.get('NamedQueries').read: 'user/select'
        }
    }

    baile();

INSTALLATION
============

    > zef install DBIx::NamedQueries

DESCRIPTION
===========

This plugin makes it very easy to create [Dancer2](Dancer2) applications that interface with databases. It automatically exports the keyword `schema` which returns a [DBIx::Class::Schema](DBIx::Class::Schema) object. It also exports the keywords `resultset` and `rset`. You just need to configure your database connection information. For performance, schema objects are cached in memory and are lazy loaded the first time they are accessed.

This plugin is a thin wrapper around [DBIx::NamedQueries](DBIx::NamedQueries).

CONFIGURATION
=============

Configuration can be done in your [Dancer2](Dancer2) config file. This is a minimal example. It defines one database named `default`:

    plugins:
      NamedQueries:
        divider: '/'
        namespace: R3Scheduler::Db::Queries
        handle:
          type: DBIish
          driver: SQLite
          database: test.sqlite3

FUNCTIONS
=========

read
----

read
----

write
-----

write
-----

create
------

insert
------

select
------

object
------

dispose
-------

that
----

TODO
====

more documentation

SEE ALSO
========

[https://github.com/perl6/DBIish](https://github.com/perl6/DBIish), [https://modules.perl6.org/dist/DBIx::NamedQueries](https://modules.perl6.org/dist/DBIx::NamedQueries)

AUTHOR
======

Mario Zieschang <mziescha [at] cpan.org>

COPYRIGHT AND LICENSE
=====================

Copyright 2018 Mario Zieschang

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

