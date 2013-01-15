
# Module can't include modules properly so we have to duplicate code.

class ::Module

  ##########
  #  name  #
  ##########

  def name( name = nil )

    return_value = @name

    if name
      @name = name
      return_value = self
    end
    
    return return_value

  end

end

class ::Class

  ##########
  #  name  #
  ##########

  def name( name = nil )

    return_value = @name

    if name
      @name = name
      return_value = self
    end
    
    return return_value

  end

end

class ::Object

  ##########
  #  name  #
  ##########

  def name( name = nil )

    return_value = @name

    if name
      @name = name
      return_value = self
    end
    
    return return_value

  end

end
