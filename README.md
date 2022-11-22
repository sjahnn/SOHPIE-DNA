# SOHPIE-DNA (Statistical Approach via Pseudo-value Information and Estimation for Differential Network Analysis)

SOHPIE-DNA: Differential Co-Abundance Network Analyses for Microbiome Data Adjusted for Clinical Covariates Using Jackknife Pseudo-Values <br />
Submitted for consideration for publication in *Nature Communications*.
</br>


### Usage
* **TotalConnectivity.R** is to calculate the total connectivity of each gene. 
* **SOHPIE_DNA_main.R** is the primary code to analyze the data using our method. This will load the first two codes, so please download all three R codes to apply our method. The code is heavily annotated for ease of implementation.
</br>

To showcase our method, we apply SOHPIE-DNA on two real datasets from the American Gut Project (McDonald *et al.*, 2018) and the Diet Exchange Study (O'Keefe *et al.*, 2018) to identify differentially connected (DC) taxa with presence of covariates.

The user manual for PRANA is also provided, titled with **SOHPIE_DNA_UserManual.pdf**.

### Required Packages
Please install R packages below to use SOHPIE-DNA.
* robustbase
* SpiecEasi
* parallel
* dplyr
* fdrtool
We advise the user to install these to load the real data from two aforementioned studies.
* microbiome
* SpiecEasi
Additionally, the data are in *phyloseq* object, so please install *phyloseq* R package as well.

### References
McDonald, D. et al. (2018). [American gut: an open platform for citizen science microbiome research](https://pubmed.ncbi.nlm.nih.gov/29795809/). *mSystems*, **3**, e00031-18. </br></br>
O'Keefe, S. J. et al. (2015). [Fat, fibre, and cancer risk in African Americans and rural Africans](https://pubmed.ncbi.nlm.nih.gov/25919227/). *Nature Communications*, **6**, 6342 </br></br>
</br>


### Contact
If you encounter a bug or any suggestions to improve our work, please feel free to email me (Seungjun Ahn) at sahn1@ufl.edu.

