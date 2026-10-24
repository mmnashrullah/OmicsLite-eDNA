library(ranacapa)
library(ggplot2)

# load QIIME2 rarefied phyloseq object
load("./phyloseq_obj_rq2.Rdata")

set.seed(111) # keep result reproductive

# muat non rarefied phyloseq object kedalam data frame
physeq_df <- data.frame(phyloseq::sample_data(physeq_obj_rq2))

# plot kurva rarefaksi
ranacapa::ggrare(physeq_obj_rq2,color = "Lokasi", step = 10, label = physeq_df$Kode_sampel, plot = T, parallel = T, se = F) +
  ggplot2::scale_colour_manual(values = physeq_df$Lokasi) +
  ggplot2::geom_line(size= 1.5)

# cek kedalaman
kedalaman <- data.frame(phyloseq::sample_sums(physeq_obj_rq2))
