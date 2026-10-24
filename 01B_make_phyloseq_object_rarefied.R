library(qiime2R)

# set seed selalu sama agar hasilnya bisa direproduksi
set.seed(111)

# buat phyloseq object
physeq_obj_rq2 <- qiime2R::qza_to_phyloseq(
  features="./data artifak QIIME2/rarefied_deblurtable_asv-workshop-eDNA-ikan.qza",
  taxonomy = "./data artifak QIIME2/vsearchclassification_filtseqs_merged_data-bersih-workshop-eDNA-ikan.qza", 
  tree = "./data artifak QIIME2/rootedtree_asv-workshop-eDNA-ikan.qza", 
  metadata="./data artifak QIIME2/sample-metadata-2.txt"
)

# simpan object phyloseq
save(physeq_obj_rq2, file = "./phyloseq_obj_rq2.Rdata")

