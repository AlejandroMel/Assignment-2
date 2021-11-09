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


def create_networks(list1,list2)

number_genes = list1.length
i = 0
j = 0
genes_of_list = []
 
while i < number_genes
  
puts "---------------------------------------------------------------------------------------------"
puts

  if list2[i].Interactors.length > 0  
    puts "The gene #{list1[i].Locus_code} interacts with #{list2[i].Interactors.length} gene/s"
    puts
    
      list2[i].Interactors.each do |record|
        list1.each do |gene|
          if record == gene.Locus_code
            puts "Including the gene from the list: #{gene.Locus_code}, #{gene.GO_terms}, #{gene.Kegg_pathways}"
            puts
            genes_of_list.append(record)
          end
        end 
      end
  else 
    puts "The gene #{list1[i].Locus_code} has no interactors"
    puts 
  end
  
puts "---------------------------------------------------------------------------------------------"
puts
  
i += 1 
end

if genes_of_list.length > 0
  puts "Our hypothesis is true as there are interactions between genes from the list"
end 
  
end  

genes = create_geneobject("ArabidopsisSubNetwork_GeneList.txt")
interactions = create_interactionobject("ArabidopsisSubNetwork_GeneList.txt")
create_networks(genes, interactions)

