require 'pry'
class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end 

    def path 
        @path
    end 

    def files 
        filenames = Dir.entries(@path)
        filenames.shift(2)
        filenames
    end

    def import
        files.each do |file|
            Song.create_from_filename(file)
        end
    end

end 
