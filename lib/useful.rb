class Object
  def useful?; true end
  def useless?; false end
end

class NilClass
  def useful?; false end
  def useless?; true end
end

class String
  def useful?
    ((self.length == 0) || self !~ /\S/) ? false : true
  end
  
  def useless?
    ! self.useful?
  end
end
