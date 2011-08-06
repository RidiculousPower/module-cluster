
module ModuleCluster::Define::DedoubleAncestors

  ####################################
  #  dedouble_modules_for_ancestors  #
  ####################################

  def dedouble_modules_for_ancestors( include_or_extend, *modules )
    
    case include_or_extend
      when :include
        modules -= ancestors
      when :extend
        eigenclass = class << self ; self ; end
        modules -= eigenclass.ancestors
    end
    
    return modules
    
  end
  
end
