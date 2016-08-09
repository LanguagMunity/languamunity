package me::longterm;
# This package implements the long-term memory of the command.
use strict;
use chobak_json;
use chobak_cstruc;

my $memdir;

$memdir = $ENV{"HOME"} . "/.chobakwrap/languamunity";
system("mkdir","-p",$memdir);

sub fjsnm {
  return($memdir . '/' . $_[0] . '.json');
}

sub load {
  my $lc_vl;
  
  # First we load what is previously in the file - and assure that
  # it is a hash:
  $lc_vl = &chobak_json::readf($memdir . '/main-file.json');
  
  &formatref($lc_vl);
  
  return $lc_vl;
}

sub save {
  my $lc_vl;
  $lc_vl = $_[0];
  &formatref($lc_vl);
  &chobak_json::savef($lc_vl,$memdir . '/main-file.json');
}

sub formatref {
  my $lc_vl;
  $lc_vl = $_[0];
  
  if ( ref($lc_vl) ne 'HASH' )
  {
    $lc_vl = {};
    $_[0] = $lc_vl;
  }
  
  # Now we make sure that this structure has the deck:
  &chobak_cstruc::force_hash_has_array($lc_vl,'deck');
  
  # Now make sure that the structure has a hand:
  &chobak_cstruc::force_hash_has_array($lc_vl,'hand');
  
  # And, of course, we need some place to store the settings:
  &chobak_cstruc::force_hash_has_hash($lc_vl,'stng');
}



1;
