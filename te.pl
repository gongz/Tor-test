use LWP::UserAgent;

$user_agent = new LWP::UserAgent;

#$request = new HTTP::Request('GET', 'http://www.baidu.com');

#$response = $user_agent->request($request);

#open FILEHANDLE, ">baidu.txt";

#print FILEHANDLE $response->{_content};

#close FILEHANDLE;
$localtime     = localtime;

print $localtime- localtime;
