#
# test/unit/bio/db/test_go.rb - Unit test for Bio::GO
#
# Copyright::   Copyright (C) 2005, 2008
#               Mitsuteru Nakao <n@bioruby.org>
#               Naohisa Goto <ng@bioruby.org>
# License::     The Ruby License
#
#  $Id:$
#

# loading helper routine for testing bioruby
require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 3,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'digest/sha1'
require 'bio/db/go'
require 'bio/io/flatfile'

module Bio
  class TestGeneAssociation < Test::Unit::TestCase
    
    def setup
      data = <<END_OF_DATA
WB	WBGene00000001	aap-1		GO:0005515	PMID:12520011|PMID:12654719	IEA	INTERPRO:IPR000980	F		Y110A7A.10	gene	taxon:6239	20100128	WB
WB	WBGene00000001	aap-1		GO:0005942	PMID:12520011|PMID:12654719	IEA	INTERPRO:IPR001720	C		Y110A7A.10	gene	taxon:6239	20100128	WB
WB	WBGene00000001	aap-1		GO:0035014	PMID:12520011|PMID:12654719	IEA	INTERPRO:IPR001720	F		Y110A7A.10	gene	taxon:6239	20100128	WB
END_OF_DATA
      @obj = Bio::GO::GeneAssociation.parser(data)
    end
    
    def test_records
      assert_equal(3, @obj.size)
    end
    
    def test_record_class
      assert_equal(Bio::GO::GeneAssociation, @obj[0].class)
    end
    
  end # class TestGeneAssociation
  
  class TestGeneAssociationEntry < Test::Unit::TestCase
    def setup
      data =<<END_OF_DATA
WB	WBGene00000001	aap-1		GO:0035014		IEA		F			gene	taxon:6239	20100128	WB
END_OF_DATA
      @obj = Bio::GO::GeneAssociation.new(data)
    end
    
    def test_db
      assert_equal('WB', @obj.db)
    end
    
    def test_db_object_id
      assert_equal('WBGene00000001', @obj.db_object_id)
    end
    
    def test_db_object_symbol
      assert_equal('aap-1', @obj.db_object_symbol)
    end
    
    def test_qualifier
      assert_equal('', @obj.qualifier)
    end
    
    def test_goid
      assert_equal('0035014', @obj.goid)
    end
    
    def test_db_reference
      assert_equal([], @obj.db_reference)
    end
    
    def test_evidence
      assert_equal('IEA', @obj.evidence)
    end
    
    def test_with
      assert_equal([], @obj.with)
    end
    
    def test_aspect
      assert_equal('F', @obj.aspect)
    end
    
    def test_db_object_name
      assert_equal('', @obj.db_object_name)
    end
    
    def test_db_object_synonym
      assert_equal([], @obj.db_object_synonym)
    end
    
    def test_db_object_type
      assert_equal('gene', @obj.db_object_type)
    end
    
    def test_taxon
      assert_equal('taxon:6239', @obj.taxon)
    end
    
    def test_date
      assert_equal('20100128', @obj.date)
    end
    
    def test_assigned_by
      assert_equal('WB', @obj.assigned_by)
    end
    
  end # class TestGeneAssociationEntry
  
  class TestGeneAssociationEntryFilled < Test::Unit::TestCase
    def setup
      data =<<END_OF_DATA
SGD	S000007287	15S_RRNA	blah	GO:0042255	SGD_REF:S000051605|PMID:2167435	IGI	INTERPRO:IPR001720	P	Ribosomal RNA of the small mitochondrial ribosomal subunit	15S_rRNA|15S_RRNA_2	protein	taxon:4932	20030723	SGD
END_OF_DATA
      @obj = Bio::GO::GeneAssociation.new(data)
    end
    
    def test_db
      assert_equal('SGD', @obj.db)
    end
    
    def test_db_object_id
      assert_equal('S000007287', @obj.db_object_id)
    end
    
    def test_db_object_symbol
      assert_equal('15S_RRNA', @obj.db_object_symbol)
    end
    
    def test_qualifier
      assert_equal('blah', @obj.qualifier)
    end
    
    def test_goid
      assert_equal('0042255', @obj.goid)
    end
    
    def test_db_reference
      assert_equal(['SGD_REF:S000051605','PMID:2167435'], @obj.db_reference)
    end
    
    def test_evidence
      assert_equal('IGI', @obj.evidence)
    end
    
    def test_with
      assert_equal(['INTERPRO:IPR001720'], @obj.with)
    end
    
    def test_aspect
      assert_equal('P', @obj.aspect)
    end

    def test_db_object_name
      assert_equal('Ribosomal RNA of the small mitochondrial ribosomal subunit', 
        @obj.db_object_name)
    end

    def test_db_object_synonym
      assert_equal(['15S_rRNA','15S_RRNA_2'], @obj.db_object_synonym)
    end
    
    def test_db_object_type
      assert_equal('protein', @obj.db_object_type)
    end
    
    def test_taxon
      assert_equal('taxon:4932', @obj.taxon)
    end
    
    def test_date
      assert_equal('20030723', @obj.date)
    end
    
    def test_assigned_by
      assert_equal('SGD', @obj.assigned_by)
    end
    
  end # class TestGeneAssociationEntryFilled
  
  class TestGeneAssociationFlatFile < Test::Unit::TestCase
    DataPath = Pathname.new(File.join(BioRubyTestDataPath, 'go')).cleanpath.to_s
    def setup
      @flatfile = Bio::FlatFile.new(Bio::GO::GeneAssociation, File.open(File.join(DataPath, 'gene_association.wb.head_n33')))
    end
    
    def test_next_entry
      count = 0
      begin 
        entry = @flatfile.next_entry
        count += 1
      end while !entry.nil?
    end
  end # class TestGeneAssociationFlatFile
  
end #module Bio
