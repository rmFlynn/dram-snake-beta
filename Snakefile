from glob import glob
import os

input_paths= [ '/home/projects-wrighton-2/CrossWetlandComparison/genomes/linked_genomes_for_anno/*.fna']
samples =  {os.path.basename(i).removesuffix('.fa'):i for j in input_paths  for i in glob(j)}

wildcard_constraints:
    samples="|".join(list(samples.keys()))


rule all:
    input: expand('results/workdir/dram_{sample}', sample=list(samples.keys()))

rule dram:
    input:
            "results/dram/"
    resources:
       mem=4000,
       time='1-00:00:00',
    output:
        directory('results/workdir/dram_{sample}')
    shell:
        """
        bash -c '
           source /opt/Miniconda2/miniconda2/bin/activate dram2
           DRAM.py annotate -i {input} -o {output} --min_contig_size 2500 --threads 3 --use_uniref --use_camper --use_fegenie --use_sulphur --use_vogdb --custom_db_name methyl --custom_fasta_loc /home/projects-wrighton-2/DRAM/dram_data/methyl/methylotrophy.faa '
        """
