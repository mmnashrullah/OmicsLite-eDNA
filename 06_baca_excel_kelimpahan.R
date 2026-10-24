library(readxl)
library(stats)

# baca file excel
tab_top5gen <- readxl::read_xlsx("./tabulasi2_kelimpahan_5_top_spesies.xlsx", sheet = "Sheet1")

# uji Shapiro-Wilk
ShapiroWilk_Sm <- stats::shapiro.test(tab_top5gen$`Schizothorax macropogon_263547`)
ShapiroWilk_Cc <- stats::shapiro.test(tab_top5gen$`Cyprinus carpio_7962`)
ShapiroWilk_Pp <- stats::shapiro.test(tab_top5gen$`Pseudorasbora parva_51549`)
ShapiroWilk_Gd <- stats::shapiro.test(tab_top5gen$`Gymnocypris dobula_1077142`)
ShapiroWilk_Ca <- stats::shapiro.test(tab_top5gen$`Carassius auratus_7957`)

# ambil p-value uji Shapiro-Wilk, bulatkan ke 2 digit dibelakang koma
pval_ShapiroWilk_Sm <- round(ShapiroWilk_Sm$p.value, digits = 2)
pval_ShapiroWilk_Cc <- round(ShapiroWilk_Cc$p.value, digits = 2)
pval_ShapiroWilk_Pp <- round(ShapiroWilk_Pp$p.value, digits = 2)
pval_ShapiroWilk_Gd <- round(ShapiroWilk_Gd$p.value, digits = 2)
pval_ShapiroWilk_Ca <- round(ShapiroWilk_Ca$p.value, digits = 2)

# uji Mann-Whitney
MannWhitneyU_Sm <- stats::wilcox.test(`Schizothorax macropogon_263547` ~ Lokasi, data = tab_top5gen, conf.level = 0.95, exact = T)
MannWhitneyU_Cc <- stats::wilcox.test(`Cyprinus carpio_7962` ~ Lokasi, data = tab_top5gen, conf.level = 0.95, exact = T)
MannWhitneyU_Pp <- stats::wilcox.test(`Pseudorasbora parva_51549` ~ Lokasi, data = tab_top5gen, conf.level = 0.95, exact = T)
MannWhitneyU_Gd <- stats::wilcox.test(`Gymnocypris dobula_1077142` ~ Lokasi, data = tab_top5gen, conf.level = 0.95, exact = T)
MannWhitneyU_Ca <- stats::wilcox.test(`Carassius auratus_7957` ~ Lokasi, data = tab_top5gen, conf.level = 0.95, exact = T)

# ambil p-value uji Mann-Whitney, bulatkan ke 2 digit dibelakang koma
pval_MannWhitneyU_Sm <- round(MannWhitneyU_Sm$p.value, digits = 2)
pval_MannWhitneyU_Cc <- round(MannWhitneyU_Cc$p.value, digits = 2)
pval_MannWhitneyU_Pp <- round(MannWhitneyU_Pp$p.value, digits = 2)
pval_MannWhitneyU_Gd <- round(MannWhitneyU_Gd$p.value, digits = 2)
pval_MannWhitneyU_Ca <- round(MannWhitneyU_Ca$p.value, digits = 2)

# uji t
t_Sm <- stats::t.test(`Schizothorax macropogon_263547` ~ Lokasi, data = tab_top5gen, conf.level = 0.95, exact = T)
t_Cc <- stats::t.test(`Cyprinus carpio_7962` ~ Lokasi, data = tab_top5gen, conf.level = 0.95, exact = T)
t_Pp <- stats::t.test(`Pseudorasbora parva_51549` ~ Lokasi, data = tab_top5gen, conf.level = 0.95, exact = T)
t_Gd <- stats::t.test(`Gymnocypris dobula_1077142` ~ Lokasi, data = tab_top5gen, conf.level = 0.95, exact = T)
t_Ca <- stats::t.test(`Carassius auratus_7957` ~ Lokasi, data = tab_top5gen, conf.level = 0.95, exact = T)

# ambil p-value uji t, bulatkan ke 2 digit dibelakang koma
pval_t_Sm <- round(t_Sm$p.value, digits = 2)
pval_t_Cc <- round(t_Cc$p.value, digits = 2)
pval_t_Pp <- round(t_Pp$p.value, digits = 2)
pval_t_Gd <- round(t_Gd$p.value, digits = 2)
pval_t_Ca <- round(t_Ca$p.value, digits = 2)

# buat dataframe p-value
df_pvals <- data.frame(
  Species = c("Schizothorax macropogon_263547", "Cyprinus carpio_7962", "Pseudorasbora parva_51549", "Gymnocypris dobula_1077142", "Carassius auratus_7957"),
  pval_ShapiroWilk = c(pval_ShapiroWilk_Sm, pval_ShapiroWilk_Cc, pval_ShapiroWilk_Pp, pval_ShapiroWilk_Gd, pval_ShapiroWilk_Ca),
  pval_MannWhitneyU = c(pval_MannWhitneyU_Sm, pval_MannWhitneyU_Cc, pval_MannWhitneyU_Pp, pval_MannWhitneyU_Gd, pval_MannWhitneyU_Ca),
  pval_t = c(pval_t_Sm, pval_t_Cc, pval_t_Pp, pval_t_Gd, pval_t_Ca)
)
