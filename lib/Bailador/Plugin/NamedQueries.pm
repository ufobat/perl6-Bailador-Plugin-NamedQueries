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
        return $!named_queries.create: $context;
    }

    method insert (Str:D $context, Hash:D $params) {
        self!init unless $!named_queries;
        return $!named_queries.insert: $context, $params;
    }

    method select (Str:D $context, Hash:D $params) {
        self!init unless $!named_queries;
        return $!named_queries.select: $context, $params;
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
