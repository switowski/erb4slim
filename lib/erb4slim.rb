require 'haml2slim'
require 'html2haml'

module Erb4slim
  def self.convert input_file
    extension = File.extname(input_file)
    basename = File.basename(input_file, extension)
    full_name = File.join( File.dirname(input_file), basename)

    puts "Incorrect file type ! It should be filename.erb" if extension != ".erb"
    result = system("html2haml #{input_file} #{full_name}.haml && haml2slim #{full_name}.haml")
    if result.nil?
      puts "Error during conversion: #{$?}"
    else
      # First clean the temporary haml file
      File.delete("#{full_name}.haml") if  File.exists?("#{full_name}.haml")
      puts "File #{full_name}.slim has been successfully created"
    end
  end
  def self.recursive path
    Dir.glob("#{path}/**/*.erb") { |file| self.convert file}
  end
  def self.directory path
    Dir.glob("#{path}/*.erb") { |file| self.convert file}
  end
end