#!/usr/bin/bash
rm -rf CDS exon five_prime_UTR intergenic intron noncoding rRNA three_prime_UTR tRNA Summary.txt
ls |grep "loci"|while read line; do
base=`echo $line|sed 's/.loci//'|cut -d "_" -f 3-`; echo -e $line"\t"$base;
perl ../ShortStack --bamfile merged_alignments.bam --genomefile ../Genome/Fusarium_graminearum.RR1.dna_rm.toplevel.fa --mismatches 0 --foldsize 1000 --dicermin 18 \
--dicermax 35 --pad 200 --mincov 5.0rpmm --outdir $base --locifile $line;
done

find  -name "Results.txt"|while read file; do base=`echo $file|cut -d "/" -f 2`; echo -e $file"\t"$base;
cat $file|awk '{if(($13 !~/N1/) && ($13 !~ /N9/) && ($13 !~ /N10/) && ($13 !~ /N2/)) print $0}' >$base"_Results.txt"
count=`cat $base"_Results.txt"|grep -v "#"|wc -l`
echo -e $file"\t"$count >>Summary.txt;
done
