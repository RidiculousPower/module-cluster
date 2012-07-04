
###
# Proxies before include or extend definitions to both include and extend controllers.
#
class ::Module::Cluster::InstanceController::MultipleHookControllerProxy
    
  Name = :multiple_hook_controller_proxy
  
  ################
  #  initialize  #
  ################
  
  def initialize( name, *hook_controllers )
    
    @name = name
    
    @hook_controllers = hook_controllers
        
  end
  
  ##########
  #  name  #
  ##########
  
  attr_reader :name

  ######################
  #  hook_controllers  #
  ######################
  
  attr_reader :hook_controllers
  
  #############
  #  include  #
  #############

  def include( *modules )
    
    @hook_controllers.each do |this_hook_controller|
      this_hook_controller.include( *modules )
    end

    return self
    
  end

  ############
  #  extend  #
  ############

  def extend( *modules )

    @hook_controllers.each do |this_hook_controller|
      this_hook_controller.extend( *modules )
    end

    return self
    
  end

  ########################
  #  include_and_extend  #
  ########################

  def include_and_extend( *modules )
    
    @hook_controllers.each do |this_hook_controller|
      this_hook_controller.include_and_extend( *modules )
    end

    return self
    
  end

  ########################
  #  extend_and_include  #
  ########################

  def extend_and_include( *modules )
    
    @hook_controllers.each do |this_hook_controller|
      this_hook_controller.extend_and_include( *modules )
    end

    return self
    
  end

  ###################
  #  before_extend  #
  ###################
  
  def before_extend( *modules )
    
    return chain_proxy.before_extend( *modules )
    
  end

  ####################
  #  before_include  #
  ####################
  
  def before_include( *modules )
    
    return chain_proxy.before_include( *modules )
    
  end

  ##############################
  #  before_include_or_extend  #
  #  before_extend_or_include  #
  ##############################
  
  def before_include_or_extend( *modules )

    return chain_proxy.before_include_or_extend( *modules )
    
  end
  
  alias_method :before_extend_or_include, :before_include_or_extend
  
  ###################
  #  after_include  #
  ###################
  
  def after_include( *modules )

    return chain_proxy.after_include( *modules )
    
  end

  ##################
  #  after_extend  #
  ##################
  
  def after_extend( *modules )

    return chain_proxy.after_extend( *modules )
    
  end

  #############################
  #  after_include_or_extend  #
  #  after_extend_or_include  #
  #############################
  
  def after_include_or_extend( *modules )
    
    return chain_proxy.after_include_or_extend( *modules )
    
  end

  alias_method :after_extend_or_include, :after_include_or_extend
  
  ############
  #  action  #
  ############
  
  def action( & block )
    
    @hook_controllers.each do |this_hook_controller|
      this_hook_controller.action( & block )
    end

    return self
    
  end

  #################
  #  chain_proxy  #
  #################
  
  def chain_proxy

    return @chain_proxy ||= self.class::ChainProxy.new( self )
    
  end
  
end
