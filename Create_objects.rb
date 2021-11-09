require './Gene_class.rb'
require './Interaction.rb'


def create_geneobject(openfile)
  
  genes = []
  
  File.open(openfile, "r").each do |gene_id| 
    
    gene_id = gene_id.strip 
    new_gene = Gene.new(:Locus_code => gene_id.upcase, :GO_terms => Gene.get_goterms(gene_id), :Kegg_pathways => Gene.get_keggpathways(gene_id))
    genes.append(new_gene)
  end 
return genes    
end


def create_interactionobject(openfile)
  
  interactions = []
  
  File.open(openfile, "r").each do |gene_id|
    
    gene_id = gene_id.strip
    new_gene = Interaction.new(:Locus_code => gene_id.upcase, :Interactors => Interaction.get_interactions(gene_id))
    
    interactions.append(new_gene)
  end 
return interactions    
end

