#!/bin/csh
#PBS -q hotel
#PBS -N tf_binding
#PBS -l nodes=1:ppn=3
#PBS -l walltime=0:10:00
#PBS -o tf_binding_out.o
#PBS -e tf_binding_error.e
#PBS -V
#PBS -M t2shaw@ucsd.edu
#PBS -m abe

cd ~/code/biom262-hw1

# Exercise 1 -Tim
grep "NFKB" tf.bed > tf.nfkb.bed

wc -l tf.nfkb.bed
echo '--- First 10 lines ---'
head tf.nfkb.bed
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{print $0}'  tf.nfkb.bed | head
echo '--- Last 10 lines ---'
tail tf.nfkb.bed

#Exercise 2 -Tim
awk '$3 ~ /transcript/' gencode.v19.annotation.chr22.gtf | cat > gencode.v19.annotation.chr22.transcript.gtf

wc -l gencode.v19.annotation.chr22.transcript.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.gtf 
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{print $0}' gencode.v19.annotation.chr22.transcript.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.gtf 

#Exercise 3 -Tim
module load biotools
bedtools flank -i gencode.v19.annotation.chr22.transcript.gtf -g hg19.genome -s -l 2000 -r 0| cat > gencode.v19.annotation.chr22.transcript.promoter.gtf


wc -l gencode.v19.annotation.chr22.transcript.promoter.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.gtf
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}' gencode.v19.annotation.chr22.transcript.promoter.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.gtf

#Excercise 4 -Ben
#start bens code
cd ~/code/biom262-2016/weeks/week01/data
module load biotools
intersectBed -a gencode.v19.annotation.chr22.transcript.promoter.gtf  \
-b tf.nfkb.bed > gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
# end bens code
wc -l gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
echo '--- Random 10 lines ---'
awk -v seed=908 'BEGIN{srand(seed);}{print $0}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
# End Excercise 4

#Excercise 5 -Ben 
#start bens code
cd ~/code/biom262-2016/weeks/week01/data
module load biotools
bedtools getfasta -s -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
 # end bens code
wc -l gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
echo '--- Random 10 lines ---'
awk -v seed=908 'BEGIN{srand(seed);}{print $0}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
# End Excercise 5


#Message to standard output
echo "Hello I am a message in standard out (stdout)"
echo "Hello I am a message in standard error (stderr)" >&2
