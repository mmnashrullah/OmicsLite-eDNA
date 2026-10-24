library(file2meco)
library(microeco)
library(writexl)

# load QIIME2 rarefied phyloseq object
load("./phyloseq_obj_rq2.Rdata")

# konversi phyloseq object ke microtable
microtable_rq2 <- file2meco::phyloseq2meco(physeq_obj_rq2)

# transformasi data microtable ke taxonomic abundance
# pada tingkat spesies, dengan menampil 5 spesies teratas
tax_abund <- microeco::trans_abund$new(dataset = microtable_rq2, taxrank = "Species", ntaxa = 5)#, groupmean = "Lokasi")

# intip data kelimpahan relatif dalam bentuk data frame
df_tax_abund <- data.frame(tax_abund[["data_abund"]])

# rubah dataframe jadi excel
writexl::write_xlsx(df_tax_abund, "./tabel_kelimpahan_seluruh_spesies.xlsx")
