class Question
  attr_accessor :id, :title, :body
  
  def initialize(options = {})
    @id, @title, @body =
       options.values_at('id', 'title', 'body')
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        * 
      FROM
        questions
      WHERE 
        id = (?)
    SQL
    
    results.map {|question| Question.new(question) }
  end
end