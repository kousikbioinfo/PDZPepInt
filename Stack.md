---


---

<p>INTERVAL initial data processing with GATK VQSR</p>
<p><strong>STEP 1:</strong><br>
<em>If you have a genome-wide file, split it into workable chunks using tabix (in my case, by-chromosome). Exclude X and Y as they cannot be recalibrated. For INTEVAL we have 200 chunks.</em></p>
<p>split your files into SNPs and INDELs, they need to be processed separately</p>
<pre><code>bcftools view -V indels, mnps, other -a -c 1 -Oz -o $chr_of_200.snps.vcf.gz \ 
INTERVAL-15x-3764.$chr_of_200.dbsnp_b147_ids.vcf.gz --threads 4 

bcftools view -V snps, mnps, other -a -c 1 -Oz -o $chr_of_200.indels.vcf.gz \
INTERVAL-15x-3764.$chr_of_200.dbsnp_b147_ids.vcf.gz --threads 4  --threads 4 
</code></pre>
<p><em>Note: -c 1 is used to remove the non-polymorphic site (100% missingness)</em></p>
<p><strong>STEP 2:</strong><br>
<em>Split multiallelics into several records</em></p>
<pre><code>bcftools norm -m- -Oz -o $chr_of_200.snps.splitindel.vcf.gz $chr_of_200.snps.vcf.gz --threads 4

bcftools norm -m- -Oz -o $chr_of_200.indels.splitindel.vcf.gz $chr_of_200.indels.vcf.gz --threads 4  
</code></pre>
<p><strong>STEP 3:</strong><br>
<em>Remove star alleles</em></p>
<pre><code>/nfs/users/nfs_a/ag15/scripts/VCF.suppress.stars.sh $chr_of_200.snps.splitindel.vcf.gz

/nfs/users/nfs_a/ag15/scripts/VCF.suppress.stars.sh $chr_of_200.indels.splitindel.vcf.gz
</code></pre>
<p>Note: This script will create output file:-<br>
<em>$chr.snps.splitindel.nostar.vcf.gz and $chr.indels.splitindel.nostar.vcf.gz</em></p>
<p><strong>Step 4:</strong><br>
<em>Merge per-chromosome or chunk files into a genome-wide file (will take ~1day)</em></p>
<pre><code>ls -l *snps.splitindel.nostar.vcf.gz | awk '{print $9}' | sort -g &gt; snps.concat.list; \
bcftools concat -f snps.concat.list -Oz -o merge.snps.splitindel.nostar.vcf.gz --threads 8; \
tabix -f -p vcf merge.snps.splitindel.nostar.vcf.gz

ls -l *indels.splitindel.nostar.vcf.gz | awk '{print $9}' | sort -g &gt; indels.concat.list; \
bcftools concat -f indels.concat.list -Oz -o merge.indels.splitindel.nostar.vcf.gz --threads 8; \
tabix -f -p vcf merge.indels.splitindel.nostar.vcf.gz
</code></pre>
<p><strong>Step 5:</strong><br>
VQSR CALL (including apply recalibration) -</p>
<pre><code>Script: ~/Projects/Scripts/Interval_WGS/QC/GATK_VQSR.sh
</code></pre>
<p><strong>Step 6:</strong><br>
<em>38 sample removed and merging the multi-allelic sites</em></p>
<pre><code>bcftools view -f PASS -S ^38_samples_to_remove.txt $chr_of_200.snps.splitindel.nostar.recalibrated.vcf.gz | \
bcftools norm -m+ -cx \
-Oz -o $chr_of_200.snps.splitindel.nostar.recalibrated.hardfilttered.merged-miltiallelic_3724.vcf.gz -

bcftools view -f PASS -S ^38_samples_to_remove.txt $chr_of_200.indels.splitindel.nostar.recalibrated.vcf.gz | \
bcftools norm -m+ -cx \
-Oz -o $chr_of_200.indels.splitindel.nostar.recalibrated.hardfilttered.merged-miltiallelic_3724.vcf.gz -

tabix -f -p vcf $chr_of_200.snps.splitindel.nostar.recalibrated.hardfilttered.merged-miltiallelic_3724.vcf.gz
tabix -f -p vcf $chr_of_200.indels.splitindel.nostar.recalibrated.hardfilttered.merged-miltiallelic_3724.vcf.gz
</code></pre>
<p><strong>Step 7:</strong><br>
<em>Chunk-wise SNPs-Indels merging…</em></p>
<pre><code>bcftools concat -a \
$chr_of_200.snps.splitindel.nostar.recalibrated.hardfilttered.merged-miltiallelic_3724.vcf.gz \
$chr_of_200.indels.splitindel.nostar.recalibrated.hardfilttered.merged-miltiallelic_3724.vcf.gz \
-Oz -o $chr_of_200.nostar.recalibrated.hardfiltered.3724_sample.vcf.gz
</code></pre>

