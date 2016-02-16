#Homework 1
#Anupriya Tripathi

#!/bin/bash
#PBS -N tf_binding
#PBS -o tf_binding.sh.out
#PBS -e tf_binding.sh.err
#PBS -V
#PBS -l walltime=00:10:00
#PBS -l nodes=1:ppn=1
#PBS -q hotel

echo "Hello I am a message in standard out (stdout)" 
echo "Hello I am a message in standard error (stderr) >&2"

#Ex 1
#Extracting the sites where NFKB binds
cd ~/code/biom262-2016/weeks/week01/data
awk '$4=="NFKB" {print; }' tf.bed >tf.nfkb.bed
wc -l tf.nfkb.bed
echo '--- First 10 lines ---'
head tf.nfkb.bed
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}'  tf.nfkb.bed | head
echo '--- Last 10 lines ---'
tail tf.nfkb.bed

#Ex2
#Finding all the transcrips from Chromosome 22 annotated file
cd ~/code/biom262-2016/weeks/week01/data
awk '$3=="transcript" {print; }' gencode.v19.annotation.chr22.gtf> gencode.v19.annotation.chr22.transcript.gtf
wc -l gencode.v19.annotation.chr22.transcript.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.gtf
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}'  gencode.v19.annotation.chr22.transcript.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.gtf

#Ex3
#Extracting promoter regions of chromosome 22 transcripts
cd ~/code/biom262-2016/weeks/week01/data
module load biotools
bedtools flank -l 2000 -r 0 -s -i gencode.v19.annotation.chr22.transcript.gtf -g hg19.genome> gencode.v19.annotation.chr22.transcript.promoter.gtf
wc -l gencode.v19.annotation.chr22.transcript.promoter.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.gtf
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}' gencode.v19.annotation.chr22.transcript.promoter.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.gtf

#Ex4
#Checking if there is overlap between NFKB binding sites and promoter regions in chromosome 22
cd ~/code/biom262-2016/weeks/week01/data
module load biotools
bedtools intersect -a gencode.v19.annotation.chr22.transcript.promoter.gtf -b tf.nfkb.bed> gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
wc -l gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
echo '--- Random 10 lines ---'
awk -v seed=908 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf

#Ex5
#Producing sequence for the overlap regions between NFKB binding sites and chr22 promoter regions
cd ~/code/biom262-2016/weeks/week01/data
module load biotools
bedtools getfasta -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf -s -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
wc -l gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
echo '--- Random 10 lines ---'
awk -v seed=908 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta

