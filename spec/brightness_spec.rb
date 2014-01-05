require 'brightness'

describe Brightness do
	let(:brightness) { Brightness.new }

	subject { brightness }

	it { should respond_to :increase }
end