
module ModuleCluster::Define::Block::Class
  
  ###################
  #  class_include  #
  ###################

  def class_include( & runtime_block )
    cluster_stack.class_include( runtime_block )
  end

  ##################
  #  class_extend  #
  ##################

  def class_extend( & runtime_block )
    cluster_stack.class_extend( runtime_block )
  end

  #############################
  #  class_include_or_extend  #
  #############################

  def class_include_or_extend( & runtime_block )
    class_include( & runtime_block )
    class_extend( & runtime_block )
  end

  ###########################
  #  prepend_class_include  #
  ###########################

  def prepend_class_include( & runtime_block )
    cluster_stack.prepend_class_include( runtime_block )
  end

  ##########################
  #  prepend_class_extend  #
  ##########################

  def prepend_class_extend( & runtime_block )
    cluster_stack.prepend_class_extend( runtime_block )
  end

  #####################################
  #  prepend_class_include_or_extend  #
  #####################################

  def prepend_class_include_or_extend( & runtime_block )
    prepend_class_include( & runtime_block )
    prepend_class_extend( & runtime_block )
  end
	
end
