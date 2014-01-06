# Brightness is used to adjust the display brightness.
# It will be executed by Keyboard shortcuts.


class Brightness
  attr_reader :brightness
  attr_reader :displays

  if ARGV.length == 0 and !(ARGV[0] == '-d' or ARGV[0] == '-i')
    log_file = File.new('log.txt', 'w')
    error = "Usage: (options)\n" +
             "\t-i <increase>\n" + 
             "\t-d <decrease>" 
    log_file.puts error
    puts error
    log_file.close
  else
    self.new
  end

  def initialize
    unless ARGV.length == 0 
      ARGV.each { |arg| puts "#{arg}" }


      @command_line = 'xrandr --current --verbose | grep'
      @displays, @brightness = [],[]

      write_displays_to_file
      write_brightness_levels_to_file

      get_displays
      get_brightness

      decrease if ARGV[0] == '-d' 
      increase if ARGV[0] == '-i' 
    end
  end

  # SUPER+F2
  def increase
    @brightness.each_with_index do |brightness, index|
      if @brightness[i] <= 0.9
        %x{ xrandr --output #{@displays[index]} --brightness #{@brightness[index] + 0.1} > increase.txt }
      end
    end
  end

  # SUPER+F1
  def decrease
    @brightness.each_with_index do |brightness, index|
      if @brightness[i] >= 0.1
        %x{ xrandr --output #{@displays[index]} --brightness #{@brightness[index] - 0.1} > decrease.txt }
      end
    end
  end

  # helper

  private

  def write_displays_to_file
    %x{#{@command_line} ' connected' > displays_full_lines.txt}
  end 

  def write_brightness_levels_to_file
    %x{#{@command_line} 'Brightness' > brightness_full_lines.txt}
  end

  # Refactor

  def get_displays
    get_stuff('displays_full_lines.txt', 'displays_only.txt', /^(.*?)\s/) do |displays|
      @displays << displays[0]
    end

  end

  def get_brightness
    get_stuff('brightness_full_lines.txt', 'brightness_only.txt', /\d.(\d)*/) do |brightness|
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