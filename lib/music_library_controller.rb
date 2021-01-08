require 'pry'


class MusicLibraryController

    def initialize(path= "./db/mp3s")
        @path = path
        new_import = MusicImporter.new(@path)
        new_import.import
    end 
    
    
    def call 
        input = 
        while input != "exit"
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = gets.chomp

        # while input != "exit"
            case input 
            when "list songs"
                list_songs
            when "list artists"
                list_artists
            when "list genres"
                list_genres
            when "list artist"
                list_songs_by_artist
            when "list genre"
                list_songs_by_genre
            when "play song"
                play_song
            end
        end
    end

    def list_songs
        sorted_songs = Song.all.sort_by {|song| song.name}
        sorted_songs.uniq.each_with_index do |song,index|
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end 

    def list_artists
        all_artists = []
        Artist.all.map { |artist| all_artists << artist.name }
        sorted = []
        sorted = all_artists.sort
        all_artists.sort.each.with_index(1) do |artist,index|
            puts "#{index}. #{artist}"
        end
    end

    def list_genres
        all_genres = []
        Genre.all.map { |genre| all_genres << genre.name }
        sorted = []
        sorted = all_genres.sort
        all_genres.sort.each.with_index(1) do |genre,index|
            puts "#{index}. #{genre}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        all_songs = Song.all.select {|song| song.artist.name == input }
        sorted = all_songs.sort_by {|song| song.name}
        sorted.each.with_index(1) do |song,index|
            puts "#{index}. #{song.name} - #{song.genre.name}"
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
        all_songs = Song.all.select {|song| song.genre.name == input }
        sorted = all_songs.sort_by {|song| song.name}
        sorted.each.with_index(1) do |song,index|
            puts "#{index}. #{song.artist.name} - #{song.name}"
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        max_num = Song.all.count
        input = gets.chomp.to_i
        sorted_songs = Song.all.uniq.sort_by {|song| song.name}
        sorted_songs.each_with_index do |song,index|
            if index != 0 && index == input - 1
                puts "Playing #{song.name} by #{song.artist.name}"
            end
        end
    end

end

new_session = MusicLibraryController.new