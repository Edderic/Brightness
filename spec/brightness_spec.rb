require 'spec_helper.rb'

describe Brightness do

  describe 'respond_to methods' do
    it { should respond_to :increase }
    it { should respond_to :decrease }    
  end


  describe 'command-line testing' do
    it { expect(Dir.pwd).to eq "/home/r3v3147i0n/Developer/system/brightness" }

    specify 'without any arguments' do
      command_missing_an_argument = %x{ ruby lib/brightness.rb }
      lines = File.open('logs/log.txt').readlines
      lines[0].should match(/Usage/)
    end

    context 'with correct arguments' do
      
      context '-d (decrease)' do
        before(:all) { command = %x{ ruby lib/brightness.rb -d } }
        let(:display_lines) { File.open('logs/displays_only.txt').readlines }
        let(:brightness_lines) { File.open('logs/brightness_only.txt').readlines }

        it 'should have displays and brightness levels' do
          display_lines.count.should_not eq 0
          display_lines.count.should eq brightness_lines.count 
        end
      end

      context '-i (increase)' do
        before(:all) { command = %x{ ruby lib/brightness.rb -i } }
        let(:display_lines) { File.open('logs/displays_only.txt').readlines }
        let(:brightness_lines) { File.open('logs/brightness_only.txt').readlines }

        it 'should have displays and brightness levels' do
          display_lines.count.should_not eq 0
          display_lines.count.should eq brightness_lines.count 
        end
      end

    end
  end
end