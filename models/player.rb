# A player defines a users activity in a given game 
# Keyed by UserID, GameID

class Player 
    class Target
        include DataMapper::Resource

        storage_names[:default] = 'player_target'
        belongs_to :target, 'Player', :key => true
        belongs_to :assassin, 'Player', :key => true
    end

    class Friend
        include DataMapper::Resource

        storage_names[:default] = 'player_friend'
        belongs_to :target, 'Player', :key => true
        belongs_to :assassin, 'Player', :key => true
    end

    include DataMapper::Resource

    property :id,       Serial, key: true, unique_index: true
    belongs_to :game

    has 1, :target_link, 'Player::Target', :child_key => [:assassin_id]
    has 1, :assassin_link, 'Player::Target', :child_key => [:target_id]
    has n, :friendships, 'Player::Friend', :child_key => [ :assassin_id ]

    has 1, :target, self, :through => :target_link, :via => :target
    has 1, :assassin, self, :through => :assassin_link, :via => :assassin
    has n, :friends, self, :through => :friendships, :via => :target
end