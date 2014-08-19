class Reply
  attr_accessor :id, :question_id, :parent_reply_id, :user_id, :body
  
  def initialize(options = {})
    @id, @question_id, @parent_reply_id, @user_id, @body =
       options.values_at('id', 'question_id', 'parent_reply_id', 'user_id', 'body')
  end
  
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        * 
      FROM
        replies
      WHERE 
        id = (?)
    SQL
    
    results.map { |reply| Reply.new(reply) }
  end
end