echo "FG genome"

BeforeContact=`ls /home/sandeep/Mukesh/Uniq_FQ_Id_FG|grep "fq"|grep "Cr-Fg"|grep "_C"|while read line; do echo "/home/sandeep/Mukesh/Uniq_FQ_Id_FG/"$line; done|tr "\n" " "`
AfterContact=`ls /home/sandeep/Mukesh/Uniq_FQ_Id_FG|grep "fq"|grep "Cr-Fg"|grep "_AC"|while read line; do echo "/home/sandeep/Mukesh/Uniq_FQ_Id_FG/"$line; done|tr "\n" " "`
perl ShortStack --readfile $BeforeContact --genomefile Genome/Fusarium_graminearum.RR1.dna_rm.toplevel.fa --mismatches 0 --foldsize 1000 --dicermin 18 --dicermax 35 --pad 200 --mincov 5.0rpmm --outdir BeforeContact_FG --bowtie_cores 30 --sort_mem 100G
perl ShortStack --readfile $AfterContact --genomefile Genome/Fusarium_graminearum.RR1.dna_rm.toplevel.fa --mismatches 0 --foldsize 1000 --dicermin 18 --dicermax 35 --pad 200 --mincov 5.0rpmm --outdir AfterContact_FG --bowtie_cores 30 --sort_mem 100G

echo "BC genome"

BeforeContact=`ls /home/sandeep/Mukesh/Uniq_FQ_Id_BC|grep "fq"|grep "Cr-Bc"|grep -v "_AC"|while read line; do echo "/home/sandeep/Mukesh/Uniq_FQ_Id_BC/"$line; done|tr "\n" " "`
AfterContact=`ls /home/sandeep/Mukesh/Uniq_FQ_Id_BC|grep "fq"|grep "Cr-Bc"|grep "_AC"|while read line; do echo "/home/sandeep/Mukesh/Uniq_FQ_Id_BC/"$line; done|tr "\n" " "`
perl ShortStack --readfile $BeforeContact --genomefile Genome/Botrytis_cinerea.ASM83294v1.dna_rm.toplevel.fa --mismatches 0 --foldsize 1000 --dicermin 18 --dicermax 35 --pad 200 --mincov 5.0rpmm --outdir BeforeContact_BC --bowtie_cores 30 --sort_mem 100G
perl ShortStack --readfile $AfterContact --genomefile Genome/Botrytis_cinerea.ASM83294v1.dna_rm.toplevel.fa --mismatches 0 --foldsize 1000 --dicermin 18 --dicermax 35 --pad 200 --mincov 5.0rpmm --outdir AfterContact_BC --bowtie_cores 30 --sort_mem 100G

echo "CR genome"
BeforeContact=`ls /home/sandeep/Mukesh/Uniq_FQ_Id_ForCR|grep "fq"|grep "Cr-Bc"|grep -v "_AC"|while read line; do echo "/home/sandeep/Mukesh/Uniq_FQ_Id_ForCR/"$line; done|tr "\n" " "`
AfterContact=`ls /home/sandeep/Mukesh/Uniq_FQ_Id_ForCR|grep "fq"|grep "Cr-Bc"|grep "_AC"|while read line; do echo "/home/sandeep/Mukesh/Uniq_FQ_Id_ForCR/"$line; done|tr "\n" " "`
perl ShortStack --readfile $BeforeContact --genomefile Genome/CrosV2genome.fasta --mismatches 0 --foldsize 1000 --dicermin 18 --dicermax 35 --pad 200 --mincov 5.0rpmm --outdir BeforeContact_CR --bowtie_cores 30 --sort_mem 200G
perl ShortStack --readfile $AfterContact --genomefile Genome/CrosV2genome.fasta --mismatches 0 --foldsize 1000 --dicermin 18 --dicermax 35 --pad 200 --mincov 5.0rpmm --outdir AfterContact_CR --bowtie_cores 30 --sort_mem 200G
