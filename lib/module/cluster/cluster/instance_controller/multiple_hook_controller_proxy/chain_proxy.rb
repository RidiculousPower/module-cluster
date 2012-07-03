
###
# A MultipleHookControllerProxy uses a MultipleHookControllerProxy::ChainProxy to chain commands that rely on chained state.
#
class ::Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy
  
  ################
  #  initialize  #
  ################
  
  def initialize( parent_multiple_hook_controller_proxy )

    @parent_multiple_hook_controller_proxy = parent_multiple_hook_controller_proxy
    
    @hook_controllers = @parent_multiple_hook_controller_proxy.hook_controllers

    @proxies = @hook_controllers.collect( & :chain_proxy )
    
  end

  #############
  #  include  #
  #############

  def include( *modules )
    
    @proxies.each do |this_hook_controller|
      this_hook_controller.include( *modules )
    end

    return self
    
  end

  ############
  #  extend  #
  ############

  def extend( *modules )

    @proxies.each do |this_hook_controller|
      this_hook_controller.extend( *modules )
    end

    return self

  end

  ########################
  #  include_and_extend  #
  ########################

  def include_and_extend( *modules )
    
    @proxies.each do |this_hook_controller|
      this_hook_controller.include_and_extend( *modules )
    end

    return self
    
  end
  
  ########################
  #  extend_and_include  #
  ########################

  def extend_and_include( *modules )
    
    @proxies.each do |this_hook_controller|
      this_hook_controller.extend_and_include( *modules )
    end

    return self
    
  end
  
  ############
  #  action  #
  ############
  
  def action( & block )
    
    @proxies.each do |this_hook_controller|
      this_hook_controller.action( & block )
    end
    
    return self
    
  end
  
  ###################
  #  before_extend  #
  ###################
  
  ###
  # @private
  #
  # Used internally by {::Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy 
  #   Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy} for setting up
  #   proxies to hook controllers.
  # 
  def before_extend( *modules )
    
    @hook_controllers.each_with_index do |this_hook_controller, this_index|
      @proxies[ this_index ] = this_hook_controller.before_extend( *modules )
    end
    
    return self
    
  end

  ####################
  #  before_include  #
  ####################
  
  ###
  # @private
  #
  # Used internally by {::Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy 
  #   Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy} for setting up
  #   proxies to hook controllers.
  # 
  def before_include( *modules )
    
    @hook_controllers.each_with_index do |this_hook_controller, this_index|
      @proxies[ this_index ] = this_hook_controller.before_include( *modules )
    end
    
    return self
    
  end

  ##############################
  #  before_include_or_extend  #
  #  before_extend_or_include  #
  ##############################
  
  ###
  # @private
  #
  # Used internally by {::Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy 
  #   Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy} for setting up
  #   proxies to hook controllers.
  # 
  def before_include_or_extend( *modules )

    @hook_controllers.each_with_index do |this_hook_controller, this_index|
      @proxies[ this_index ] = this_hook_controller.before_include_or_extend( *modules )
    end
    
    return self
    
  end
  
  alias_method :before_extend_or_include, :before_include_or_extend
  
  ###################
  #  after_include  #
  ###################
  
  ###
  # @private
  #
  # Used internally by {::Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy 
  #   Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy} for setting up
  #   proxies to hook controllers.
  # 
  def after_include( *modules )

    @hook_controllers.each_with_index do |this_hook_controller, this_index|
      @proxies[ this_index ] = this_hook_controller.after_include( *modules )
    end
    
    return self
    
  end

  ##################
  #  after_extend  #
  ##################
  
  ###
  # @private
  #
  # Used internally by {::Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy 
  #   Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy} for setting up
  #   proxies to hook controllers.
  # 
  def after_extend( *modules )

    @hook_controllers.each_with_index do |this_hook_controller, this_index|
      @proxies[ this_index ] = this_hook_controller.after_extend( *modules )
    end
    
    return self
    
  end

  #############################
  #  after_include_or_extend  #
  #  after_extend_or_include  #
  #############################
  
  ###
  # @private
  #
  # Used internally by {::Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy 
  #   Module::Cluster::Cluster::InstanceController::MultipleHookControllerProxy} for setting up
  #   proxies to hook controllers.
  # 
  def after_include_or_extend( *modules )
    
    @hook_controllers.each_with_index do |this_hook_controller, this_index|
      @proxies[ this_index ] = this_hook_controller.after_include_or_extend( *modules )
    end
    
    return self
    
  end

  alias_method :after_extend_or_include, :after_include_or_extend
  
end
