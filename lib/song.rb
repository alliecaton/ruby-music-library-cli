require 'pry'

class Song 

    attr_accessor :name
    attr_reader :artist, :genre

@@all = []

    def initialize(name, artist= nil, genre= nil)
        @name = name 
        self.artist=(artist) if artist.class == Artist
        self.genre=(genre) if genre.class == Genre
        save
    end

    def save
        @@all << self
    end

    def self.all 
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        song = Song.new(name)
        song.save.uniq!
        song 
    end

    def artist=(artist)
        @artist = artist
        @artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        @genre.songs << self if @genre.songs.detect { |song| song == self } == nil
    end

    def self.find_by_name(song_name)
        @@all.find do |song|
            if song.name == song_name
                song
            end
        end 
    end  

    def self.find_or_create_by_name(name)
        if find_by_name(name) == nil
            create(name)
        else 
            find_by_name(name)
        end
    end

    def self.new_from_filename(filename)
        song_name = filename.split(" - ")[1]
        artist_name = filename.split(" - ")[0]
        genre_name = filename.split(" - ")[2].delete_suffix('.mp3')
        song = Song.find_or_create_by_name(song_name)
        song.genre = Genre.find_or_create_by_name(genre_name)
        song.artist = Artist.find_or_create_by_name(artist_name)
        song
    end 

    def self.create_from_filename(song)
        @@all << self.new_from_filename(song)
    end


end 