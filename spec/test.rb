require_relative '../lib/question'
require_relative '../lib/user'
require_relative '../lib/question_like'
require_relative '../lib/question_follower'
require_relative '../lib/reply'

puts "Users: "
user = User.find_by_id(2)
p question_written_by = user.authored_questions

p u = User.find_by_name("Michael", "Jackson").first
p u.authored_questions
p u.authored_replies

puts
puts "Questions: "
p question = Question.find_by_id(1)
p q = Question.find_by_author_id(2).first
p q.author
p q.replies

puts
puts "Replies: "
p reply = Reply.find_by_id(1)
p r = Reply.find_by_question_id(1).first
p Reply.find_by_user_id(3)
p r.author
p r.question
p r.parent_reply
p r.child_replies.first

puts
puts "Question Followers: "
p question_follower = QuestionFollower.find_by_id(1)
p QuestionFollower.followers_for_question_id(1)

puts
puts "Question Likes: "
p question_like     = QuestionLike.find_by_id(1)


puts
puts "followed questions for user id"
p QuestionFollower.followed_questions_for_user_id(2)

puts
puts "User#followed_questions"
p u.followed_questions

puts
puts "Question#followers"
p q.followers

puts
puts "QuestionFollower::most_followed_questions(n)"
p QuestionFollower.most_followed_questions(1)

puts "QuestionLike::likers_for_question_id(question_id)"
p QuestionLike.likers_for_question_id(1)
puts "QuestionLike::num_likes_for_question_id(question_id)"
p QuestionLike.num_likes_for_question_id(1)

puts
puts "QuestionLike::liked_questions_for_user_id(user_id)"
p QuestionLike.liked_questions_for_user_id(1)

puts
puts "Question#likers"
p q.likers
puts "Question#num_likes"
p q.num_likes
puts "User#liked_questions"
p u.liked_questions

puts
puts "average karma"
p u.average_karma


puts
puts "create"
new_user = User.new({ "fname" => "Kelly", "lname" => "Price" })
new_user.save
p new_user

puts "update"
new_user = User.new({"fname"=>"Tom", "lname"=>"Brown"})
new_user.save
p new_user

new_user.fname = "Jim"
new_user.save
p new_user


puts "Question Like save/update"
like = QuestionLike.new({ "user_id" => 1, "question_id" => 1})
like.save
p like

like.user_id = 2
like.question_id = 2
like.update
p like

