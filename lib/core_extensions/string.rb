class String
  GIVEN_NAME_PREFIXES = %w(The A An)
  def given_name
    return self if self.blank?
    names = self.squish.split(" ")
    if names.size <= 1 || names.first.in?(GIVEN_NAME_PREFIXES)
      return self.squish
    else
      return names.first
    end
  end

  POSSESSIVE_APPOSTROPHE = "’";
  def possessive
    self + ("s" == self[-1,1] ? POSSESSIVE_APPOSTROPHE : POSSESSIVE_APPOSTROPHE+"s")
  end
end