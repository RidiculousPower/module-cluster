# -*- encoding : utf-8 -*-

class ::Class

  ###############
  #  inherited  #
  ###############
  
  ###
  # Override Class.inherited so that modules extending Class can define #inherited.
  #
  def inherited( hooked_instance )
    
    super if defined?( super )
    
  end
  
end
