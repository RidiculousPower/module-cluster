# -*- encoding : utf-8 -*-

class ::Class

  ####################
  #  self.inherited  #
  ####################
  
  ###
  # Override Class.inherited so that modules extending Class can define #inherited.
  #
  def self.inherited( hooked_instance )
    
    super if defined?( super )
    
  end
  
end
