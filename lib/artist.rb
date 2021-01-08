

class Artist 
    extend Concerns::Findable

    attr_accessor :name

@@all = []

    def initialize(name)
        @name = name 
        @songs = []
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
        artist = Artist.new(name)
        artist.save.uniq!
        artist
    end

    def songs
        @songs
    end

    def add_song(song)
        song.artist = self unless song.artist == self
        @songs << song unless @songs.include?(song)
      end

    def genres
        self.songs.collect do |song|
            song.genre
        end.uniq
    end

end 
