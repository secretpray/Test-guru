module TestsHelper

  TEST_LEVELS = { 0 => :easy, 1 => :elementary, 2 => :advanced, 3 => :hard }.freeze

  def test_level(test)
    TEST_LEVELS[test.level] || :hero
  end

  def test_header(test)
    action = test.new_record? ? t('.create') : t('.update')
    "#{action}:"
  end

    def format_timer(test)
    unless test.timer.nil?

      if test.timer <= 60
        "00:" "%02d" % "#{test.timer / 60}"
      else
        test.timer * 60
        "%02d" % "#{test.timer / 60}" + ":" "%02d" % "#{test.timer % 60}"
      end
    end
  end

end
