
###
# @private
#
# Interface implementation for {::Module::Cluster::InstanceController Module::Cluster::InstanceController}. 
#   Implementation provided separately for ease of overloading.
#
module ::Module::Cluster::InstanceController::InstanceControllerInterface

  ################
  #  initialize  #
  ################
  
  ###
  #
  # @param instance Object instance for which Instance Controller is to operate.
  #
  def initialize( instance )
    
    @instance = instance
    
  end

  #########################
  #  subclass_controller  #
  #########################
  
  ###
  # Returns subclass hook controller.
  #
  # @return [Module::Cluster::InstanceController::HookController] Subclass hook controller.
  #
  def subclass_controller

    return @subclass_controller ||= self.class::HookController.new( :subclass, self )

  end
  
  ###############################
  #  before_include_controller  #
  ###############################
  
  ###
  # Returns before-include hook controller.
  #
  # @return [Module::Cluster::InstanceController::HookController] Before-include hook controller.
  #
  def before_include_controller

    return @before_include_controller ||= self.class::HookController.new( :before_include, self )

  end

  ##############################
  #  before_extend_controller  #
  ##############################

  ###
  # Returns before-extend hook controller.
  #
  # @return [Module::Cluster::InstanceController::HookController] Before-extend hook controller.
  #
  def before_extend_controller

    return @before_extend_controller ||= self.class::HookController.new( :before_extend, self )

  end

  #################################
  #  before_include_extend_proxy  #
  #################################
  
  ###
  # Returns a multi-controller proxy for before-include and before-extend hook controllers.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy] 
  #           Before-include-extend hook controller proxy.
  #
  def before_include_extend_proxy

    return @before_include_extend_proxy ||= self.class::MultipleHookControllerProxy.new( :before_include_extend,
                                                                                         before_include_controller,
                                                                                         before_extend_controller )

  end

  ###################################
  #  before_include_subclass_proxy  #
  ###################################
  
  ###
  # Returns a multi-controller proxy for before-include and subclass hook controllers.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy] 
  #           Before-include-subclass hook controller proxy.
  #
  def before_include_subclass_proxy

    return @before_include_subclass_proxy ||= self.class::MultipleHookControllerProxy.new( :before_include_subclass,
                                                                                           before_include_controller,
                                                                                           subclass_controller )

  end

  ##################################
  #  before_extend_subclass_proxy  #
  ##################################
  
  ###
  # Returns a multi-controller proxy for before-extend and subclass hook controllers.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy] 
  #           Before-extend-subclass hook controller proxy.
  #
  def before_extend_subclass_proxy

    return @before_extend_subclass_proxy ||= self.class::MultipleHookControllerProxy.new( :before_extend_subclass,
                                                                                          before_extend_controller,
                                                                                          subclass_controller )

  end

  ##########################################
  #  before_include_extend_subclass_proxy  #
  ##########################################
  
  ###
  # Returns a multi-controller proxy for before-include, before-extend, and subclass hook controllers.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy] 
  #           Before-include-extend-subclass hook controller proxy.
  #
  def before_include_extend_subclass_proxy

    @before_include_extend_subclass_proxy ||= self.class::
                                              MultipleHookControllerProxy.new( :before_include_extend_subclass,
                                                                               before_include_controller,
                                                                               before_extend_controller,
                                                                               subclass_controller )
    return @before_include_extend_subclass_proxy

  end
  
  ##############################
  #  after_include_controller  #
  ##############################
  
  ###
  # Returns after-include hook controller.
  #
  # @return [Module::Cluster::InstanceController::HookController] After-include hook controller.
  #
  def after_include_controller

    return @after_include_controller ||= self.class::HookController.new( :after_include, self )

  end

  #############################
  #  after_extend_controller  #
  #############################

  ###
  # Returns after-extend hook controller.
  #
  # @return [Module::Cluster::InstanceController::HookController] After-extend hook controller.
  #
  def after_extend_controller

    return @after_extend_controller ||= self.class::HookController.new( :after_extend, self )

  end

  ################################
  #  after_include_extend_proxy  #
  ################################
  
  ###
  # Returns a multi-controller proxy for after-include and after-extend hook controllers.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy] 
  #           After-include-extend hook controller proxy.
  #
  def after_include_extend_proxy

    return @after_include_extend_proxy ||= self.class::MultipleHookControllerProxy.new( :after_include_extend,
                                                                                        after_include_controller,
                                                                                        after_extend_controller )

  end

  ##################################
  #  after_include_subclass_proxy  #
  ##################################
  
  ###
  # Returns a multi-controller proxy for after-include and subclass hook controllers.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy] 
  #           After-include-subclass hook controller proxy.
  #
  def after_include_subclass_proxy

    return @after_include_subclass_proxy ||= self.class::MultipleHookControllerProxy.new( :after_include_subclass,
                                                                                          after_include_controller,
                                                                                          subclass_controller )

  end

  #################################
  #  after_extend_subclass_proxy  #
  #################################
  
  ###
  # Returns a multi-controller proxy for after-extend and subclass hook controllers.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy] 
  #           After-extend-subclass hook controller proxy.
  #
  def after_extend_subclass_proxy

    return @after_extend_subclass_proxy ||= self.class::MultipleHookControllerProxy.new( :after_extend_subclass,
                                                                                         after_extend_controller,
                                                                                         subclass_controller )

  end

  #########################################
  #  after_include_extend_subclass_proxy  #
  #########################################
  
  ###
  # Returns a multi-controller proxy for after-include, after-extend, and subclass hook controllers.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy] 
  #           After-include-extend-subclass hook controller proxy.
  #
  def after_include_extend_subclass_proxy

    @after_include_extend_subclass_proxy ||= self.class::
                                             MultipleHookControllerProxy.new( :after_include_extend_subclass,
                                                                              after_include_controller,
                                                                              after_extend_controller,
                                                                              subclass_controller )
    return @after_include_extend_subclass_proxy

  end

  ######################################################################################################################
  #   private ##########################################################################################################
  ######################################################################################################################

  ###
  # These methods are not actually in private space but are internal methods for inter-object
  # communications. They aren't intended for public interfacing.
  #

  ##############
  #  instance  #
  ##############
  
  ###
  # Get reference to object instance for which Instance Controller (self) is operative.
  #
  # @!attribute [reader] Object instance for which this Instance Controller operates.
  #
  attr_reader :instance
  
end
