require 'pry'


class MusicLibraryController

    def initialize(path= "./db/mp3s")
        @path = path
        new_import = MusicImporter.new(@path)
        new_import.import
    end 

    def call 
        puts "Welcome to your music library!"
        input = gets.chomp
    end 

    # def list_songs
    #     Song.all
    # end 


end