#! /home/r3v3147i0n/.rvm/rubies/ruby-2.0.0-p247/bin/ruby

# Brightness is used to adjust the display brightness.
# It will be executed by Keyboard shortcuts.

class Brightness
  attr_reader :brightness
  attr_reader :displays

  def initialize
    @logs_abs_path = '/home/r3v3147i0n/Developer/system/brightness/logs'
    @change = 'xrandr --output #{@displays[index]} --brightness'
    @output = 'xrandr --current --verbose | grep'
    @displays, @brightness = [],[]

    init_displays_and_brightness

    decrease if ARGV[0] == '-d'
    increase if ARGV[0] == '-i'
  end

  # SUPER+F2
  def increase
    @brightness.each_with_index do |brightness, index|
      change(brightness, index, 0.1, 'increase.txt') if brightness.to_f <= 0.9
    end
  end

  # SUPER+F1
  def decrease
    @brightness.each_with_index do |brightness, index|
      change(brightness, index, -0.1, 'decrease.txt') if brightness.to_f >= 0.1
    end
  end

  # helper

  private

  def change(brightness, index, amt, path)
    %x{ xrandr --output #{@displays[index]} --brightness #{brightness.to_f + amt} > #{@logs_abs_path}/#{path} }
  end

  def init_displays_and_brightness
    write_displays_to_file
    write_brightness_levels_to_file

    get_displays
    get_brightness
  end

  def write_displays_to_file
    %x{#{@output} ' connected' > #{@logs_abs_path}/displays_full_lines.txt}
  end

  def write_brightness_levels_to_file
    %x{#{@output} 'Brightness' > #{@logs_abs_path}/brightness_full_lines.txt}
  end

  # Refactor

  def get_displays
    get_stuff( "#{@logs_abs_path}/displays_full_lines.txt",
               "#{@logs_abs_path}/displays_only.txt",
              /^(.*?)\s/) do |displays|
      @displays << displays[0]
    end

  end

  def get_brightness
    get_stuff( "#{@logs_abs_path}/brightness_full_lines.txt",
               "#{@logs_abs_path}/brightness_only.txt",
              /\d.(\d)*/) do |brightness|
      @brightness << brightness[0]
    end
  end

  def get_stuff(filename_to_open, filename_to_save, regex)
    file_to_save = File.new(filename_to_save, 'w')
    open_lines = File.open(filename_to_open).readlines

    open_lines.each do |open_line|
      stuff = regex.match(open_line)
      file_to_save << stuff[0] << "\n"
      yield stuff
    end

    file_to_save.close
  end
end

if ARGV.length == 0 or !(ARGV[0] == '-d' or ARGV[0] == '-i')
  @abs_path = '/home/r3v3147i0n/Developer/system/brightness'
  log_file = File.new("#{@logs_abs_path}/log.txt", 'w')
  error = "Usage: (options)\n" +
           "\t-i <increase>\n" +
           "\t-d <decrease>"
  log_file.puts error
  log_file.close
  puts error
else
  Brightness.new
end
