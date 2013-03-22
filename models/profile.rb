# Metadata on a given user over an number of games
# Keyed by UserID(facebookID)

class Profile 
    include DataMapper::Resource

    property :id,       Serial, key: true, unique_index: true 
    property :name,     String, :required => true
    property :nickname, String, default: lambda { |resource,prop| resource.name.split()[0] }
    property :admin,    Boolean, :default  => true
    # Stats
    property :kills,    Integer, :default  => 0
    property :deaths,   Integer, :default  => 0
    property :score,    Integer, :default  => 0
    property :level,    Integer, :default  => 1
    # Games
    has n,   :games,    :through => Resource
end