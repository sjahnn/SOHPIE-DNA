library(robustbase) # To fit robust regression.
library(SpiecEasi) # To obtain SparCC association network.
library(parallel) # To utilize mclapply() -- parallel computing.
library(dplyr)  # To use bind() later. 
library(fdrtool) # To compute the q-values.



dir_main = "your file directory where you saved three R codes."
dir_data = "your file directory where you saved RDS data file from the repository."



combined.amgut.data = readRDS(file.path(dir_data, "cleaned_amgut.rds")) # This will load the amgut dataset.

source(file.path(dir_main, "Thetahat_MiNW.R"))  # Load the function to calculate the degree centality measure.

est_method = sparcc # estimate the association matrix/network via SparCC


## Note: The line below will use a toy example with the first 30 out of 138 taxa.
OTUtab = combined.amgut.data[ , 8:37]
## Note: Please comment out above and uncomment the line below if you wish to replicate what was done in our paper with 138 taxa.
#OTUtab = combined.amgut.data[ , 8:ncol(combined.amgut.data)] # OTU table part of the combined data.


## Clinical/demographic covariates (phenotypic data):
phenodat = combined.amgut.data[, 1:7] # first column is ID, so not using it.






############################################################
#                                                          #
#    Apply SOHPIE-DNA to the American Gut Project data     #
#                                                          #
############################################################



########################################################################################
#  STEP 1. Estimate an association matrix via SparCC from the microbiome data.
########################################################################################
newindex_A = which(combined.amgut.data$bin_dog == 0) # Not living with dog; namely Group A
newindex_B = which(combined.amgut.data$bin_dog == 1) # Living with dog; namely Group B
OTUtabA = OTUtab[newindex_A, ] 
OTUtabB = OTUtab[newindex_B, ]

n_A <- length(newindex_A) # Sample size for Group A
n_B <- length(newindex_B) # Sample size for Group B

sparcc.matA = est_method(data = OTUtabA)$Cor
sparcc.matB = est_method(data = OTUtabB)$Cor



#############################################################################################
#  STEP 2. Calculate \hat{\theta}_{k} by taking the marginal sum of the
#          association matrix to obtain the degree centrality measure for each taxon.
#############################################################################################
thetahat_grpA = thetahats(sparcc.matA) 
thetahat_grpB = thetahats(sparcc.matA)






#############################################################################################
#  STEP 3. Re-estimate association matrix using the same OTU table without i-th subject.
#          Then, calculate \hat{\theta}_{k(i)} from the re-estimated association matrix.
#############################################################################################
# Re-estimation part
# Note: You can specify the core size by specifying mc.cores option within mclapply().
sparcc.mat_drop_grpA <- mclapply(newindex_A, function(j) sparcc(OTUtabA[-j, ])$Cor)
sparcc.mat_drop_grpB <- mclapply(newindex_B, function(j) sparcc(OTUtabB[-j, ])$Cor)
# thetahat_{-i} for each taxa
thetahat_drop_grpA <- sapply(sparcc.mat_drop_grpA, thetahats)
thetahat_drop_grpB <- sapply(sparcc.mat_drop_grpB, thetahats)




#############################################################################################
#  STEP 4. Calculate jackknife pseudovalues (\tilde{\theta}_{ik} using \hat{\theta}_{k} 
#          and \hat{\theta}_{k(i)}.
#############################################################################################
thetatildefun <- function(thetahatinput, thetahatdropinput, sizegroup) {
        thetatildeout = matrix(NA, ncol=length(thetahatinput), nrow=sizegroup)
        thetatildeout = sapply(1:nrow(thetahatdropinput), function(k) {
                sizegroup * thetahatinput[k] - (sizegroup - 1) * thetahatdropinput[k, ]
        })
        return(thetatildeout)
}

thetatilde_grpA = thetatildefun(thetahat_grpA, thetahat_drop_grpA, n_A)
thetatilde_grpB = thetatildefun(thetahat_grpB, thetahat_drop_grpB, n_B)
thetatilde = rbind(thetatilde_grpA, thetatilde_grpB)
colnames(thetatilde) = colnames(OTUtab) # Map the column names (taxa names) 



#############################################################################################
#  STEP 5. Fit a robust regression model
##############################################################################################
pseudo.reg.res <- lapply(1:ncol(thetatilde), function(i) {
        m <- thetatilde[, i]
        df <- data.frame(phenodat,
                         m = m)
        fit <- ltsReg(m ~ bin_dog + age + sex + bin_floss + bin_exercise + cat_alcohol + bin_migraine, data = df, mcd=FALSE) # include a set of covariates in this model
        return(fit)
})

### Obtain p-values (and coefficient estimates if interested) for each taxa:
beta_hat = vector(mode = "list", ncol(thetatilde)) 
p_values = vector(mode = "list", ncol(thetatilde)) 
k = NULL
for(k in 1:ncol(thetatilde)) {
        # Estimates for the beta coefficients:
        beta_hat[[k]] <- summary(pseudo.reg.res[[k]])$coef[-1, "Estimate"]
        p_values[[k]] <- summary(pseudo.reg.res[[k]])$coef[-1, "Pr(>|t|)"]
        
}

beta_hat = as.data.frame(bind_rows(beta_hat))  # Convert list into data.frame
rownames(beta_hat) <- colnames(OTUtab) # Map the taxa names to the data.frame for betahats

p_values = as.data.frame(bind_rows(p_values))  # Convert list into data.frame
rownames(p_values) <- colnames(OTUtab) # Map the taxa names to the data.frame for p-values
bindog_pval = p_values[, 1] # p-values for binary grouping variable for "living with dog". 


# Compute the q-values :
q_values = fdrtool(bindog_pval, statistic = "pvalue", plot=FALSE, verbose = FALSE)$qval
names(q_values) <- colnames(OTUtab) # Map the taxa names to the data.frame for q-values


# Lastly, return the taxa names of the significantly differentially connected (DC) taxa from SOHPIE-DNA at the 0.05 significance level.
sigDCtaxa = q_values[which(q_values < 0.05)]
names(sigDCtaxa) 










