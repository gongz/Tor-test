#!/usr/bin/perl
use warnings;
use strict;
use Tie::File;
use Net::SMTP;
use LWP::UserAgent;
use Time::HiRes;

our $flag = -1;
my $input_file = "urls.txt";
our @all_addr;
tie @all_addr, 'Tie::File', $input_file or print "Cant open $input_file to read addresses";

#print "Connecting without Tor\n";
#for (0 .. $#all_addr) 
#{ 
#	check_url($all_addr[$_]);    #call subroutine check_url()	
#}

print "Connecting with Tor\n";
$flag = 1;
for (0 .. $#all_addr) 
{ 
	check_url($all_addr[$_]);    #call subroutine check_url()	
}


sub check_url 
{  
	# subroutine who check given URL
    	my $target = $_[0]; 
	#setup useragent
	my $ua = LWP::UserAgent->new(agent => q{Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; YPC 3.2.0; .NET
	CLR 1.1.4322)},);
	if($flag > 0)
	{
		$ua->proxy([qw/ http https /] => 'socks://localhost:9050'); # Tor proxy
		$ua->cookie_jar({});
        }
        my $req = HTTP::Request->new(GET => "$target");
        $req->header('Accept' => 'text/html');          #Accept HTML Page

        # send request
	print "$target\n";
	my $start = [ Time::HiRes::gettimeofday( ) ];
        my $res = $ua->request($req);

        # check the outcome
        if ($res->is_success) 
	{
		# Success....all content of page has been received
		my $elapsed = Time::HiRes::tv_interval( $start );         
		print "Latency to $target is $elapsed seconds!\n";	
    	}
	else
	{
	  print "error\n";
	}
}

