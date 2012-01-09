use strict;
use LWP::UserAgent;
use LWP::Protocol::socks;
 
my $ua = LWP::UserAgent->new(
  agent => q{Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; YPC 3.2.0; .NET
CLR 1.1.4322)},
);
$ua->proxy([qw/ http https /] => 'socks://localhost:9050'); # Tor proxy
$ua->cookie_jar({});
my $rsp = $ua->get('http://www.yahoo.com/');
print $rsp->content;
