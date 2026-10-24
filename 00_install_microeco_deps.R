library(BiocManager)
library(devtools)

#Install paket dependensi microeco 

tmp_deps <- c("microeco", "mecoturn", "MASS", "GUniFrac", "ggpubr", "randomForest", "ggdendro", "ggrepel", "agricolae", "igraph", "picante", "pheatmap", "rgexf", "ggalluvial", "ggh4x", "rcompanion", "FSA", "gridExtra", "aplot", "NST", "GGally", "ggraph", "networkD3", "poweRlaw", "ggtern", "SRS", "performance")

for(x in tmp_deps){
  if(!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
  }
}

BiocManager::install("file2meco")
BiocManager::install("MicrobiomeStat")
BiocManager::install("WGCNA")
BiocManager::install("ggtree")
BiocManager::install("metagenomeSeq")
BiocManager::install("ALDEx2")
BiocManager::install("ANCOMBC")

devtools::install_github("zdk123/SpiecEasi")
devtools::install_github("GraceYoon/SPRING")
devtools::install_github("irinagain/mixedCCA")
devtools::install_github("stefpeschel/NetCoMi")
devtools::install_github("lch14forever/beem-static")
devtools::install_github("mattflor/chorddiag")
devtools::install_github("ricardo-bion/ggradar")
devtools::install_github("gmteunisse/ggnested")
devtools::install_github("mj163163/ggcor-1")
devtools::install_github("lbbe-software/seqinr")
