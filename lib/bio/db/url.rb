# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

module Bio
  # A module dedicated to providing URLs to common bioinformatic databases.
  module URLGenerators
    def pantherdb_panther_family_url(panther_id)
      "http://www.pantherdb.org/panther/family.do?clsAccession=#{panther_id}"
    end
     
    def hhmi_pfam_family_url(pfam_family_id)
      "http://pfam.janelia.org/family?entry=#{pfam_family_id}&type=Family"
    end
     
    def plasmodb_gene_url(plasmodb_id)
      "http://plasmodb.org/gene/#{plasmodb_id}"
    end
  end
  
  # Convenience class that allows easier creation of URLs.
  # Use case: I have a gene name (PF11_0344) and I want to be able to generate
  # a link to the corresponding PlasmoDB gene page, I can call Bio::URL.plasmodb_gene_url('PF11_0344')
  class URL
    # Include all the URL generators as static methods
    class << self
      include URLGenerators
    end
  end
end
