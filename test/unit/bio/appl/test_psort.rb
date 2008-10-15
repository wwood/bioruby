#
# test/unit/bio/appl/test_psort.rb - Unit test for Bio::WoLF_PSORT
#
# Copyright::   Copyright (C) 2008
#               Ben J Woodcroft <donttrustben somewhere near gmail.com>
# License::     The Ruby License
#

require 'pathname'
libpath = Pathname.new(File.join(File.join(File.dirname(__FILE__), ['..'] * 4, 'lib'))).cleanpath.to_s
$:.unshift(libpath) unless $:.include?(libpath)

require 'test/unit'
require 'bio/appl/psort'

class WoLFPsortTest < Test::Unit::TestCase
  def test_parse_summary_line_nil
    assert_nil Bio::PSORT::WoLF_PSORT::Report.parse_from_summary('plant', "# k used for kNN is: 14\n")
  end
  
  def test_parse_summary_one_line
    assert_equal Bio::PSORT::WoLF_PSORT::Report.new('gcn5a', 'plant', 12, 1, 1, 1),
      Bio::PSORT::WoLF_PSORT::Report.parse_from_summary('plant', "gcn5a nucl 12, cyto 1, plas 1, cyto_plas 1")
  end
  
  def test_parse_summary_one_line_fungi
    assert_equal Bio::PSORT::WoLF_PSORT::Report.new('gcn5a', 'plant', 12, 1, 1, 1),
      Bio::PSORT::WoLF_PSORT::Report.parse_from_summary('plant', "gcn5a cyto 17, nucl 9, cyto_pero 9")
  end
end
