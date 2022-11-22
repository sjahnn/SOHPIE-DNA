# SOHPIE-DNA (**S**tatistical Approach via Pseudo-value Informatioin and Estimation for Differential Network Analysis)

SOHPIE-DNA: Differential Co-Abundance Network Analyses for Microbiome Data Adjusted for Clinical Covariates Using Jackknife Pseudo-Values <br />
Submitted for consideration for publication in *Nature Communications*.
</br>


### Usage
* **TotalConnectivity.R** is to calculate the total connectivity of each gene. 
* **SOHPIE_DNA_main.R** is the primary code to analyze the data using our method. This will load the first two codes, so please download all three R codes to apply our method. The code is heavily annotated for ease of implementation.
</br>

To showcase our method, we apply SOHPIE-DNA on two real datasets from the American Gut Project and the Diet Exchange Study.  data is available from the Gene Expression Database with accession number [GSE158699](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE158699) (Wang *et al.*, 2021).

The user manual for PRANA is also provided, titled with **SOHPIE_DNA_UserManual.pdf**.

### References
Sakornsakolpat, P., Prokopenko, D., Lamontagne, M., and et al. (2019). [Genetic landscape of chronic obstructive pulmonary disease identifies heterogeneous cell- type and phenotype associations](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6546635/). *Nature Genetics*, **51**(3), 494–505. </br></br>
Wang, Z., Masoomi, A., Xu, Z., Boueiz, A., Lee, S., Zhao, T., Bowler, R., Cho, M., Silverman, E., Hersh, C., Dy, J., and Castaldi, P. (2021). [Improved prediction of smoking status via isoform-aware RNA-seq deep learning models](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8530282/). *PLoS Computational Biology*, **17**(10). </br></br>
Datta, S. and Datta, S. (2005). [Empirical Bayes screening of many p-values with applications to microarray studies](https://academic.oup.com/bioinformatics/article/21/9/1987/409148?login=true). *Bioinformatics*, **21**(9), 1987–1994.
</br>


### Contact
If you encounter a bug or any suggestions to improve our work, please feel free to email me (Seungjun Ahn) at sahn1@ufl.edu.

