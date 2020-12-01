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
    @result = check_trophy!
    if @result.any?
      @current_user.badges.push(Badge.where(rule:[@result]))
       { notice: "Вы получили награду!" }
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
    (Test.by_category('frontend') - @current_user.tests.includes(:test_passages).where( test_passages: { completed: true })).empty?
  end

  def all_category_two?
    (Test.by_category('backend') - @current_user.tests.includes(:test_passages).where( test_passages: { completed: true })).empty?
  end

  def all_level_medium?
    (Test.medium - @current_user.tests.where(level: 2..4).includes(:test_passages).where(test_passages: {completed: true})).empty?
  end

  def all_tests?
    (Test.all - @current_user.tests.includes(:test_passages).where(test_passages: {completed: true})).empty?
  end

end
