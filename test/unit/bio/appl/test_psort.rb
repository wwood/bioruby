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
    assert_equal Bio::PSORT::WoLF_PSORT::Report.new('gcn5a', 'plant', {'nucl' => 12, 'cyto' => 1, 'plas' => 1, 'cyto_plas' => 1}),
      Bio::PSORT::WoLF_PSORT::Report.parse_from_summary('plant', "gcn5a nucl 12, cyto 1, plas 1, cyto_plas 1")
  end
  
  def test_parse_summary_one_line_fungi
    assert_equal Bio::PSORT::WoLF_PSORT::Report.new('gcn5a', 'plant', {'cyto' => 17, 'nucl' => 9, 'cyto_pero' => 9}),
      Bio::PSORT::WoLF_PSORT::Report.parse_from_summary('plant', "gcn5a cyto 17, nucl 9, cyto_pero 9")
  end
  
  def test_amino_acid_sequence_prediction
    # catalase pero 8, nucl 2, mito 1.5, cyto_nucl 1.5, mito_plas 1.5
    assert_equal Bio::PSORT::WoLF_PSORT::Report.new('wolf', 'plant', {'pero' => 8.0, 'nucl' => 2.0, 'mito' => 1.5, 'mito_plas' => 1.5, 'cyto_nucl' => 1.5}),
      Bio::PSORT::WoLF_PSORT.exec_local_from_sequence(
      'MTQVPPVTFQQYGPVITTSAGNPVDDNQNSVTAGPYGPAILSNFHLIDKLAHFDRERIPE
RVVHAKGGGAFGYFEVTHDITRFCKAKLFEKIGKRTPVFARFSTVAGESGSADTRRDPRG
FALKFYTEEGNWDMVGNNTPIFFVRDAIKFPDFIHTQKRHPQTHLHDPNMVWDFFSLVPE
SVHQVTFLYTDRGTPDGFRHMNGYGSHTFKFINKDNEAFYVKWHFKTNQGIKNLNRQRAK
ELESEDPDYAVRDLFNAIAKREFPSWTFCIQVMPLKDAETYKWNVFDVTKVWPHGDYPLI
PVGRLVLDRNPENYFQDVEQAAFAPAHMVPGIEPSEDRMLQGRMFSYIDTHRHRLGANYH
QIPVNRPWNARGGDYSVRDGPMCVDGNKGSQLNYEPNSVDGFPKEDRNAAVSGTTTVSGT
VACHPQEHPNSDFEQPGNFYRTVLSEPEREALIGNIAEHLRQARRDIQERQVKIFYKCDP
EYGERVARAIGLPTAACYPAKM*'.gsub(/\s/,''),
      'plant'
    )
  end
  
  def test_too_small_amino_acid_sequence_prediction
    # known problem - too short?
    assert_nil Bio::PSORT::WoLF_PSORT.exec_local_from_sequence('MRTLKTEVEKGFLSTMFVQELATPKG', 'animal')
  end
  
  def test_highest_predicted_localization
    assert_equal 'cyto', Bio::PSORT::WoLF_PSORT::Report.new('gcn5a', 'plant', {'cyto' => 17, 'nucl' => 9, 'cyto_pero' => 9}).highest_predicted_localization
    assert_equal 'cyto_pero', Bio::PSORT::WoLF_PSORT::Report.new('gcn5a', 'plant', {'cyto' => 17, 'nucl' => 9, 'cyto_pero' => 90}).highest_predicted_localization
  end
end
