

class Genre
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
            genre = Genre.new(name)
            genre.save.uniq!
            self
        end

        def songs
            @songs
        end

        def artists
            self.songs.collect do |song|
                song.artist
            end.uniq
        end

        def add_song(song)
            song.genre = self unless song.genre == self
            @songs << song unless @songs.include?(song)
        end

end 