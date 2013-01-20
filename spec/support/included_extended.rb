
module ::IncludedExtended

  def included_modules?( inheriting_instance, *include_modules )
    matched = nil
    fail_string = nil    
    # check including
    include_modules.each do |this_include_module|
      if ! inheriting_instance.is_a?( ::Module ) 
        matched = false
      elsif ! matched = inheriting_instance.included_modules.include?( this_include_module )
        fail_string = 'inheriting instance did not include :' << this_include_module.name.to_s << 
                      ' (' << this_include_module.to_s << ').'
        break
      end
    end
    return matched, fail_string
  end

  def extended_modules?( inheriting_instance, *extend_modules )
    matched = nil
    fail_string = nil    
    # check extending
    extend_modules.each do |this_extend_module|
      unless matched = inheriting_instance.extended_modules.include?( this_extend_module )
        fail_string = 'inheriting instance was not extended with :' << this_extend_module.name.to_s << 
                      ' (' << this_extend_module.to_s << ').'
        break
      end
    end
    return matched, fail_string
  end

end
