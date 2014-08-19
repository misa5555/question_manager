class QuestionLike
  attr_accessor :id, :user_id, :question_id
  
  def initialize(options = {})
    @id, @user_id, @question_id=
       options.values_at('id', 'user_id', 'question_id')
  end
  
 def self.find_by_id(id)
   QuestionsDatabase.instance.execute(<<-SQL, id)
     SELECT 
       * 
     FROM
       question_likes
     WHERE 
       id = (?)
     SQL
  end
end