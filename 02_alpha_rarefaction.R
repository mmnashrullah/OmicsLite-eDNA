library(ranacapa)
library(phyloseq)
library(ggplot2)

# load non rarefied phyloseq object
load("./phyloseq_obj.Rdata")

set.seed(111) # keep result reproductive

# muat non rarefied phyloseq object kedalam data frame
physeq_df <- data.frame(phyloseq::sample_data(physeq_obj))

# plot kurva rarefaksi
ranacapa::ggrare(physeq_obj,color = "Lokasi", step = 10, label = physeq_df$Kode_sampel, plot = T, parallel = T, se = F) +
  ggplot2::scale_colour_manual(values = physeq_df$Lokasi) +
  ggplot2::geom_line(size= 1.5)
  
# cek kedalaman
kedalaman <- data.frame(phyloseq::sample_sums(physeq_obj))


get_taxa_unique(physeq_obj, "Species")

physeq_Sp <- physeq_obj %>%
  phyloseq::tax_glom(taxrank = "Species") %>%
  phyloseq::transform_sample_counts(function(x) {x/sum(x)*100} )%>%
  phyloseq::psmelt() %>%
  #dplyr::filter(Abundance >= 0.1) %>%
  dplyr::arrange(Abundance)#; physeq_Sp

ggplot(physeq_Sp, aes(x = Lokasi, y = Abundance, fill = Species)) +
  geom_bar(stat = "identity", position = "fill")

estrich <- phyloseq::estimate_richness(physeq_obj, 
                              measures = c("Observed", 
                                           "Chao1", "ACE", 
                                           "Shannon", "Simpson", 
                                           "InvSimpson", "Fisher")
                                       )
