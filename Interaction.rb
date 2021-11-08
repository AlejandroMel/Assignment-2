require 'rest-client'

class Interaction
  attr_accessor :Locus_code 
  attr_accessor :Interactors
  
  
  def initialize (params = {})
    
    @Locus_code = params.fetch(:Locus_code, nil)
    @Interactors = params.fetch(:Interactors, Array.new)
    
  end
  
def filters(list)
  
  list.each do |record|
    if record[0] == record[1]
      x.delete(record)
    elsif record[2] and record[3] != "taxid:3702" 
      x.delete(record)
    elsif record[4] != "intact-miscore:0.9"
      x.delete(record)
    end 
  end 
end 
  
def get_interactors(gene_id)

interactors = []
data = []
dataint = []

response = fetch("http://bar.utoronto.ca:9090/psicquic/webservices/current/search/query/#{gene_id}?format=tab25")
  if response 
    data.append(response.body)
  end
data.each do |entry|
  entry = entry.split("\n")
    entry.each do |record|
      interaction = record.split("\t")
      interaction = interaction[2], interaction[3], interaction[9], interaction[10], interaction[14]
      dataint.append(interaction)
    end 
end
filters(dataint)
gene_id = gene_id.upcase
dataint.each do |element|
  element = element[0], element[1]
  element.each do |record|
    record = record.split(":")
    record[1] = record[1].upcase
    interactor = record[1] unless record[1] == gene_id
    interactors.append(interactor)
    end 
end
interactors -= [nil] #I have taken this code line from https://stackoverflow.com/questions/26114332/remove-nil-and-blank-string-in-an-array-in-ruby/26114449 to get rid from the nil values that report the unless function above. 
return interactors
end

end 