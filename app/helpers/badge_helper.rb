module BadgeHelper

  def select_rules
    BadgeService::HASH_RULES.map { |i| i.values.join }
  end

end
