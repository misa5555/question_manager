require_relative '../lib/question'
require_relative '../lib/user'
p question = Question.find_by_id(1)

user = User.find_by_id(2)
p question_written_by = user.authored_questions