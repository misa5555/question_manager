class User
  attr_accessor :id, :fname, :lname
  
  def initialize(options = {})
    @id, @fname, @lname =
      options.values_at('id', 'fname', 'lname')
  end
  
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        * 
      FROM
        users
      WHERE 
        id = (?)
    SQL
    
    results.map {|user| User.new(user) }
  end
end