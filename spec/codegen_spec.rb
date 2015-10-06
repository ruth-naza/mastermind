require_relative 'spec_helper'

#######################################################
describe Mastermind::CodeGenerator do
  before :each do
    @code_generator = Mastermind::CodeGenerator.new
  end
  describe "#new" do
    it "returns a new CodeGenerator object" do
      expect(@code_generator).to be_a Mastermind::CodeGenerator
    end
  end
end
########################################################