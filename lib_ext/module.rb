# -*- encoding : utf-8 -*-

class ::Module

  ###################
  #  self.included  #
  ###################
  
  ###
  # Override Module.included so that modules extending Module can define #included.
  #
  def self.included( hooked_instance )
    
    super if defined?( super )
    
  end

  ###################
  #  self.extended  #
  ###################

  ###
  # Override Module.extended so that modules extending Module can define #extended.
  #
  def self.extended( hooked_instance )

    super if defined?( super )
    
  end
  
end
