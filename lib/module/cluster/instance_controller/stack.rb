
class ::Module::Cluster::InstanceController::Stack < ::Array
  
  #######################
  #  index_with_module  #
  #######################
  
  def index_with_module( module_instance, include_or_extend = nil )
    
    return index do |this_frame|
      this_frame.modules                              and 
      this_frame.modules.include?( module_instance )  and
      include_or_extend.nil? || match_include_extend?( include_or_extend, this_frame.include_or_extend )
    end
    
  end

  ########################
  #  rindex_with_module  #
  ########################

  def rindex_with_module( module_instance, include_or_extend = nil )

    return rindex do |this_frame|
      this_frame.modules                              and 
      this_frame.modules.include?( module_instance )  and
      include_or_extend.nil? || match_include_extend?( include_or_extend, this_frame.include_or_extend )
    end

  end
  
  ##################
  #  index_before  #
  ##################

  def index_before( *before_descriptors )
    
    before_index = nil
    
    before_descriptors.each do |this_descriptor|
      
      case this_descriptor
        when ::Hash
          this_descriptor.each do |this_module, include_or_extend|
            next_before_index = index_with_module( this_module, include_or_extend )
            before_index = next_before_index if before_index.nil? or next_before_index < before_index
          end
        when ::Module
          next_before_index = index_with_module( this_descriptor, nil )
          before_index = next_before_index if before_index.nil? or next_before_index < before_index
      end
    
    
    end
    
    return before_index
    
  end
  
  #################
  #  index_after  #
  #################

  def index_after( *after_descriptors )

    after_index = nil
    
    after_descriptors.each do |this_descriptor|
      
      case this_descriptor
        when ::Hash
          this_descriptor.each do |this_module, include_or_extend|
            next_after_index = rindex_with_module( this_module, include_or_extend )
            after_index = next_after_index if after_index.nil? or next_after_index > after_index
          end
        when ::Module
          next_after_index = rindex_with_module( this_descriptor, nil )
          after_index = next_after_index if after_index.nil? or next_after_index > after_index
      end
        
    end
    
    after_index ||= size
    
    return after_index + 1
    
  end

  ###################
  #  insert_before  #
  ###################

  def insert_before( before_modules, *frames )
    
    before_index = index_before( before_modules )
    
    insert( before_index, *frames )
    
    return before_index
    
  end

  ##################
  #  insert_after  #
  ##################

  def insert_after( after_modules, *frames )
    
    after_index = index_after( after_modules )
    
    insert( after_index, *frames )
    
    return after_index
    
  end
  
  #############################
  #  insert_before_and_after  #
  #############################
  
  def insert_before_and_after( before_modules, after_modules, *frames )
    
    insert_index = nil

    before_index = index_before( before_modules ) unless before_modules.nil? or before_modules.empty?
    after_index = index_after( after_modules ) unless after_modules.nil? or after_modules.empty?
    
    if before_index and after_index
      # make sure that before_index is > after_index
      unless before_index > after_index
        raise ::ArgumentError, 'Requested order was impossible (before: ' << 
                before_modules.collect( & :to_s ).join( ',' ) << 
                ', after: ' << after_modules.collect( & :to_s ).join( ',' ) << ').'
      end
      insert( insert_index = before_index, *frames )
    elsif before_index
      insert( insert_index = before_index, *frames )
    elsif after_index
      insert( insert_index = after_index, *frames )
    else
      insert_index = size
      push( *frames )
    end
    
    return insert_index
    
  end

  ######################################################################################################################
      private ##########################################################################################################
  ######################################################################################################################

  ###########################
  #  match_include_extend?  #
  ###########################

  def match_include_extend?( frame_include_or_extend, against_include_or_extend )

    matched = false

    case frame_include_or_extend
      when :include
        matched = against_include_or_extend == :include                ||
                  against_include_or_extend == :include_or_extend      ||
                  against_include_or_extend == :extend_or_include      ||
                  against_include_or_extend.nil?
      when :extend
        matched = against_include_or_extend == :extend                 ||
                  against_include_or_extend == :include_or_extend      ||
                  against_include_or_extend == :extend_or_include      ||
                  against_include_or_extend.nil?
      when :include_and_extend, :extend_and_include
        matched = against_include_or_extend == frame_include_or_extend ||
                  against_include_or_extend == :include_or_extend      ||
                  against_include_or_extend == :extend_or_include      ||
                  against_include_or_extend.nil?
      end

    return matched

  end
  
end
