use v6.c;
use Bailador::Plugins;
use DBIx::NamedQueries;

class Bailador::Plugin::NamedQueries:ver<0.001000> is Bailador::Plugin {

    has DBIx::NamedQueries $!named_queries;
    
    method !init () {
        $!named_queries = DBIx::NamedQueries.new(
            divider   => %.config{'divider'},
            namespace => %.config{'namespace'},
            handle    => %.config{'handle'},
        );
    }

    multi method read (Str:D $context) {
        self!init unless $!named_queries;
        return $!named_queries.read: $context;
    }

    multi method read (Str:D $context, Hash:D $params) {
        self!init unless $!named_queries;
        return $!named_queries.read: $context, $params;
    }

    multi method write (Str:D $context) {
        self!init unless $!named_queries;
        return $!named_queries.write: $context;
    }

    multi method write (Str:D $context, Hash:D $params) {
        self!init unless $!named_queries;
        return $!named_queries.write: $context, $params;
    }

    method create (Str:D $context) {
        self!init unless $!named_queries;
        return $!named_queries.write: $context ~ $!named_queries.divider ~ 'create';
    }

    method insert (Str:D $context, Hash:D $params) {
        self!init unless $!named_queries;
        return $!named_queries.write: $context ~ $!named_queries.divider ~ 'insert', $params;
    }

    method select (Str:D $context, Hash:D $params) {
        self!init unless $!named_queries;
        return $!named_queries.read: $context ~ $!named_queries.divider ~ 'select', $params;
    }

    method object() {
        self!init unless $!named_queries;
        return $!named_queries;
    }

    method dispose () {
        return unless $!named_queries;
        $!named_queries.dispose 
    }
}


=begin pod

=head1 NAME

App::Football - Contains methods for football program

=head1 SYNOPSIS

Sample in settings.yml

=begin code

plugins:
  NamedQueries:
    divider: '/'
    namespace: MyApp::Db::Queries
    handle:
      driver: SQLite
      database: test.sqlite3

=end code

Using the nq object

=begin code

    use v6.c;
    use Bailador;
    use Bailador::RouteHelper;
    use Bailador::Plugin::NamedQueries;

    my $version = '0.0.1';

    class MyApp is Bailador::App {
        submethod BUILD(|) {
            self.add_route: make-route('GET','/' => sub {
                template 'index.html', { 
                      result => self.plugins.get('NamedQueries').read: 'user/select',
                }
            });
        }
    }

=end code

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head1 METHODS

=head2 read

=head2 read

=head2 write

=head2 write

=head2 create

=head2 insert

=head2 select

=head2 object

=head2 dispose

=head1 AUTHOR

Mario Zieschang, C<< <mziescha at cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright © 2017 Mario Zieschang

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=end pod
