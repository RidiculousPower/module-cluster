# -*- encoding : utf-8 -*-

###
# A Stack is a specialized array for handling inserts of frames before/after other frames.
#
class ::Module::Cluster::InstanceController::Stack < ::Array
  
  #######################
  #  index_with_module  #
  #######################
  
  ###
  # Get index of frame with module instance matching include/extend descriptor.
  #
  # @param [Module] module_instance
  #
  #        Match frame with module instance.
  #
  # @param [nil,:include,:extend,:include_or_extend,
  #         :extend_or_include,:include_and_extend,:extend_and_include] include_or_extend
  # 
  #        Descriptor for matching frame :include_or_extend.
  #
  # @return [Integer]
  #
  #         Index of frame with module matching descriptor.
  #
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

  ###
  # Get rindex of frame with module instance matching include/extend descriptor.
  #
  # @param [Module] module_instance
  #
  #        Match frame with module instance.
  #
  # @param [nil,:include,:extend,:include_or_extend,
  #         :extend_or_include,:include_and_extend,:extend_and_include] include_or_extend
  # 
  #        Descriptor for matching frame :include_or_extend.
  #
  # @return [Integer]
  #
  #         Index of rightmost frame with module matching descriptor.
  #
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

  ###
  # Get index before any frame with module instances matching include/extend descriptors.
  #
  # @overload index_before( before_descriptor, ... )
  #
  #   @param [Module,
  #          Hash{Module=>:include,:extend,:include_or_extend,:extend_or_include,
  #                       :include_and_extend,:extend_and_include}] before_descriptor
  #
  #          Descriptors that index should precede.
  #
  # @return [Integer]
  #
  #         Index before any frame with module matching descriptor.
  #
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

  ###
  # Get index after any frame with module instances matching include/extend descriptors.
  #
  # @overload index_after( after_descriptor, ... )
  #
  #   @param [Module,
  #          Hash{Module=>:include,:extend,:include_or_extend,:extend_or_include,
  #                       :include_and_extend,:extend_and_include}] after_descriptor
  #
  #          Descriptors that index should precede.
  #
  # @return [Integer]
  #
  #         Index before any frame with module matching descriptor.
  #
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
  
  ###
  # Insert frames before any frame with module instances matching include/extend descriptors.
  #
  # @overload insert_before( before_descriptors, frame, ... )
  #
  #   @param [Array<Module,
  #                 Hash{Module=>:include,:extend,:include_or_extend,:extend_or_include,
  #                              :include_and_extend,:extend_and_include}>] before_descriptors
  #
  #          Descriptors that frames should precede.
  #
  #   @param [::Module::Cluster::Cluster::Frame] frame
  #
  #          Frame to insert before descriptors.
  #
  # @return [Integer]
  #
  #         Index where insert occurred.
  #
  def insert_before( before_descriptors, *frames )
    
    before_index = index_before( before_descriptors )
    
    insert( before_index, *frames )
    
    return before_index
    
  end

  ##################
  #  insert_after  #
  ##################

  ###
  # Insert frames after any frame with module instances matching include/extend descriptors.
  #
  # @overload insert_after( after_descriptors, frame, ... )
  #
  #   @param [Array<Module,
  #                 Hash{Module=>:include,:extend,:include_or_extend,:extend_or_include,
  #                              :include_and_extend,:extend_and_include}>] after_descriptors
  #
  #          Descriptors that should precede frames.
  #
  #   @param [::Module::Cluster::Cluster::Frame] frame
  #
  #          Frame to insert before descriptors.
  #
  # @return [Integer]
  #
  #         Index where insert occurred.
  #
  def insert_after( after_descriptors, *frames )
    
    after_index = index_after( after_descriptors )
    
    insert( after_index, *frames )
    
    return after_index
    
  end
  
  #############################
  #  insert_before_and_after  #
  #############################
  
  ###
  # Insert frames before any frame with module instances matching include/extend descriptors
  #   and after any frame with module instances matching other include/extend descriptors.
  #
  # @overload insert_before_and_after( before_descriptors, frame, ... )
  #
  #   @param [Array<Module,
  #                 Hash{Module=>:include,:extend,:include_or_extend,:extend_or_include,
  #                              :include_and_extend,:extend_and_include}>] before_descriptors
  #
  #          Descriptors that frames should precede.
  #
  #   @param [Array<Module,
  #                 Hash{Module=>:include,:extend,:include_or_extend,:extend_or_include,
  #                              :include_and_extend,:extend_and_include}>] after_descriptors
  #
  #          Descriptors that should precede frames.
  #
  #   @param [::Module::Cluster::Cluster::Frame] frame
  #
  #          Frame to insert before descriptors.
  #
  # @return [Integer]
  #
  #         Index where insert occurred.
  #
  def insert_before_and_after( before_descriptors, after_descriptors, *frames )
    
    insert_index = nil

    before_index = index_before( before_descriptors ) unless before_descriptors.nil? or before_descriptors.empty?
    after_index = index_after( after_descriptors )    unless after_descriptors.nil?  or after_descriptors.empty?
    
    if before_index and after_index
      # make sure that before_index is > after_index
      unless before_index > after_index
        raise ::ArgumentError, 'Requested order was impossible (before: ' << 
                before_descriptors.collect( & :to_s ).join( ',' ) << 
                ', after: ' << after_descriptors.collect( & :to_s ).join( ',' ) << ').'
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

  ###
  # Match frame include_or_extend action with provided descriptor.
  #
  # @param [:include,:extend,:include_and_extend,:extend_and_include] frame_include_or_extend
  #
  #        Action from frame :include_or_extend.
  #
  # @param [nil,:include,:extend,:include_or_extend,
  #         :extend_or_include,:include_and_extend,:extend_and_include] against_include_or_extend
  #
  #        Descriptor for matching frame :include_or_extend.
  #
  # @return [true,false]
  #
  #         Whether action matched descriptor.
  #
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
