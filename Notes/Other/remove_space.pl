#! /usr/bin/perl

my @all_content;
my @output;
my $len2;

open(INPUT,"<te_log.txt")or die "open input.txt failed!\n";
@all_content = <INPUT>;
close INPUT;

open(OUTPUT,">output.txt")or die "open output.txt failed!\n";
foreach my $content(@all_content){
	chomp($content);
	if($content =~ s/\s//g){
	    print OUTPUT "0x$content\n";
    }
}

close OUTPUT;
