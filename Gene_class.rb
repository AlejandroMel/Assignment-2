require 'rest-client'
require 'json'

class Gene
  attr_accessor :Locus_code
  attr_accessor :GO_terms
  attr_accessor :Kegg_pathways
  
    
  def initialize (params = {})
    
    @Locus_code = params.fetch(:Locus_code, 'No code')
    @GO_terms = params.fetch(:GO_terms, Array.new)
    @Kegg_pathways = params.fetch(:Kegg_pathways, Array.new)
           
  end
  
  
   
def self.get_goterms(gene_id)
  
data = []
go = []

response = fetch("http://togows.org/entry/ebi-uniprot/#{gene_id}/dr.json")
  if response 
    data.append(JSON.parse(response.body))
  end
data.each do |record|
    record.each do |entry|
      data = entry["GO"]
    end
end

if data == nil
  data = []
end 

data.each do |record|
  record[1] = record[1].split(":")
  element = record[0], record[1][1] if (record[1][0] == "P")
  go.append(element)  
end
go -= [nil]
return go
end
  
  
def self.get_keggpathways(gene_id)
  
kegg = []

response = fetch("http://togows.org/entry/kegg-genes/ath:#{gene_id}/pathways.json")
  if response 
    kegg.append(JSON.parse(response.body))
  end
return kegg[0][0]
end 



end   