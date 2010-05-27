#
# = bio/ec.rb - Classes for Enzyme Commission
#
# Copyright::   Copyright (C) 2010 
#               Mitsuteru C. Nakao <n@bioruby.org>
# License::     The Ruby License
#
# == Enzyme Commission
# an EC 
#
# == Example
#
# == References
#

module Bio
  # A class to represent an EC number, for instance 
  class EnzymeCommissionNumber
    # a String representation of the EC number. E.g. '2.3.4.1'
    attr_accessor :ec_number
    
    # Create a new EnzymeCommission commission instance with
    # an EC number specified. Throws an exception if
    def initialize(ec_number)
      @ec_number = EnzymeCommissionNumber.split(ec_number).join('.')
    end
    
    # Split up an EC number into an array of components,
    # where each component is an integer from the EC number.
    # E.g. split(1.2.3.4) => [1,2,3,4]
    def self.split(ec_number)
      splits = ec_number.split('.')
      # reject malformed EC numbers
      unless splits.length <= 4 and 
        splits.length > 0
        raise Bio::MalformedEnzymeCommissionNumberException, ec_number
      end
      
      result = splits.collect {|s| s.to_i}
      # reject numbers for different reasons
      result.each do |e|
        if e < 1
          raise Bio::MalformedEnzymeCommissionNumberException, ec_number       
        end
      end
      
      return result
    end
    
    # Return how fine the classification of this EC number is,
    # in terms of the number of numbers in the EC identifier. 
    # For instance 5.2.3.4 will return 4, whereas 5.2.3 will return 3 
    def fineness
      EnzymeCommissionNumber.split(@ec_number).length
    end
    
    def to_s
      @ec_number
    end
  end
  
  class MalformedEnzymeCommissionNumberException < Exception
    def initialize(ec_number)
      @bad_ec = ec_number
      super
    end
    
    def to_s
      "Malformed enzyme commision number detected: '#{@bad_ec}'"
    end
  end
end