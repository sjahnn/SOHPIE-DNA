# SOHPIE-DNA (Statistical Approach via Pseudo-value Information and Estimation for Differential Network Analysis)

SOHPIE-DNA: Differential Co-Abundance Network Analyses for Microbiome Data Adjusted for Clinical Covariates Using Jackknife Pseudo-Values <br/>
Submitted for consideration for publication in *Nature Communications*.
</br>


### Usage
* **Thetahat_MiNW.R** is to calculate the degree centrality measure of each taxa. 
* **SOHPIE-DNA_main.R** is the primary code to analyze the data using our method. This will load **Thetahat_MiNW.R**, so please make sure download both R codes to appropriately apply our method. 
</br>

To showcase our method, we apply SOHPIE-DNA on two real datasets from the American Gut Project (McDonald *et al.*, 2018) and the Diet Exchange Study (O'Keefe *et al.*, 2018) to identify differentially connected (DC) taxa with presence of covariates. Please refer to our manuscript to see what variables are used and how we further trim the data for our study.  

```diff
- The user manual is also provided in this repository, titled with **SOHPIE-DNA_UserManual.pdf.**  
```

### Required Packages
Please install R packages below to use SOHPIE-DNA.
* robustbase
* SpiecEasi
* parallel
* dplyr
* fdrtool

We advise the user to install these to load the real data from two aforementioned studies if you wish to analyze with different set of clinical covariates. If you wish to replicate what we have analyzed, please download the two cleaned datasets in RDS file from this repository: **cleaned_amgut.rds** and **cleaned_dietswap.rds**
* microbiome
* SpiecEasi

Additionally, the data are in *phyloseq* object, so please install *phyloseq* R package as well.

### References
Ahn, S., Grimes, T. and Datta, S (2022). [A pseudo-value regression approach for differential network analysis of co-expression data](https://arxiv.org/abs/2211.16745). *Preprint* </br></br>
McDonald, D. et al. (2018). [American gut: an open platform for citizen science microbiome research](https://pubmed.ncbi.nlm.nih.gov/29795809/). *mSystems*, **3**, e00031-18. </br></br>
O'Keefe, S. J. et al. (2015). [Fat, fibre, and cancer risk in African Americans and rural Africans](https://pubmed.ncbi.nlm.nih.gov/25919227/). *Nature Communications*, **6**, 6342 </br></br>
</br>


### Contact
If you encounter a bug or any suggestions to improve our work, please feel free to email me (Seungjun Ahn) at sahn1@ufl.edu.

In memory of Sofie.
