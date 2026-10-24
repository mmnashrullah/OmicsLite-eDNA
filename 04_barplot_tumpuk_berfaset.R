library(file2meco)
library(microeco)
library(grDevices)

# load QIIME2 rarefied phyloseq object
load("./phyloseq_obj_rq2.Rdata")

# konversi phyloseq object ke microtable
microtable_rq2 <- file2meco::phyloseq2meco(physeq_obj_rq2)

# transformasi data microtable ke taxonomic abundance
# pada tingkat spesies, dengan menampil 5 spesies teratas
tax_abund <- microeco::trans_abund$new(dataset = microtable_rq2, taxrank = "Species", ntaxa = 5)#, groupmean = "Lokasi")

# expand palet warna dari palet standar Dark2 RColorBrewer
# dari 8 warna ke 10 warna
palexpand <- grDevices::colorRampPalette(RColorBrewer::brewer.pal(8, "Dark2"))(10)

# plot barplot tumpuk
tax_abund$plot_bar(color_values = palexpand, bar_full = T, facet = "Lokasi") + 
  theme_classic() + 
  theme(axis.title.x = element_text(size = 12),axis.title.y = element_text(size = 12))

# intip data kelimpahan relatif dalam bentuk data frame
df_tax_abund <- data.frame(tax_abund[["data_abund"]])
