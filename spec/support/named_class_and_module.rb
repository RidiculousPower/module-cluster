
# Module can't include modules properly so we have to duplicate code.

class ::Module

  #############
  #  include  #
  #############
  
  alias_method( :original_include, :include )
  
  def include( *args )

    original_include( *args )
    
    @included_modules ||= [ ]
    
    @included_modules.concat( args )

    return self
        
  end

  ############
  #  extend  #
  ############
  
  alias_method( :original_extend, :extend )
  
  def extend( *args )
    
    original_extend( *args )
    
    @extended_modules ||= [ ]
    
    @extended_modules.concat( args )
    
    return self

  end

  ######################
  #  included_modules  #
  ######################
  
  def included_modules
    
    return @included_modules ||= [ ]
    
  end

  ######################
  #  extended_modules  #
  ######################

  def extended_modules
    
    return @extended_modules ||= [ ]
    
  end
  
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

  ############
  #  extend  #
  ############
  
  def extend( *args )

    super

    @extended_modules ||= [ ]
    
    @extended_modules.concat( args )
    
    return self
    
  end

  ######################
  #  extended_modules  #
  ######################

  def extended_modules
    
    return @extended_modules ||= [ ]
    
  end

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
