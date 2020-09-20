class User < ApplicationRecord

  def tests_by_level(level)
    UserTest.where(user_id: id).joins("JOIN tests ON user_tests.test_id = tests.id").where("tests.level = ?", level).pluck("tests.title")
  end
end

# user = User.first
# user1 = User.find_by(id: 1)
# user3 = User.find_by(first_name: "Дмитрий")
# user2 = User.find_by(last_name: "Петров")
#   User Load (0.2ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
# user.tests_by_level(2)
#   SELECT tests.title FROM "user_tests" JOIN tests ON user_tests.test_id = tests.id WHERE "user_tests"."user_id" = ? AND (tests.level = 2)  [["user_id", 1]]
#  => ["javascript"] 
# user.tests_by_level(1)
#    (0.2ms)  SELECT tests.title FROM "user_tests" JOIN tests ON user_tests.test_id = tests.id WHERE "user_tests"."user_id" = ? AND (tests.level = 1)  [["user_id", 1]]
#  => ["html", "flash"] 
# user.tests_by_level(3)
#    (0.3ms)  SELECT tests.title FROM "user_tests" JOIN tests ON user_tests.test_id = tests.id WHERE "user_tests"."user_id" = ? AND (tests.level = 3)  [["user_id", 1]]
#  => ["css", "php", "rails"] 
# user2.id
#  => 2 
#  user2.tests_by_level(2)
#    (4.2ms)  SELECT tests.title FROM "user_tests" JOIN tests ON user_tests.test_id = tests.id WHERE "user_tests"."user_id" = ? AND (tests.level = 2)  [["user_id", 2]]
#  => ["javascript"] 
#  user2.tests_by_level(1)
#    (0.2ms)  SELECT tests.title FROM "user_tests" JOIN tests ON user_tests.test_id = tests.id WHERE "user_tests"."user_id" = ? AND (tests.level = 1)  [["user_id", 2]]
#  => ["html", "flash"] 
#  user2.tests_by_level(3)
#    (0.3ms)  SELECT tests.title FROM "user_tests" JOIN tests ON user_tests.test_id = tests.id WHERE "user_tests"."user_id" = ? AND (tests.level = 3)  [["user_id", 2]]
#  => ["css", "php", "rails"] 
#  user2.tests_by_level(4)
#    (0.3ms)  SELECT tests.title FROM "user_tests" JOIN tests ON user_tests.test_id = tests.id WHERE "user_tests"."user_id" = ? AND (tests.level = 4)  [["user_id", 2]]
#  => [] 