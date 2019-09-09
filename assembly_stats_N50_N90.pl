#!/usr/bin/perl

#
# Program : assembly_stats_N50_N90.pl
#
# Author  : Dr. Suyash Agarwal
#
# Purpose : Computes the assembly statistics from a multi-fasta file.
#
# Usage   : assembly_stats_N50_N90.pl multi-fasta_file  (output to STDOUT)
#


$file= shift or die;

open (F1, $file);

while(<F1>){
	chomp;
	if(/^>/){
		$id=$_;
		$hash{$id}="";	
		$hash1++;
	}
	else{
		$hash{$id}.=$_;
	}
}

close F1;

$sum=0;

foreach $k(keys %hash){
	$len = length $hash{$k};
	push(@arr,$len);
	$sum +=$len;
}

@sorted_arr = sort {$b <=> $a} @arr;

$half=$sum/2;
$N_90=($sum*90)/100;
$rounded_N90 = sprintf "%.0f", $N_90;
$tmp_sum=0;
$c2=0;
$c1=0;

foreach $ele(@sorted_arr){
	$tmp_sum +=$ele;
	if($tmp_sum > $rounded_N90 && $c1 ==0){
		#print "N90 of the assembly is: $ele\n";
		$N90=$ele;
		$c1++;
	} 
	if($tmp_sum > $half && $c2 == 0){
		#print "N50 of the assembly is: $ele","\n";
		$N50=$ele;
		$c2++;
	}
	
}
$contig_mean=$sum/$hash1;

print "Total Number of Contigs are : $hash1\n";
print "Total length of all Contigs : $sum\n";
print "The maximum Contig length is : $sorted_arr[0]\n";
print "The mean Contig length is : $contig_mean\n";
print "The N50 of the assembly is : $N50\n";
print "The N90 of the assembly is : $N90\n";



