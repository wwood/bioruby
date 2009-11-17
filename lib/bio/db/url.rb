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
    
    def pdb_url(pdbId)
      "http://www.rcsb.org/pdb/cgi/explore.cgi?pdbId=#{pdbId}"
    end
   
    def pdbsum_url(pdbId)
      "http://www.ebi.ac.uk/thornton-srv/databases/cgi-bin/pdbsum/GetPage.pl?pdbcode=#{pdbId}"
    end
   
    def cath_url(pdbId)
      "http://cathwww.biochem.ucl.ac.uk/cgi-bin/cath/SearchPdb.pl?query=#{pdbId}&type=PDB"
    end
   
    def scop_url(pdbId)
      "http://scop.mrc-lmb.cam.ac.uk/scop/pdb.cgi?disp=scop&id=#{pdbId}"
    end

    def pubmed_url(pubmed_id)
      "http://www.ncbi.nlm.nih.gov/PubMed?term=#{pubmed_id}"
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
