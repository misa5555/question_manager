require_relative 'questions_database'
require_relative 'question'
require_relative 'table'
require_relative 'question_like'

class User < Table
  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id, @fname, @lname =
      options.values_at('id', 'fname', 'lname')
  end

  def self.find_by_id(id)
    User.find_by(<<-SQL, id).first
      SELECT
        *
      FROM
        users
      WHERE
        id = (?)
    SQL
  end

  def self.find_by_name(fname, lname)
    User.find_by(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = (?) AND lname = (?)
    SQL
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        AVG(counts) AS average
      FROM
        (SELECT
          COUNT(question_likes.user_id) as counts
        FROM
          questions
        JOIN
          question_likes ON questions.id = question_likes.question_id
        WHERE
          questions.user_id = (?)
        GROUP BY
          questions.id
      )
    SQL
    results.first["average"]
  end
end
