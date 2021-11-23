require './Create_objects.rb'



def fetch(url, headers = {accept: "*/*"}, user = "", pass="")
  response = RestClient::Request.execute({
    method: :get,
    url: url.to_s,
    user: user,
    password: pass,
    headers: headers})
  return response
  
  rescue RestClient::ExceptionWithResponse => e
    $stderr.puts e.inspect
    response = false
    return response  # now we are returning 'False', and we will check that with an \"if\" statement in our main code
  rescue RestClient::Exception => e
    $stderr.puts e.inspect
    response = false
    return response  # now we are returning 'False', and we will check that with an \"if\" statement in our main code
  rescue Exception => e
    $stderr.puts e.inspect
    response = false
    return response  # now we are returning 'False', and we will check that with an \"if\" statement in our main code
end


def create_networks(list1,list2,list3)
  
  #print the output of this function in an output file
  puts "Generating the output file..."
  
  output_file = File.open("Output.txt", "w")

number_genes = list1.length
i = 0
j = 0
genes_of_list = []
 
while i < number_genes
  
output_file.puts "---------------------------------------------------------------------------------------------"
output_file.puts

  if list2[i].Interactors.length > 0  
    output_file.puts "The gene #{list1[i].Locus_code} interacts with #{list2[i].Interactors.length} gene/s"
    output_file.puts
    
      list2[i].Interactors.each do |record|
        list3.each do |gene|
          if record == gene.Locus_code
            output_file.puts "Including the gene from the list: #{gene.Locus_code}, #{gene.GO_terms}, #{gene.Kegg_pathways}"
            output_file.puts
            genes_of_list.append(record)
          end
        end 
      end
  else 
    output_file.puts "The gene #{list1[i].Locus_code} has no interactors"
    output_file.puts 
  end
  
output_file.puts "---------------------------------------------------------------------------------------------"
output_file.puts
  
i += 1 
end

if genes_of_list.length > 0
  output_file.puts "Our hypothesis is true as there are interactions between genes from the list"
end 
output_file.close
puts "Done"
end



list_genes = create_geneobject("ArabidopsisSubNetwork_GeneList.txt") 
genes = create_geneobject("ArabidopsisSubNetwork_GeneList.txt")
interactions = create_interactionobject("ArabidopsisSubNetwork_GeneList.txt")
newgenes = Interaction.store_interactinggenes(interactions)
newgenes = newgenes.uniq
create_newgeneobject(newgenes,genes)
create_newinteractionobject(newgenes,interactions)
create_networks(genes,interactions,list_genes)

