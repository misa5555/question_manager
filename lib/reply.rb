require './questions_database'
require './table'

class Reply < Table
  attr_accessor :id, :question_id, :parent_reply_id, :user_id, :body

  def initialize(options = {})
    @id, @question_id, @parent_reply_id, @user_id, @body =
       options.values_at('id', 'question_id', 'parent_reply_id', 'user_id', 'body')
  end

  def self.find_by_id(id)
    Reply.find_by(<<-SQL, id).first
      SELECT
        *
      FROM
        replies
      WHERE
        id = (?)
    SQL
  end

  def self.find_by_question_id(question_id)
    Reply.find_by(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = (?)
    SQL
  end

  def self.find_by_user_id(user_id)
    Reply.find_by(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = (?)
    SQL
  end

  def author
    User.find_one(<<-SQL, @user_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = (?)
    SQL
  end

  def question
    Question.find_one(<<-SQL, @question_id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = (?)
    SQL
  end

  def parent_reply
    Reply.find_one(<<-SQL, @parent_reply_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = (?)
    SQL
  end

  def child_replies
    Reply.find_by(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = (?)
    SQL
  end
end
