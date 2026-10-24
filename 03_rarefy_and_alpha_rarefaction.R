library(qiime2R)
library(phyloseq)

# set seed selalu sama agar hasilnya bisa direproduksi
set.seed(111)

# load non rarefied phyloseq object
load("./phyloseq_obj.Rdata")

# rarefaksi pada kedalaman paling dangkal (disini 16212)
physeq_obj_rarefied <- phyloseq::rarefy_even_depth(physeq_obj, sample.size = 16212, rngseed = 111, replace = T, trimOTUs = T, verbose = T)

#simpan object phyloseq yang sudah dirarefaksi
save(physeq_obj_rarefied, file = "./phyloseq_obj_rarefied.Rdata")

#muat non rarefied phyloseq object kedalam data frame
physeq_df_rarefied <- data.frame(phyloseq::sample_data(physeq_obj_rarefied))

#plot kurva rarefaksi
ranacapa::ggrare(physeq_obj_rarefied,color = "Lokasi", step = 10, label = physeq_df_rarefied$Kode_sampel, plot = T, parallel = T, se = F) +
  ggplot2::scale_colour_manual(values = physeq_df_rarefied$Lokasi) +
  ggplot2::geom_line(size= 1.5)

# cek kedalaman
kedalaman_hasil_rarefaksi <- data.frame(phyloseq::sample_sums(physeq_obj_rarefied))
