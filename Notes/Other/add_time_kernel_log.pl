#! /usr/bin/perl

my @all_content;
my @unfind;
my @unfind_time;
my $time_found = 0;
my $base_time = "";
my $time = "";
my $print_log = 1;
my $mil_length=1000000;
my $inpuFile = $ARGV[0];
my $outpuFile = $ARGV[1];
my $mil_reduce = 0;
my $sec_reduce = 0;
		
sub printConentBeforeUTC{
	print $base_time."\n";
	print $time."\n";
	my $basetime_sec = "";
	my $basetime_mil = "";
	if($base_time =~ /(\d*)\.(\d*)/){
		$basetime_sec = $1;
		$basetime_mil = $2;
		if($print_log == 1){
			print "basetime_sec = ".$basetime_sec."\n";
			print "basetime_mil = ".$basetime_mil."\n";
		}
	}
	$total=$#unfind;
	print "total = ".$total."\n";
	for( $a = 0; $a < $total+1; $a = $a + 1 ){
		my $tmp_content = $unfind[$a];
		my $basetime_tem = "";
		my $time_hour = "";
		my $time_miu = "";
		my $time_sec = "";
		my $time_mil = "";
		my $time_year = "";
		if($time =~ /(\S*\s*)(\d*):(\d*):(\d*)\.(\d*)/){
			$time_year = $1;
			$time_hour = $2;
			$time_miu = $3;
			$time_sec = $4;
			$time_mil = $5;
			if($print_log == 1){
				print "time_year = ".$time_year."\n";
				print "time_hour = ".$time_hour."\n";
				print "time_miu = ".$time_miu."\n";
				print "time_sec = ".$time_sec."\n";
				print "time_mil = ".$time_mil."\n";
			}
		}
		print "tmp_content = ".$tmp_content."\n";
		if($tmp_content =~ /\s*(\d*\.\d*)]/){
			$basetime_tem = $1;
            if($print_log == 1){
                print "basetime_tem = ".$basetime_tem."\n";
            }
		}else{
			print "tem_contect match failed!\n";
		}
		my $basetime_tem_sec = "";
		my $basetime_tem_mil = "";
		if($basetime_tem =~ /(\d*)\.(\d*)/){
			$basetime_tem_sec = $1;
			$basetime_tem_mil = $2;
            if($print_log == 1){
                print "basetime_tem_sec = ".$basetime_tem_sec."\n";
                print "basetime_tem_mil = ".$basetime_tem_mil."\n";
            }
		}
		if($basetime_mil < $basetime_tem_mil){
			$mil_reduce = $basetime_mil + $mil_length - $basetime_tem_mil;
			$basetime_tem_sec = $basetime_tem_sec + 1;
		}else{
			$mil_reduce = $basetime_mil - $basetime_tem_mil;
		}
		$sec_reduce = $basetime_sec - $basetime_tem_sec;
        if($print_log == 1){
            print "mil_reduce = ".$mil_reduce."\n";
            print "sec_reduce = ".$sec_reduce."\n";
        }
		
		if($time_mil < $mil_reduce){
			$time_mil = $time_mil + $mil_length - $mil_reduce;
			$sec_reduce = $sec_reduce + 1;
		}else{
			$time_mil = $time_mil - $mil_reduce;
		}
		if($time_sec < $sec_reduce){
			$time_sec = $time_sec + 60 - $sec_reduce;
			if($time_miu < 1){
				$time_miu = $time_miu + 60 -1;
				$time_hour = $time_hour - 1;
			}else{
				$$time_miu = $time_miu - 1;
			}
		}else{
			$time_sec = $time_sec - $sec_reduce;
		}
		
		$time_miu = $time_miu + ($time_sec-$time_sec%60)/60;
		$time_sec = $time_sec%60;

		$time_hour = $time_hour + ($time_miu-$time_miu%60)/60;
		$time_miu = $time_miu%60;

		
		if($print_log == 1){
            print "time_year = ".$time_year."\n";
            print "time_hour = ".$time_hour."\n";
            print "time_miu = ".$time_miu."\n";
            print "time_sec = ".$time_sec."\n";
            print "time_mil = ".$time_mil."\n";
            print "======================\n";
        }
		print OUTPUT $time_year.$time_hour.":".$time_miu.":".$time_sec."\.".$time_mil." "."$tmp_content\n";
	}
}


open(INPUT,$inpuFile)or die "open ".$inpuFile." failed!\n";
@all_content = <INPUT>;
close INPUT;

open(OUTPUT,">".$outpuFile)or die "open ".$outpuFile." failed!\n";
foreach my $content(@all_content){
	chomp($content);
    if($print_log == 1){
        #print $content."\n";
    }
	if($content =~ /.*\[\s*(\d*\.\d*)\].*(\d{4,4}-\d{2,2}-\d{2,2}\s*\d*:\d*:\d*.\d*).*UTC/){
		$time_found = 1;
		$base_time = $1;
		$time = $2;
        if($print_log == 1){
            #print "base_time = ".$base_time."\n";
            #print "time = ".$time."\n";
        }
    }else{
		if($print_log == 1){
			#print "match failed\n";
		}
	}
	
	if($time_found == 1){
		printConentBeforeUTC();
		my $basetime_tem = "";
		if($content =~ /\s*(\d*\.\d*)]/){
			$basetime_tem = $1;
            if($print_log == 1){
                #print "basetime_tem = ".$basetime_tem."\n";
            }
		}
		my $basetime_tem_sec = "";
		my $basetime_tem_mil = "";
		if($basetime_tem =~ /(\d*)\.(\d*)/){
			$basetime_tem_sec = $1;
			$basetime_tem_mil = $2;
            if($print_log == 1){
               # print "basetime_tem_sec = ".$basetime_tem_sec."\n";
                #print "basetime_tem_mil = ".$basetime_tem_mil."\n";
            }
		}
		my $basetime_sec = "";
		my $basetime_mil = "";
		if($base_time =~ /(\d*)\.(\d*)/){
			$basetime_sec = $1;
			$basetime_mil = $2;
            if($print_log == 1){
               # print "basetime_sec = ".$basetime_sec."\n";
                #print "basetime_mil = ".$basetime_mil."\n";
            }
		}
		my $time_hour = "";
		my $time_miu = "";
		my $time_sec = "";
		my $time_mil = "";
		my $time_year = "";
		if($time =~ /(\S*\s*)(\d*):(\d*):(\d*)\.(\d*)/){
			$time_year = $1;
			$time_hour = $2;
			$time_miu = $3;
			$time_sec = $4;
			$time_mil = $5;
            if($print_log == 1){
                #print "time_year = ".$time_year."\n";
                #print "time_hour = ".$time_hour."\n";
                #print "time_miu = ".$time_miu."\n";
                #print "time_sec = ".$time_sec."\n";
                #print "time_mil = ".$time_mil."\n";
            }
		}
		
		my $mil_add = $basetime_tem_mil - $basetime_mil;
		my $sec_add = $basetime_tem_sec - $basetime_sec;
        if($print_log == 1){
            #print "mil_add = ".$mil_add."\n";
            #print "sec_add = ".$sec_add."\n";
        }

		$time_mil = $time_mil + $mil_add;
		$time_sec = $time_sec + $sec_add + ($time_mil-$time_mil%$mil_length)/$mil_length;
		$time_mil = $time_mil%$mil_length;
		
		$time_miu = $time_miu + ($time_sec-$time_sec%60)/60;
		$time_sec = $time_sec%60;

		$time_hour = $time_hour + ($time_miu-$time_miu%60)/60;
		$time_miu = $time_miu%60;

		
		if($print_log == 1){
            #print "time_year = ".$time_year."\n";
            #print "time_hour = ".$time_hour."\n";
            ##print "time_miu = ".$time_miu."\n";
            #print "time_sec = ".$time_sec."\n";
            #print "time_mil = ".$time_mil."\n";
            #print "======================\n";
        }
		print OUTPUT $time_year.$time_hour.":".$time_miu.":".$time_sec."\.".$time_mil." "."$content\n";
	}else{
		print "push content = ".$content."\n";
		push @unfind,$content;
		#print OUTPUT "$content\n";
	}
}


close OUTPUT;
