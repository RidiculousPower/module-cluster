
class ::Module::Cluster::InstanceController::Stack < ::Array

  #############################
  #  insert_before_and_after  #
  #############################
  
  def insert_before_and_after( before_modules, after_modules, *modules )
  
    # we want the index before all of before_modules
    before_index = nil
    before_modules.each do |this_module|
      next_before_index = index { |this_frame| this_frame.modules && this_frame.modules.include?( this_module ) }
      before_index = next_before_index if before_index.nil? or next_before_index < before_index
    end

    # we want the index after all of after_modules
    after_index = nil
    after_modules.each do |this_module|
      next_after_index = rindex { |this_frame| this_frame.modules && this_frame.modules.include?( this_module ) }
      after_index = next_after_index if after_index.nil? or next_after_index > after_index
    end
        
    # now we need to insert
    # we have before_index and after_index (one could be nil)
    # we probably have a range between after_index and before_index

    if before_index and after_index
      # make sure that before_index is > after_index
      unless before_index > after_index
        raise ::ArgumentError, 'Requested order was impossible (before: ' << 
                before_modules.collect( & :to_s ).join( ',' ) << 
                ', after: ' << after_modules.collect( & :to_s ).join( ',' ) << ').'
      end
      insert( before_index, *modules )
    elsif before_index
      insert( before_index, *modules )
    elsif after_index
      insert( after_index + 1, *modules )
    else
      push( *modules )
    end
    
    return self
    
  end
  
end
