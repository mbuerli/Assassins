# Game construct, containing player profiles and other metadata

class Game 
    include DataMapper::Resource
    
    property :id,           Serial
    property :name,         String
    property :text,         String
    property :creationDate, DateTime
    property :createdBy,    Integer
    property :startDate,    DateTime
    property :endDate,      DateTime
    has n,   :profiles,     :through => Resource
end