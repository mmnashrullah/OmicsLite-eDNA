if(!require("devtools", character.only = TRUE)) {
  install.packages("devtools", dependencies = TRUE)
}

if(!require("BiocManager", character.only = TRUE)) {
  install.packages("BiocManager", dependencies = TRUE)
}

library(devtools)
library(BiocManager)

#install Ranacapa
devtools::install_github("gauravsk/ranacapa")

#install qiime2R
devtools::install_github("jbisanz/qiime2R")

#install phyloseq
BiocManager::install("phyloseq")

#install tidyverse
devtools::install_github("tidyverse/tidyverse")

#install microeco
devtools::install_github("ChiLiubio/microeco")

#install file2meco
devtools::install_github("ChiLiubio/file2meco")

#install writexl
devtools::install_github("ropensci/writexl")

#install ggpubr
devtools::install_github("kassambara/ggpubr")
