# Metadata on a given user over an number of games
# Keyed by UserID(facebookID)

class Profile 
    include DataMapper::Resource
    
    property :id,       Serial, key: true, unique_index: true 
    property :name,     String, :required => true
    property :nickname, String, default: lambda { |resource,prop| resource.name.split()[0] }
    has n,   :games,    :through => Resource
end