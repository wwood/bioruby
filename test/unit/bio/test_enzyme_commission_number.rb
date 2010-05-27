#
# test/unit/bio/test_enzyme_commission_number.rb - Unit test for Bio::EnzymeCommissionNumber
#
# Copyright::  Copyright (C) 2005 Mitsuteru Nakao <n@bioruby.org>
# License::    The Ruby License
#
#  $Id:$
#

# loading helper routine for testing bioruby
require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 2,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'bio/enzyme_commission'

module Bio
  class EnzymeCommissionNumberTest < Test::Unit::TestCase
    
    def test_ec_number
      ec = Bio::EnzymeCommissionNumber.new('1.2.3')
      assert_equal '1.2.3', ec.ec_number
    end
    
    def test_malformed_ec
      assert_raise MalformedEnzymeCommissionNumberException do
        ec = Bio::EnzymeCommissionNumber.new('1.2.no')
      end
    end
    
    def test_malformed_ec2
      assert_raise MalformedEnzymeCommissionNumberException do
        ec = Bio::EnzymeCommissionNumber.new('1.2.3.4.5')
      end
    end
    
    def test_fineness_three
      assert_equal 3, Bio::EnzymeCommissionNumber.new('1.2.5').fineness
    end
    
    def test_fineness_four
      assert_equal 4, Bio::EnzymeCommissionNumber.new('1.2.5.1').fineness
    end
    
    def test_to_s
      assert_equal '1.2.1.3', Bio::EnzymeCommissionNumber.new('1.2.1.3').to_s
    end
  end
end