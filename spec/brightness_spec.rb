require 'spec_helper.rb'

describe Brightness do
	let(:brightness) { Brightness.new }

	subject { brightness }

	it { should respond_to :increase }
end