# Course construct, for players' schedules

class Course 
    include DataMapper::Resource
    
    property :id,           Serial
    property :name,         String
    property :description,  String
    property :location,     String
    property :daysOfWeek,   String
    property :startTime,    String
    property :endTime,      String

    has n,   :profiles,     :through => Resource
end