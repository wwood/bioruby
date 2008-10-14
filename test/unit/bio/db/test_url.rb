

$:.unshift File.join(File.dirname(__FILE__),['..'] * 4,'lib')

require 'test/unit'
require 'bio'

module Bio
  # Test the static methods work correctly
  class UrlTest < Test::Unit::TestCase
    def test_hhmi_pfam_family_url
      assert_equal "http://pfam.janelia.org/family?entry=PF00001&type=Family",
        Bio::URL.hhmi_pfam_family_url('PF00001')
    end
    
    def test_pantherdb_panther_family_url
      assert_equal "http://www.pantherdb.org/panther/family.do?clsAccession=PTHR10003",
        Bio::URL.pantherdb_panther_family_url('PTHR10003')
    end
    
    def test_plasmodb_gene_url
      assert_equal "http://plasmodb.org/gene/PfCRT",
        Bio::URL.plasmodb_gene_url('PfCRT')
    end
  end
  
  # Test that inclusion of the module works correctly
  class UrlGeneratorsTest < Test::Unit::TestCase
    include Bio::URLGenerators
    
    def test_module_include
      assert_equal "http://www.pantherdb.org/panther/family.do?clsAccession=PTHR10003",
        pantherdb_panther_family_url('PTHR10003')
    end
  end
end
