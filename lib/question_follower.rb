class QuestionFollower
  attr_accessor :id, :user_id, :question_id
  
  def initialize(options = {})
    @id, @user_id, @question_id =
       options.values_at('id', 'user_id', 'question_id')
  end
  
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        * 
      FROM
        question_followers
      WHERE 
        id = (?)
    SQL
    
    results.map do |question_followers| 
      QuestionFollower.new(question_followers)
    end
  end
end