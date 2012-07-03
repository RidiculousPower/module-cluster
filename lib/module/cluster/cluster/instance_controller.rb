
###
# @private
#
# Controls event hook stacks for a given Module or Class instance.
#   Holds controllers for before and after include and extend and after subclass events. 
#   Controllers hold action stacks, which include/extend modules, perform block actions, 
#   or cascade actions to an inheriting instance.
#
class ::Module::Cluster::Cluster::InstanceController
  
  ################
  #  initialize  #
  ################
  
  def initialize( instance_cluster )
    
    @instance_cluster = instance_cluster
    
  end
  
  ###############################
  #  before_include_controller  #
  ###############################
  
  def before_include_controller

    return @before_include_controller ||= self.class::HookController.new( :before_include, self )

  end

  ##############################
  #  before_extend_controller  #
  ##############################

  def before_extend_controller

    return @before_extend_controller ||= self.class::HookController.new( :before_extend, self )

  end

  #################################
  #  before_include_extend_proxy  #
  #################################
  
  def before_include_extend_proxy

    return @before_include_extend_proxy ||= self.class::MultipleHookControllerProxy.new( :before_include_extend,
                                                                                         before_include_proxy,
                                                                                         before_extend_proxy )

  end

  ###################################
  #  before_include_subclass_proxy  #
  ###################################
  
  def before_include_subclass_proxy

    return @before_include_subclass_proxy ||= self.class::MultipleHookControllerProxy.new( :before_include_subclass,
                                                                                           before_include_proxy,
                                                                                           before_extend_proxy )

  end

  ##################################
  #  before_extend_subclass_proxy  #
  ##################################
  
  def before_extend_subclass_proxy

    return @before_extend_subclass_proxy ||= self.class::MultipleHookControllerProxy.new( :before_extend_subclass,
                                                                                          before_include_proxy,
                                                                                          before_extend_proxy )

  end

  ##########################################
  #  before_include_extend_subclass_proxy  #
  ##########################################
  
  def before_include_extend_subclass_proxy

    @before_include_extend_subclass_proxy ||= self.class::
                                              MultipleHookControllerProxy.new( :before_include_extend_subclass,
                                                                               before_include_proxy,
                                                                               before_extend_proxy )
    return @before_include_extend_subclass_proxy

  end
  
  ##############################
  #  after_include_controller  #
  ##############################
  
  def after_include_controller

    return @after_include_controller ||= self.class::HookController.new( :after_include, self )

  end

  #############################
  #  after_extend_controller  #
  #############################

  def after_extend_controller

    return @after_extend_controller ||= self.class::HookController.new( :after_extend, self )

  end

  ################################
  #  after_include_extend_proxy  #
  ################################
  
  def after_include_extend_proxy

    return @after_include_extend_proxy ||= self.class::MultipleHookControllerProxy.new( :after_include_extend,
                                                                                        after_include_proxy,
                                                                                        after_extend_proxy )

  end

  ##################################
  #  after_include_subclass_proxy  #
  ##################################
  
  def after_include_subclass_proxy

    return @after_include_subclass_proxy ||= self.class::MultipleHookControllerProxy.new( :after_include_subclass,
                                                                                          after_include_proxy,
                                                                                          after_extend_proxy )

  end

  #################################
  #  after_extend_subclass_proxy  #
  #################################
  
  def after_extend_subclass_proxy

    return @after_extend_subclass_proxy ||= self.class::MultipleHookControllerProxy.new( :after_extend_subclass,
                                                                                         after_include_proxy,
                                                                                         after_extend_proxy )

  end

  #########################################
  #  after_include_extend_subclass_proxy  #
  #########################################
  
  def after_include_extend_subclass_proxy

    @after_include_extend_subclass_proxy ||= self.class::
                                             MultipleHookControllerProxy.new( :after_include_extend_subclass,
                                                                              after_include_proxy,
                                                                              after_extend_proxy )
    return @after_include_extend_proxy

  end
  
end
