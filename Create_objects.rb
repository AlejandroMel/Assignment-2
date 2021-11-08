require './Gene.rb'
require './Interaction.rb'


def create_geneobject(openfile)
  
  genes_list = []
  
  File.open(openfile, "r").each do |gene_id| 
    
    gene_id = gene_id.strip 
    new_gene = Gene.new(:Locus_code => gene_id.upcase, :GO_terms => get_goterms(gene_id), :Kegg_pathways => get_keggpathways(gene_id))
    genes_list.append(new_gene)
  end 
return genes_list    
end

def create_interactionobject(openfile)
  
  list_genes = []
  
  File.open(openfile, "r").each do |gene_id|
    
    gene_id = gene_id.strip
    new_gene = Interaction.new(:Locus_code => gene_id.upcase, :Interactors => get_interactions(gene_id))
    
    list_genes.append(new_gene)
  end 
return list_genes    
end

