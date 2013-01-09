class Profile 
    include DataMapper::Resource
    
    property :id,       Serial, key: true, unique_index: true
    property :name,     String
    property :nickname, String
end