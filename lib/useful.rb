class NilClass
  def useful?
    false
  end
end

class String
  def useful?
    ((self.length == 0) || self !~ /\S/) ? false : true
  end
end

class Fixnum
  def useful?; true end
end

class Float
  def useful?; true end
end
