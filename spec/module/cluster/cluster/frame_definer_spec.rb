
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
  
  context 'can create a new stack frame with the current context definition' do
    
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

  it 'can declare an instance context to apply to hook frames defined next' do
    
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
  
  it 'can declare cascading for all instances to apply to hook frames defined next' do
    
  end

  ################
  #  cascade_to  #
  ################
  
  it 'can declare a cascade context to apply to hook frames defined next' do
    
  end

  ############
  #  before  #
  ############

  it 'can declare that hook frames defined next will be inserted prior to hook frames ' do
    
  end

  ###########
  #  after  #
  ###########

  it '' do
    
  end

  #############
  #  include  #
  #############
  
  it '' do
    
  end
  
  ############
  #  extend  #
  ############

  it '' do
    
  end

  ########################
  #  include_and_extend  #
  ########################

  it '' do
    
  end

  ########################
  #  extend_and_include  #
  ########################

  it '' do
    
  end
  
  ############
  #  action  #
  ############
  
  it '' do
    
  end
    
end
