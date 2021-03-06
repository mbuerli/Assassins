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

    class PastTarget
        include DataMapper::Resource

        storage_names[:default] = 'player_past_target'
        belongs_to :target, 'Player', :key => true
        belongs_to :assassin, 'Player', :key => true
    end

    include DataMapper::Resource

    property :id,       Integer, key: true
    property :game,     Integer, key: true
    property :code,     String
    property :kills,    Integer, :default  => 0
    property :deaths,   Integer, :default  => 0

    has 1, :target_link, 'Player::Target', :child_key => [:assassin_id, :assassin_game]
    has 1, :assassin_link, 'Player::Target', :child_key => [:target_id, :target_game]
    has n, :friendships, 'Player::Friend', :child_key => [:assassin_id, :assassin_game]
    has n, :past_target_link, 'Player::PastTarget', :child_key => [:assassin_id, :assassin_game]

    has 1, :target, self, :through => :target_link, :via => :target
    has 1, :assassin, self, :through => :assassin_link, :via => :assassin
    has n, :friends, self, :through => :friendships, :via => :target
    has n, :past_targets, self, :through => :past_target_link, :via => :target
end