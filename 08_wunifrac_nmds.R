library(qiime2R)
library(phyloseq)
library(ggplot2)
library(ggrepel)

# load rarefied phyloseq object
load("./phyloseq_obj_rq2.Rdata")

# ordinasi wunifrac ke NMDS
dist_wunifrac_nmds <- qiime2R::read_qza("./data artifak QIIME2/rarefied_wunifrac_asv-workshop-eDNA-ikan.qza")$data
df_dist_wunifrac_nmds = data.frame(dist_wunifrac_nmds)
ordination_wunifrac_nmds = phyloseq::ordinate(physeq_obj_rq2, method = "NMDS", distance = dist_wunifrac_nmds)

# load data untuk statistik
metadata_wunifrac_nmds <- data.frame(sample_data(physeq_obj_rq2))

# statistik wunifrac NMDS (PERMANOVA)
Stat1 <- vegan::adonis2(dist_wunifrac_nmds ~ Lokasi, permutations = 9999, data = metadata_wunifrac_nmds)

# statistik wunifrac NMDS (PERMDISP)
dispersion_test <- vegan::betadisper(dist_wunifrac_nmds, group = metadata_wunifrac_nmds$Lokasi)
permutation_test <- vegan::permutest(dispersion_test, permutations = 9999)
Stat2 <- permutation_test

# lihat ordination_wunifrac_nmds ndim and stress
a <- paste("k =", ordination_wunifrac_nmds$ndim)
b <- paste("stress =", round(ordination_wunifrac_nmds$stress, digits = 2))
c <- paste(a, b, sep = "; ")

# lihat Stat1 (PERMANOVA) and Stat2 (PERMDISP) 
d <- paste("Permutation =", length(permutation_test$perm))
e1f <- paste("F = ", round((Stat1$F[1]), digits = 2))
e2p <- paste("p ", ifelse(Stat1$`Pr(>F)`[1] < 0.05,"< 0.05","> 0.05"))
e3r <- paste("R² = ", round((Stat1$R2[1]), digits = 2))
egab <- paste(e1f, e2p, e3r, sep = ", ")
e <- paste("PERMANOVA", egab, sep = " ")
f <- paste("PERMDISP p", ifelse(Stat2$statistic < 0.05,"< 0.05","> 0.05"))

# satukan semua informasi
nmds_title <- paste(c, d, e, f, sep = "; ")

# buat NMDS
phyloseq::plot_ordination(physeq_obj_rq2, ordination_wunifrac_nmds, title = nmds_title, color = "Lokasi", shape = "Lokasi") + 
  ggplot2::theme(strip.background = element_blank(), plot.title = element_text(size=12)) +
  ggplot2::guides(fill=guide_legend(title = "Lokasi")) +
  ggplot2::stat_ellipse(level = 0.95) +
  ggrepel::geom_text_repel(aes(x = NMDS1, y = NMDS2, label = Kode_sampel), size = 4, vjust = 0) 
