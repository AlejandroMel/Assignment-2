require './Gene_class.rb'
require './Interaction.rb'


def create_geneobject(openfile)
  
  puts "Getting all the GO terms and pathways..."
  
  genes = []
  
  File.open(openfile, "r").each do |gene_id| 
    
    gene_id = gene_id.strip 
    new_gene = Gene.new(:Locus_code => gene_id.upcase, :GO_terms => Gene.get_goterms(gene_id), :Kegg_pathways => Gene.get_keggpathways(gene_id))
    genes.append(new_gene)
  end
  puts "Done"
  puts
return genes    
end


def create_interactionobject(openfile)
  
  puts "Getting all the interactors..."
  
  interactions = []
  
  File.open(openfile, "r").each do |gene_id|
    
    gene_id = gene_id.strip
    new_gene = Interaction.new(:Locus_code => gene_id.upcase, :Interactors => Interaction.get_interactions(gene_id))
    
    interactions.append(new_gene)
  end
  puts "Done"
  puts
return interactions    
end


def create_newgeneobject(list1,list2)
  
  puts "Getting the new GO terms and pathways..."
  
  list1.each do |gene| 
    
    gene = gene.strip 
    new_gene = Gene.new(:Locus_code => gene.upcase, :GO_terms => Gene.get_goterms(gene), :Kegg_pathways => Gene.get_keggpathways(gene))
    list2.append(new_gene)
  end
  puts "Done"
  puts
return list2    
end


def create_newinteractionobject(list1,list2)
  
  puts "Getting the new interactors..."
  
  list1.each do |gene|
    
    gene = gene.strip
    new_gene = Interaction.new(:Locus_code => gene.upcase, :Interactors => Interaction.get_interactions(gene))
    
    list2.append(new_gene)
  end
  puts "Done"
  puts
return list2    
end
