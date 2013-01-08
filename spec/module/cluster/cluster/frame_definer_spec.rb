
require_relative '../../../../lib/module/cluster.rb'

describe ::Module::Cluster::Cluster::FrameDefiner do

  let( :module_instance ) { ::Module.new }

  let( :frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, :cluster_name, cascade_contexts, instance_contexts, modules, include_or_extend, block_action ) }
  let( :cascade_contexts ) { nil }
  let( :instance_contexts ) { nil }
  let( :modules ) { nil }
  let( :include_or_extend ) { nil }
  let( :block_action ) { nil }

  ######################################################################################################################
  #   private ##########################################################################################################
  ######################################################################################################################
  
  ######################
  #  add_hook_context  #
  ######################
  
  it 'can add a hook context to apply to hook frames defined next' do
    
  end
  
  ##########################
  #  add_instance_context  #
  ##########################
  
  it 'can add an instance context to apply to hook frames defined next' do
    
  end

  #########################
  #  add_cascade_context  #
  #########################
  
  it 'can add a cascade context to apply to hook frames defined next' do
    
  end
  
  #####################
  #  new_stack_frame  #
  #####################
  
  context 'creates a new stack frame with the current context definition' do
    
    context 'when no context' do
      
    end

    context 'when empty contexts' do
      
    end
    
    context 'when context contents' do
      
    end
    
  end
  
  ######################################################################################################################
  #   public ###########################################################################################################
  ######################################################################################################################
  
  #############
  #  context  #
  #############

  it 'declares an instance context to apply to hook frames defined next' do
    
  end
  
  ###########
  #  clear  #
  ###########
  
  context 'clear' do
  
    context 'when no context' do
      
    end

    context 'when empty contexts' do
      
    end
    
    context 'when context contents' do
      
    end
    
  end

  ####################
  #  before_include  #
  ####################
  
  it 'can add :before_include to hook context to apply to hook frames defined next' do
    
  end

  ###################
  #  after_include  #
  ###################
  
  it 'can add :after_include to hook context to apply to hook frames defined next' do
    
  end
  
  ###################
  #  before_extend  #
  ###################
  
  it 'can add :before_extend to hook context to apply to hook frames defined next' do
    
  end
  
  ##################
  #  after_extend  #
  ##################
  
  it 'can add :after_extend to hook context to apply to hook frames defined next' do
    
  end
  
  ##############
  #  subclass  #
  ##############
  
  it 'can add :subclass to hook context to apply to hook frames defined next' do
    
  end
  
  #############
  #  cascade  #
  #############
  
  it 'declares cascading for all instances to apply to hook frames defined next' do
    
  end

  ################
  #  cascade_to  #
  ################
  
  it 'declares a cascade context to apply to hook frames defined next' do
    
  end

  ############
  #  before  #
  ############

  it 'declares that hook frames defined next will be inserted prior to hook frames defined by modules' do
    
  end

  ###########
  #  after  #
  ###########

  it 'declares that hook frames defined next will be inserted after hook frames defined by modules' do
    
  end

  #############
  #  include  #
  #############
  
  context 'include' do
    
    it 'creates a frame causing include to be called with the provided modules and with other current context settings' do
    
    end

  end
  
  ############
  #  extend  #
  ############

  context 'extend' do
    
    it 'creates a frame causing extend to be called with the provided modules and with other current context settings' do
    
    end

  end

  ########################
  #  include_and_extend  #
  ########################

  context 'include_and_extend' do
    
    it 'creates a frame causing include and then extend to be called with the provided modules and with other current context settings' do
    
    end

  end

  ########################
  #  extend_and_include  #
  ########################

  context 'extend_and_include' do
    
    it 'creates a frame causing extend and then include to be called with the provided modules and with other current context settings' do
    
    end

  end
  
  ############
  #  action  #
  ############
  
  context 'action' do
    
    it 'creates a frame causing a block to be called and with other current context settings' do
    
    end
        
  end

end
