class UsersBadge < ApplicationRecord

  belongs_to :user
  belongs_to :badge


  def check_all_rules(current_user, test_id)
    
    rules_array = []
    
    rules_array << 1 if current_user.test_passages.where(test_id: test_id).count == 1
    rules_array << 2 if (Test.by_category('frontend') - current_user.tests.includes(:test_passages).where( test_passages: { completed: true })).empty?
    rules_array << 3 if (Test.by_category('backend') - current_user.tests.includes(:test_passages).where( test_passages: { completed: true })).empty?
    rules_array << 4 if (Test.medium - current_user.tests.where(level: 2..4).includes(:test_passages).where(test_passages: {completed: true})).empty?
    rules_array << 5 if (Test.all - current_user.tests.includes(:test_passages).where(test_passages: {completed: true})).empty?

    rules_array
  end

end
