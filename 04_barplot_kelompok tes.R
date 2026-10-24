library(file2meco)
library(microeco)
library(grDevices)
library(ggplot2)

# load QIIME2 rarefied phyloseq object
load("./phyloseq_obj_rq2.Rdata")

# konversi phyloseq object ke microtable
microtable_rq2 <- file2meco::phyloseq2meco(physeq_obj_rq2)

# transformasi data microtable ke taxonomic abundance
# pada tingkat spesies, dengan menampil 5 spesies teratas
tax_abund_k <- microeco::trans_abund$new(dataset = microtable_rq2, taxrank = "Species", ntaxa = 5, groupmean = "Lokasi_dan_nosampel")

# expand palet warna dari palet standar Dark2 RColorBrewer
# dari 8 warna ke 10 warna
palexpand <- grDevices::colorRampPalette(RColorBrewer::brewer.pal(8, "Dark2"))(10)

# plot barplot tumpuk
tax_abund_k$plot_bar(color_values = palexpand, bar_full = T) + 
  ggplot2::theme_classic() + 
  ggplot2::theme(axis.title.x = element_text(size = 12),axis.title.y = element_text(size = 12))

# intip data kelimpahan relatif dalam bentuk data frame
df_tax_abund_k <- data.frame(tax_abund_k[["data_abund"]])
