#! /usr/bin/perl

my @ip_content;
my @ip;



open(INPUT,"<1.txt")or die "open 1.txt failed!\n";
@ip_content = <INPUT>;
close INPUT;


open(INPUT,"<2.txt")or die "open 1.txt failed!\n";
@ip = <INPUT>;
close INPUT;

open(OUTPUT,">output.txt")or die "open output.txt failed!\n";
foreach my $ip(@ip){
	chomp($ip);
	$time_found = 0;
	foreach my$ip_content(@ip_content){
		chomp($ip_content);
		if($ip_content =~ /$ip/){
			$time_found = 1;
			if($ip_content =~ s/$ip//){
				print OUTPUT "$ip_content,$ip\n";
			}
		}
	}
	if($time_found == 0){
		print OUTPUT " ,$ip\n";
	}
}

close OUTPUT;
