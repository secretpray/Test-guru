class BadgeService

  HASH_RULES = [
                {:first_attemp => I18n.t('.rules_array.first_attemp')},
                {:all_category_one => I18n.t('.rules_array.all_category_one')},
                {:all_category_two => I18n.t('.rules_array.all_category_two')},
                {:all_level_medium => I18n.t('.rules_array.all_level_medium')},
                {:all_tests => I18n.t('.rules_array.all_tests')}
              ]

  def initialize(test_passage)
    @test_passage = test_passage
    @current_user = test_passage.user
    @test = test_passage.test
  end

  def call
    @new_trophy_user = check_trophy!
    if @new_trophy_user.any?
      @all_trophy_user = @current_user.badges.uniq.map { |badge| badge.rule.to_i  }
      add_trophy_user = @new_trophy_user - @all_trophy_user

      @current_user.badges.push(Badge.where(rule:[add_trophy_user]))
      notice_trophy = Badge.where(rule: add_trophy_user).pluck(:title)
      notice = ApplicationController.new.format_flash(notice_trophy)
    end
  end

  def check_trophy!
    @badges = HASH_RULES.select do |rule|
      send("#{rule.keys.join}?")
    end

    @badges.map { |badge| badge.values.join.to_i }
  end

  def first_attemp?
    @current_user.test_passages.where(test_id: @test).count == 1
  end

  def all_category_one?
    test_category = Test.by_category('frontend')
    user_test_category = @current_user.tests.includes(:test_passages)
                         .where( test_passages: { completed: true })
    (test_category - user_test_category).empty?
  end

  def all_category_two?
    test_category = Test.by_category('backend')
    user_test_category = @current_user.tests.includes(:test_passages)
                         .where( test_passages: { completed: true })
    (test_category - user_test_category).empty?
  end

  def all_level_medium?
    test_level = Test.medium
    user_test_level = @current_user.tests.where(level: 2..4)
                      .includes(:test_passages)
                      .where(test_passages: {completed: true})
    (test_level - user_test_level).empty?
  end

  def all_tests?
    all_test = Test.all
    current_user_test = @current_user.tests.includes(:test_passages)
                        .where(test_passages: {completed: true})
    (all_test - current_user_test).empty?
  end

end

