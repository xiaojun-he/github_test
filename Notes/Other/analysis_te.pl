#! /usr/bin/perl

my @all_content;
my @output;
my $len2;
sub find_string_files{
    $_ = shift;
	if($_ =~ /(\d\d:\d\d:\d\d\s+.*)+(\d\d:\d\d:\d\d\s+.*)+/){
	    push @output,$2;
	    find_string_files($1);
    }else{
	    push @output,$_;
    }
}

open(INPUT,"<te_log.txt")or die "open input.txt failed!\n";
@all_content = <INPUT>;
close INPUT;

open(OUTPUT,">output.txt")or die "open output.txt failed!\n";
foreach my $content(@all_content){
	chomp($content);
	if($content =~ /(.*)(\d\d:\d\d:\d\d\s+.*)/){
	    push @output,$2;
	    find_string_files($1);
    }else{
	    push @output,$content;
    }
}

$total=$#output;
for( $a = 0; $a < $total+1; $a = $a + 1 ){
    print OUTPUT "$output[$total-$a]\n";
}

close OUTPUT;
