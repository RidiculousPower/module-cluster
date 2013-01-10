
require_relative '../../../../lib/module/cluster.rb'

describe ::Module::Cluster::InstanceController::Stack do

  before :all do
    MockFrame = ::Struct.new( :modules, :include_or_extend )
  end
  
  let( :module_a ) { ::Module.new }
  let( :module_b ) { ::Module.new }
  let( :module_c ) { ::Module.new }
  let( :module_d ) { ::Module.new }
  let( :module_e ) { ::Module.new }
  let( :module_f ) { ::Module.new }
  let( :module_g ) { ::Module.new }
  
  let( :include_frame ) { MockFrame.new( [ module_a, module_b ], :include ) }
  let( :extend_frame ) { MockFrame.new( [ module_a, module_c, module_d, module_e ], :extend ) }
  let( :include_extend_frame ) { MockFrame.new( [ module_f ], :include_and_extend ) }
  let( :extend_include_frame ) { MockFrame.new( [ module_g ], :extend_and_include ) }
  let( :block_frame ) { MockFrame.new }

  let( :stack ) { ::Module::Cluster::InstanceController::Stack.new( [ include_frame, extend_frame, include_extend_frame, extend_include_frame, block_frame ] ) }

  context '========  Initialization  ========' do
    context '#initialize' do
      it 'is an array' do
        stack.is_a?( ::Array ).should == true
      end
    end
  end
  
  ######################################################################################################################
  #   private ##########################################################################################################
  ######################################################################################################################

  context '========  Internal Methods  ========' do

    ###########################
    #  match_include_extend?  #
    ###########################
  
    context '#match_include_extend?' do
    
      def matches?( against_value )
        matches = nil
        include_or_extend_match_value = frame_value
        stack.instance_eval do
          matches = match_include_extend?( include_or_extend_match_value, against_value )
        end
        return matches
      end
    
      context 'when :include' do
      
        let( :frame_value ) { :include }
      
        it 'should match nil' do
          matches?( nil ).should == true
        end
      
        it 'should match :include' do
          matches?( :include ).should == true
        end

        it 'should not match :extend' do
          matches?( :extend ).should == false
        end

        it 'should match :include_or_extend' do
          matches?( :include_or_extend ).should == true
        end

        it 'should match :extend_or_include' do
          matches?( :extend_or_include ).should == true
        end

        it 'should not match :include_and_extend' do
          matches?( :include_and_extend ).should == false
        end

        it 'should not match :extend_and_include' do
          matches?( :extend_and_include ).should == false
        end
      
      end

      context 'when :extend' do
      
        let( :frame_value ) { :extend }
      
        it 'should match nil' do
          matches?( nil ).should == true
        end
      
        it 'should not match :include' do
          matches?( :include ).should == false
        end

        it 'should match :extend' do
          matches?( :extend ).should == true
        end

        it 'should match :include_or_extend' do
          matches?( :include_or_extend ).should == true
        end

        it 'should match :extend_or_include' do
          matches?( :extend_or_include ).should == true
        end

        it 'should not match :include_and_extend' do
          matches?( :include_and_extend ).should == false
        end

        it 'should not match :extend_and_include' do
          matches?( :extend_and_include ).should == false
        end
      
      end
    
      context 'when :include_and_extend' do
      
        let( :frame_value ) { :include_and_extend }
      
        it 'should match nil' do
          matches?( nil ).should == true
        end
      
        it 'should not match :include' do
          matches?( :include ).should == false
        end

        it 'should not match :extend' do
          matches?( :extend ).should == false
        end

        it 'should match :include_or_extend' do
          matches?( :include_or_extend ).should == true
        end

        it 'should match :extend_or_include' do
          matches?( :extend_or_include ).should == true
        end

        it 'should match :include_and_extend' do
          matches?( :include_and_extend ).should == true
        end

        it 'should not match :extend_and_include' do
          matches?( :extend_and_include ).should == false
        end
      
      end

      context 'when :extend_and_include' do

        let( :frame_value ) { :extend_and_include }

        it 'should match nil' do
          matches?( nil ).should == true
        end

        it 'should not match :include' do
          matches?( :include ).should == false
        end

        it 'should not match :extend' do
          matches?( :extend ).should == false
        end

        it 'should match :include_or_extend' do
          matches?( :include_or_extend ).should == true
        end

        it 'should match :extend_or_include' do
          matches?( :extend_or_include ).should == true
        end

        it 'should not match :include_and_extend' do
          matches?( :include_and_extend ).should == false
        end

        it 'should match :extend_and_include' do
          matches?( :extend_and_include ).should == true
        end
      
      end
    
    end

  end
  
  ######################################################################################################################
  #   public ###########################################################################################################
  ######################################################################################################################

  context '========  Indexes  ========' do

    #######################
    #  index_with_module  #
    #######################
  
    context '#index_with_module' do
    
      context 'when include_or_extend is nil' do
      
        let( :include_or_extend ) { nil }
      
        it 'returns the first index matching module' do
          stack.index_with_module( module_a, include_or_extend ).should == stack.index( include_frame )
        end
      
      end

      context 'when include_or_extend is non-nil' do

        let( :include_or_extend ) { :extend }

        it 'returns the first index matching module where include_or_extend matches' do
          stack.index_with_module( module_a, include_or_extend ).should == stack.index( extend_frame )
        end
      
      end
    
    end

    ########################
    #  rindex_with_module  #
    ########################

    context '#rindex_with_module' do

      context 'when include_or_extend is nil' do

        let( :include_or_extend ) { nil }

        it 'returns the last index matching module' do
          stack.rindex_with_module( module_e, include_or_extend ).should == stack.rindex( extend_frame )
        end
      
      end

      context 'when include_or_extend is non-nil' do

        let( :include_or_extend ) { :extend }
      
        it 'returns the last index matching module where include_or_extend matches' do
          stack.rindex_with_module( module_e, include_or_extend ).should == stack.rindex( extend_frame )
        end
      
      end
    
    end
  
    ##################
    #  index_before  #
    ##################

    context '#index_before' do
    
      context 'when hash' do
    
        context 'when include_or_extend is nil' do
          let( :include_or_extend ) { nil }
          it 'returns the index of the first frame with module' do
            stack.index_before( module_a => include_or_extend ).should == stack.index( include_frame )
          end
        end
      
        context 'when include_or_extend is non-nil' do
          let( :include_or_extend ) { :extend }
          it 'returns the index of the first frame with module matching for condition' do
            stack.index_before( module_a => include_or_extend ).should == stack.index( extend_frame )
          end
        end
      
      end

      context 'when module' do
        it 'returns the index of the first frame with module' do
          stack.index_before( module_a ).should == stack.index( include_frame )
        end
      end
    
    end
  
    #################
    #  index_after  #
    #################

    context '#index_after' do
    
      context 'when hash' do
    
        context 'when include_or_extend is nil' do
          let( :include_or_extend ) { nil }
          it 'returns the index of the first frame with module' do
            stack.index_after( module_e => include_or_extend ).should == ( stack.rindex( extend_frame ) + 1 )
          end
        end
      
        context 'when include_or_extend is non-nil' do
          let( :include_or_extend ) { :extend }
          it 'returns the index of the first frame with module matching for condition' do
            stack.index_after( module_e => include_or_extend ).should == ( stack.rindex( extend_frame ) + 1 )
          end
        end
      
      end

      context 'when module' do
        it 'returns the index of the first frame with module' do
          stack.index_after( module_e ).should == ( stack.rindex( extend_frame ) + 1 )
        end
      end
    
    end
    
  end

  context '========  Insert  ========' do
  
    ###################
    #  insert_before  #
    ###################

    context '#insert_before' do
    
      let( :insert_before_module ) { module_a }
      let( :insert_module ) { ::Module.new }
      let( :insert_frame ) { MockFrame.new( [ insert_module ], :include ) }
    
      def inserted_before?
        insert_index = stack.insert_before( insert_before_module, insert_frame )
        stack[ insert_index ].should == insert_frame
        stack[ insert_index + 1 ].should == before_frame
      end
    
      context 'when hash' do
    
        let( :insert_before_module ) { { module_a => include_or_extend } }
    
        context 'when include_or_extend is nil' do
          let( :include_or_extend ) { nil }
          let( :before_frame ) { include_frame }
          it 'returns the index of the first frame with module' do
            inserted_before?.should == true
          end
        end
      
        context 'when include_or_extend is non-nil' do
          let( :include_or_extend ) { :extend }
          let( :before_frame ) { extend_frame }
          it 'returns the index of the first frame with module matching for condition' do
            inserted_before?.should == true
          end
        end
      
      end

      context 'when module' do
        let( :before_frame ) { include_frame }
        it 'returns the index of the first frame with module' do
          inserted_before?.should == true
        end
      end
    
    end

    ##################
    #  insert_after  #
    ##################

    context '#insert_after' do
    
      let( :insert_after_module ) { module_a }
      let( :insert_module ) { ::Module.new }
      let( :insert_frame ) { MockFrame.new( [ insert_module ], :include ) }
    
      def inserted_after?
        insert_index = stack.insert_after( insert_after_module, insert_frame )
        stack[ insert_index ].should == insert_frame
        stack[ insert_index - 1 ].should == after_frame
      end
    
      context 'when hash' do
    
        let( :insert_after_module ) { { module_a => include_or_extend } }
    
        context 'when include_or_extend is nil' do
          let( :include_or_extend ) { nil }
          let( :after_frame ) { extend_frame }
          it 'returns the index of the first frame with module' do
            inserted_after?.should == true
          end
        end
      
        context 'when include_or_extend is non-nil' do
          let( :include_or_extend ) { :extend }
          let( :after_frame ) { extend_frame }
          it 'returns the index of the first frame with module matching for condition' do
            inserted_after?.should == true
          end
        end
      
      end

      context 'when module' do
        let( :after_frame ) { extend_frame }
        it 'returns the index of the first frame with module' do
          inserted_after?.should == true
        end
      end
    
    end
  
    #############################
    #  insert_before_and_after  #
    #############################

    context '#insert_before_and_after' do
    
      let( :insert_module ) { ::Module.new }
      let( :insert_frame ) { MockFrame.new( [ insert_module ], :include ) }
      let( :insert_index ) { stack.insert_before_and_after( insert_before_modules, insert_after_modules, insert_frame ) }
      let( :verify_insert_index ) { insert_index - 1 }
    
      def inserted_before_and_after?
        stack[ verify_insert_index ].should == verify_frame
      end
        
      context 'when before and after are nil' do
        let( :insert_before_modules ) { nil }
        let( :insert_after_modules ) { nil }
        let( :verify_frame ) { block_frame }
        it 'should insert at end' do
          inserted_before_and_after?.should == true
        end
      end

      context 'when before and after are empty' do
        let( :insert_before_modules ) { [ ] }
        let( :insert_after_modules ) { [ ] }
        let( :verify_frame ) { block_frame }
        it 'should insert at end' do
          inserted_before_and_after?.should == true
        end
      end

      context 'when before has modules and after is empty' do
        let( :insert_before_modules ) { { module_d => :extend } }
        let( :insert_after_modules ) { [ ] }
        let( :verify_frame ) { include_frame }
        it 'should insert before modules' do
          inserted_before_and_after?.should == true
        end
      end
    
      context 'when before is empty and after has modules' do
        let( :insert_before_modules ) { [ ] }
        let( :insert_after_modules ) { { module_e => :extend } }
        let( :verify_frame ) { extend_frame }
        it 'should insert after modules' do
          inserted_before_and_after?.should == true
        end
      end

      context 'when before and after have modules' do
        let( :insert_before_modules ) { [ module_f ] }
        let( :insert_after_modules ) { { module_e => :extend } }
        let( :verify_frame ) { extend_frame }
        it 'should insert before and after modules' do
          inserted_before_and_after?.should == true
        end
      end

      context 'when before and after are not compatible' do
        let( :insert_before_modules ) { { module_e => :extend } }
        let( :insert_after_modules ) { [ module_d ] }
        it 'should raise an exception' do
          ::Proc.new { inserted_before_and_after? }.should raise_error( ::ArgumentError )
        end
      end
    
    end
    
  end
  
end
