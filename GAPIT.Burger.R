`GAPIT.Burger` <-
function(Y=NULL,CV=NULL,GK=NULL){
#Object: To calculate likelihood, variances and ratio  
#Straitegy: NA
#Output: P value
#intput: 
#Y: phenotype with columns of taxa,Y1,Y2...
#CV: covariate variables with columns of taxa,v1,v2...
#GK: Genotype data in numerical format, taxa goes to row and snp go to columns. the first column is taxa (same as GAPIT.bread)
#Authors: Zhiwu Zhang
#Last update: November 2, 2011
##############################################################################################

#print("GAPIT.Burger in progress...")
#print("dimension of Y, CV and GK")
#print(dim(Y))
#print(length(Y))
#print(dim(CV))
#print(length(CV))
#print(dim(GK))
#print(length(GK))


if(!is.null(CV)){
  theCV=as.matrix(cbind(matrix(1,nrow(CV),1),CV[,-1]))
}else{
  theCV=matrix(1,nrow(Y),1)
}

#handler of single column GK
n=nrow(GK)
m=ncol(GK)
if(m>2){
theGK=as.matrix(GK[,-1])
}else{
theGK=matrix(GK[,-1],n,1)
}

#print("debug dimension of Y, CV and GK")
#print(dim(Y))
#print(length(Y))
#print(dim(CV))
#print(length(CV))
#print(dim(GK))
#print(length(GK))

myFaSTREML=GAPIT.get.LL(pheno=matrix(Y[,-1],nrow(Y),1),geno=NULL,snp.pool=theGK,X0=theCV   )

REMLs=-2*myFaSTREML$LL  
delta=myFaSTREML$delta
vg=myFaSTREML$vg
ve=myFaSTREML$ve

#print("GAPIT.Burger succeed!")  
return (list(REMLs=REMLs,vg=vg,ve=ve,delta=delta))
} #end of GAPIT.Burger

