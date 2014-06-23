package Debug::Fork::Screen;

use File::Temp ();

our $VERSION = '0.01';

sub DB::get_fork_TTY {

    my ( $FH, $filename ) = File::Temp::tempfile( UNLINK => 1 );

    ( ( system( qq{screen -t 'Child $$' sh -c "tty > $filename ; sleep 1000000"} ) >> 8 ) == 0 ) or return '';

    sleep( 1 ); # a crutch

    seek( $FH, 0, 0 );
    chomp( my $tty = <$FH> );
    close( $FH );

    return $tty;
}

1;

__END__

