module TestsHelper

  TEST_LEVELS = { 0 => :easy, 1 => :elementary, 2 => :advanced, 3 => :hard }.freeze

  def test_level(test)
    TEST_LEVELS[test.level] || :hero
  end

  def test_header(test)
    action = test.new_record? ? 'Create new' : 'Edit'
    "#{action} test: #{test.title}"
  end
end
