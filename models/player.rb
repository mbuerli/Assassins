# A player defines a users activity in a given game 
# Keyed by UserID, GameID

class Player 
    include DataMapper::Resource
    
    property :uid,      Integer, key: true 
    property :gid,      Integer, key: true
    property :target,   Integer

end