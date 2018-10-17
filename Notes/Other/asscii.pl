#! /usr/bin/perl

my @assci;
my @source;
my %hash;



open(INPUT,"<ascii.txt")or die "open ascii.txt failed!\n";
@assci = <INPUT>;
close INPUT;


open(INPUT,"<source.txt")or die "open source.txt failed!\n";
@source = <INPUT>;
close INPUT;

foreach my $assci(@assci){
    if($assci =~ /(\d+)\s*(\S+)/){
        #print $assci."\n";
        $hash{$1} = $2;
        print $1."-".$2."\n";
    }
}

open(OUTPUT,">output.txt")or die "open output.txt failed!\n";
foreach my $source(@source){
    chomp($source);
    print OUTPUT $hash{$source};
}


close OUTPUT;
