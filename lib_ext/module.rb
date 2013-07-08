# -*- encoding : utf-8 -*-

class ::Module

  ##############################
  #  original_append_features  #
  ##############################
  
  alias_method :original_append_features, :append_features
  
  #####################
  #  append_features  #
  #####################
  
  ###
  # Override Module.included so that modules extending Module can define #included.
  #
  def append_features( hooked_instance )
    
    original_append_features( hooked_instance )
    super if defined?( super )
    
  end

  ##############
  #  included  #
  ##############
  
  ###
  # Override Module.included so that modules extending Module can define #included.
  #
  def included( hooked_instance )
    
    super if defined?( super )
    
  end

  ############################
  #  original_extend_object  #
  ############################
  
  alias_method :original_extend_object, :extend_object

  ###################
  #  extend_object  #
  ###################

  ###
  # Override Module.extended so that modules extending Module can define #extended.
  #
  def extend_object( hooked_instance )

    original_extend_object( hooked_instance )
    super if defined?( super )
    
  end

  ##############
  #  extended  #
  ##############

  ###
  # Override Module.extended so that modules extending Module can define #extended.
  #
  def extended( hooked_instance )

    super if defined?( super )
    
  end
  
end
