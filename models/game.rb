class Game 
    include DataMapper::Resource
    
    property :id,       Serial, key: true, unique_index: true 
    property :name,     String
    property :text,     String
    #has n,   :assassins, 'Profile', :required => false
end