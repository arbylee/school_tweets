class SchoolsService
  require 'open-uri'
  require 'json'

  def get_schools
    data = JSON.parse(open('http://schools.chicagotribune.com/search.json?search-query=School').read)
    data['groupings'].each do |school_type, grouping|
      grouping.each do |school_data|
        school = School.find_or_initialize_by_isbe school_data['isbe']
        school.name = school_data['name']
        if school_data['location']
          school.latitude = school_data['location'].first
          school.longitude= school_data['location'].last
        end
        school.isbe = school_data['isbe']
        school.save
      end
    end
  end
end
