#! /usr/bin/perl
my $dir = "./test";

opendir(DES_DIR, $dir);

# 取得里面的文件和目录
my @file_list = readdir(DES_DIR);

open(FILE_W,"+<test.txt") or die "cannot open test.txt\n"; 
my @contents = <FILE_W>;

open(OUTPUT,">Android.mk")or die "open Android.mk failed!\n";
print OUTPUT "LOCAL_PATH:= \$(call my-dir)\n";
foreach my $file(@file_list){
    if($file =~ /\.$/){
    }else{
        print FILE_W "\nPRODUCT_PACKAGES += ".$file;
        print OUTPUT "\ninclude \$(CLEAR_VARS)\n"
        ."LOCAL_MODULE := ".$file."\n"
        ."LOCAL_MODULE_TAGS := optional\n"
        ."LOCAL_MODULE_CLASS := EXECUTABLES\n"
        ."LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR)/bin\n"
        ."LOCAL_SRC_FILES := \$(LOCAL_MODULE)\n"
        ."include\$(BUILD_PREBUILT)\n";
    }
}
close OUTPUT;
close FILE_W;
# 关闭
closedir(DES_DIR);