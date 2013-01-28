class Game 
    include DataMapper::Resource
    
    property :id,           Serial, key: true, unique_index: true 
    property :name,         String
    property :text,         String
    property :creationDate, DateTime
    property :createdBy,    String
    property :startDate,    DateTime
    property :endDate,      DateTime
    has n,   :assassins, 'Profile', :required => false
end