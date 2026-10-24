library(phyloseq)
library(qiime2R)
library(ggpubr)

# load QIIME2 rarefied phyloseq object
load("./phyloseq_obj_rq2.Rdata")

# ambil metadata dari obyek phyloseq 
# kodesampel dan lokasi_dan_nosampel
physeq_obj_rq2_samdata <- data.frame(phyloseq::sample_data(physeq_obj_rq2))
df_kodesampel <- data.frame(physeq_obj_rq2_samdata$Kode_sampel)
df_lok <- data.frame(physeq_obj_rq2_samdata$Lokasi)
df_lokasi_dan_nosampel <- data.frame(physeq_obj_rq2_samdata$Lokasi_dan_nosampel)

# buat data indeks Shannon
tab_shannon <- qiime2R::read_qza("./data artifak QIIME2/rarefied_shannon_asv-workshop-eDNA-ikan.qza")
df_tab_shannon <- data.frame(tab_shannon$data)

# buat data frame gabungan
joindf_shannon <- data.frame(
  a = c(as.list(df_kodesampel)),
  b = c(as.list(df_lok)),
  c = c(as.list(df_lokasi_dan_nosampel)),
  d = c(as.list(df_tab_shannon))
)

# ganti header kolom
colnames(joindf_shannon) <- c("Kode_sampel", "Lokasi ", "Lokasi", "Shannon")

# uji Shapiro-Wilk
ShapiroWilk_shannon <- stats::shapiro.test(joindf_shannon$Shannon)

# buat violin boxplot 
ggpubr::ggviolin(joindf_shannon, x = "Lokasi", y = "Shannon", color = "Lokasi ", palette = "Lokasi", add = c("point","boxplot"), add.params = list(fill = "white"), repel = T) + 
  ggpubr::stat_compare_means(method = "wilcox.test", label = "p.signif", label.x = 1.5, label.y = 4) + # tambah sig. levels
  ggplot2::annotate("text", x = 1, y = 5, label = "Mann-Whitney U, p > 0.05")
  #ggpubr::stat_compare_means(label.x = 0.75, label.y = 5) # tambah global the p-value
  
# tambah mean summary
#ggpubr::add_summary(layer1, "mean_sd", color = "Lokasi", size = 0.3) # tambah mean point
