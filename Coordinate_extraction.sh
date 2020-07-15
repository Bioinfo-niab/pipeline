#!/usr/bin/bash
Genome="Fusarium_graminearum.RR1.dna_rm.toplevel.fa"
Gff="Fusarium_graminearum.RR1.46.gff3"
base=`echo $Gff|cut -d "." -f 1`

## Removing  old files
rm *bed *loci

## extract chromosome-wise genome size extraction
cat $Genome|grep \>|cut -d ":" -f 4-6|sed 's/:/\t/g' >$base"_ChromSizes.bed"

## sorting of gff file on the basiis of column 1 4,5
cat $Gff| grep -v "Rothamsted Research\|chromosome"|awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k4,4n -k5,5n"}' > $base"_sorted.gff"
cat $base"_sorted.gff"|cut -f 3|sort|uniq|grep -v "#"|egrep "CDS|exon|RNA|UTR" >$base"_feature.txt"
cat $base"_feature.txt"|sort|while read line; do echo $line;  cat $base"_sorted.gff"|awk -v a="$line" '{if($3==a) print $0}'|cut -f 1,4,5,9|sed 's/\t/:/;s/\t/-/' >$base"_"$line".loci"; done

## Extraction of intergenic coordinates
bedtools complement -i  $base"_sorted.gff" -g $base"_ChromSizes.bed"|sed 's/\t/:/;s/\t/-/' >$base"_intergenic_sorted.bed"

## Extraction of exon coordinates
cat $base"_sorted.gff"|awk '$1 ~ /^#/ {print $0;next} {if ($3 == "exon") print $1, $4-1, $5}'|grep -v "#" >$base"_exon_sorted.bed"

# sorting of exon and intergenic region
cat $base"_exon_sorted.bed" $base"_intergenic_sorted.bed" |sort -k1,1 -k2,2n|sed 's/  */\t/g' >$base"_exon_intergenic_sorted.bed"

# extraction of intron cordinate
bedtools complement -i $base"_exon_intergenic_sorted.bed" -g $base"_ChromSizes.bed" |sed 's/\t/:/;s/\t/-/' >$base"_intron_sorted.bed"

rm -rf $base"_Feature"
mkdir $base"_Feature"
cat $base"_lnc_RNA.loci" $base"_snRNA.loci" $base"_snoRNA.loci" $base"_lnc_RNA.loci" $base"_ncRNA_gene.loci" \
$base"_RNase_MRP_RNA.loci" $base"_RNase_P_RNA.loci" $base"_SRP_RNA.loci" > $base"_Feature"/$base"_noncoding.loci"

mv $base"_intron_sorted.bed" $base"_Feature"/$base"_intron.loci"
mv $base"_intergenic_sorted.bed" $base"_Feature"/$base"_intergenic.loci"
mv $base"_"CDS".loci" $base"_"exon".loci" $base"_"five_prime_UTR".loci" $base"_"three_prime_UTR".loci" $base"_Feature"
mv $base"_"tRNA".loci" $base"_"rRNA".loci" $base"_Feature"

rm *loci
rm $base"_exon_intergenic_sorted.bed" $base"_ChromSizes.bed" $base"_sorted.gff" $base"_feature.txt" $base"_exon_sorted.bed"
