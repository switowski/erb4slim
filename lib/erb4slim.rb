require 'haml2slim'
require 'html2haml'

module Erb4slim
  def self.convert(input_file, delete = false, verbose = false)
    extension = File.extname(input_file)
    basename = File.basename(input_file, extension)
    full_name = File.join(File.dirname(input_file), basename)

    puts 'Incorrect file type ! It should be filename.erb' if extension != '.erb'
    result = system("html2haml #{input_file} #{full_name}.haml && haml2slim #{full_name}.haml")
    if result.nil?
      puts "Error during conversion: #{$?}"
    else
      # First clean the temporary haml file
      File.delete("#{full_name}.haml") if File.exist?("#{full_name}.haml")
      puts "File #{full_name}.slim has been successfully created" if verbose
      # Remove the input file if needed
      File.delete(input_file) if delete
    end
  end

  def self.recursive(path, delete = false, verbose = false)
    path = _normalize_path(path)
    Dir.glob("#{path}/**/*.erb") { |file| convert(file, delete, verbose) }
  end

  def self.all(path, delete = false, verbose = false)
    path = _normalize_path(path)
    Dir.glob("#{path}/*.erb") { |file| convert(file, delete, verbose) }
  end

  def self._normalize_path(path)
    path.gsub(/\/$/, '')
  end
end
