
require_relative '../../lib/module/cluster.rb'

#########################
#  non-cascading hooks  #
#########################

# blocks

describe ::Module::Cluster do
  
  before :all do
    
    class TestState
      def clear
        @before_include_block_ran = false
        @after_include_block_ran = false
        @before_extend_block_ran = false
        @after_extend_block_ran = false
        @subclass_block_ran = false
      end
      def before_include_block_ran!( instance )
        instance.nil?.should == false
        @before_include_block_ran = true
      end
      def after_include_block_ran!( instance )
        instance.nil?.should == false
        @after_include_block_ran = true
      end
      def before_extend_block_ran!( instance )
        instance.nil?.should == false
        @before_extend_block_ran = true
      end
      def after_extend_block_ran!( instance )
        instance.nil?.should == false
        @after_extend_block_ran = true
      end
      def subclass_block_ran!( instance )
        instance.nil?.should == false
        @subclass_block_ran = true
      end
      def before_include_block_ran? ; return @before_include_block_ran ; end
      def after_include_block_ran? ; return @after_include_block_ran ; end
      def before_extend_block_ran? ; return @before_extend_block_ran ; end
      def after_extend_block_ran? ; return @after_extend_block_ran ; end
      def subclass_block_ran? ; return @subclass_block_ran ; end
    end
    
    @test_state = test_state = TestState.new
    
    # module-only hooks
    @module_cluster_define_block = module_cluster_define_block = ::Proc.new do
      extend ::Module::Cluster
      cluster( :cluster_name ).instance_eval do
        before_include { |instance| test_state.before_include_block_ran!( instance ) }
        after_include { |instance| test_state.after_include_block_ran!( instance ) }
        before_extend { |instance| test_state.before_extend_block_ran!( instance ) }
        after_extend { |instance| test_state.after_extend_block_ran!( instance ) }
      end
    end
    
    # class hooks
    class_cluster_define_block = ::Proc.new do
      extend ::Module::Cluster
      subclass_block_ran = false
      cluster( :cluster_name ).subclass { |instance | test_state.subclass_block_ran!( instance ) }
    end
    
    # combined hooks
    combined_cluster_define_block = ::Proc.new do
      module_eval( & module_cluster_define_block )
      module_eval( & class_cluster_define_block )
    end

    ModuleMock = ::Module.new( & combined_cluster_define_block )
    ClassMock = ::Class.new( & class_cluster_define_block )
    ModuleClassMock = ::Class.new( ::Module, & combined_cluster_define_block )
    ModuleClassMockInstance = ModuleClassMock.new
    
  end
  
  before :each do
    @test_state.clear
  end

  ###################
  #  include hooks  #
  ###################

  it 'an include hook on a module can run before or after module is included by a module' do
    ::Module.new { include ::ModuleMock }
    @test_state.before_include_block_ran?.should == true
    @test_state.after_include_block_ran?.should == true
    @test_state.before_extend_block_ran?.should == false
    @test_state.after_extend_block_ran?.should == false
    @test_state.after_extend_block_ran?.should == false
    @test_state.subclass_block_ran?.should == false
  end

  it 'an include hook on a module can run before or after module is included by a class' do
    ::Class.new { include ::ModuleMock }
    @test_state.before_include_block_ran?.should == true
    @test_state.after_include_block_ran?.should == true
    @test_state.before_extend_block_ran?.should == false
    @test_state.after_extend_block_ran?.should == false
    @test_state.subclass_block_ran?.should == false
  end

  it 'an include hook on a module can run before or after instance of module subclass is included by a module' do
    ::Module.new { include ::ModuleClassMockInstance }
    @test_state.before_include_block_ran?.should == true
    @test_state.after_include_block_ran?.should == true
    @test_state.before_extend_block_ran?.should == false
    @test_state.after_extend_block_ran?.should == false
    @test_state.subclass_block_ran?.should == false
  end

  it 'an include hook on a module can run before or after instance of module subclass is included by a class' do
    ::Class.new { include ::ModuleClassMockInstance }
    @test_state.before_include_block_ran?.should == true
    @test_state.after_include_block_ran?.should == true
    @test_state.before_extend_block_ran?.should == false
    @test_state.after_extend_block_ran?.should == false
    @test_state.subclass_block_ran?.should == false
  end

  it 'raises an exception if one attempts to create include hooks on a class' do
    module_cluster_define_block = @module_cluster_define_block
    ::Proc.new { ::Class.new( & module_cluster_define_block ) }.should raise_error ::RuntimeError
  end

  ##################
  #  extend hooks  #
  ##################

  it 'an extend hook on a module can run before or after module is extended by a module' do
    ::Module.new { extend ::ModuleMock }
    @test_state.before_include_block_ran?.should == false
    @test_state.after_include_block_ran?.should == false
    @test_state.before_extend_block_ran?.should == true
    @test_state.after_extend_block_ran?.should == true
    @test_state.subclass_block_ran?.should == false
  end

  it 'an extend hook on a module can run before or after module is extended by a class' do
    ::Class.new { extend ::ModuleMock }
    @test_state.before_include_block_ran?.should == false
    @test_state.after_include_block_ran?.should == false
    @test_state.before_extend_block_ran?.should == true
    @test_state.after_extend_block_ran?.should == true
    @test_state.subclass_block_ran?.should == false
  end

  it 'an extend hook on a module can run before or after instance of module subclass is extended by a module' do
    ::Module.new { extend ::ModuleClassMockInstance }
    @test_state.before_include_block_ran?.should == false
    @test_state.after_include_block_ran?.should == false
    @test_state.before_extend_block_ran?.should == true
    @test_state.after_extend_block_ran?.should == true
    @test_state.subclass_block_ran?.should == false
  end

  it 'an extend hook on a module can run before or after instance of module subclass is extended by a class' do
    ::Class.new { extend ::ModuleClassMockInstance }
    @test_state.before_include_block_ran?.should == false
    @test_state.after_include_block_ran?.should == false
    @test_state.before_extend_block_ran?.should == true
    @test_state.after_extend_block_ran?.should == true
    @test_state.subclass_block_ran?.should == false
  end

  it 'raises an exception if one attempts to create extend hooks on a class' do
    module_cluster_define_block = @module_cluster_define_block
    ::Proc.new { ::Class.new( & module_cluster_define_block ) }.should raise_error ::RuntimeError
  end

  ####################
  #  subclass hooks  #
  ####################
  
  it 'a hook can run after a subclass is created' do
    ::Class.new( ClassMock )
    @test_state.before_include_block_ran?.should == false
    @test_state.after_include_block_ran?.should == false
    @test_state.before_extend_block_ran?.should == false
    @test_state.after_extend_block_ran?.should == false
    @test_state.subclass_block_ran?.should == true
  end
  
end

# modules

# modules and blocks


#######################
#  conditional hooks  #
#######################

describe ::Module::Cluster do
end

#####################
#  cascading hooks  #
#####################

describe ::Module::Cluster do
end









  ####################
  #  subclass hooks  #
  ####################

  # module - without block

  it 'can create subclass hooks with block events' do
    module ::Module::Cluster::SubclassModuleHookMock

      module A
      end

      module ClusterModuleMock
        extend ::Module::Cluster
        cluster( :cluster_name ).subclass.extend( A )
      end
      
      class BaseClassA
        include ClusterModuleMock
        def self.inherited( instance )
          instance.is_a?( A ).should == false
          super if defined?( super )
          instance.is_a?( A ).should == true
        end
      end

      class BaseClassB
        extend ClusterModuleMock
        def self.inherited( instance )
          instance.is_a?( A ).should == false
          super if defined?( super )
          instance.is_a?( A ).should == true
        end
      end

      class ClassA < BaseClassA
        is_a?( A ).should == true
      end
      
      class ClassB < BaseClassB
        is_a?( A ).should == true
      end
            
    end
  end

  # module - with block

  it 'can create subclass hooks with block events' do
    module ::Module::Cluster::SubclassModuleHookBlockMock

      module A
      end
      
      block_ran = false

      ClusterModuleMock = ::Module.new
      ClusterModuleMock.module_eval do
        extend ::Module::Cluster
        block = ::Proc.new do |instance|
          instance.is_a?( A ).should == true
          block_ran = true
        end
        cluster( :cluster_name ).subclass.extend( A, & block )
      end
      
      class BaseClassA
        include ClusterModuleMock
        def self.inherited( instance )
          instance.is_a?( A ).should == false
          super if defined?( super )
          instance.is_a?( A ).should == true
        end
      end

      class BaseClassB
        extend ClusterModuleMock
        def self.inherited( instance )
          instance.is_a?( A ).should == false
          super if defined?( super )
          instance.is_a?( A ).should == true
        end
      end

      block_ran.should == false

      class ClassA < BaseClassA
        is_a?( A ).should == true
      end
      
      block_ran.should == true

      block_ran = false
      
      class ClassB < BaseClassB
        is_a?( A ).should == true
      end

      block_ran.should == true

    end
  end




  #######################
  #  conditional hooks  #
  #######################

  # class - before

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeClassConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).before_include( :class ).extend( A )
        cluster( :cluster_name ).before_extend( :class ).extend( B )
        cluster( :cluster_name ).before_include_or_extend( :class ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == false
        is_a?( C ).should == false
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( A ).should == false
      instance.is_a?( B ).should == false
      instance.is_a?( C ).should == false

    end
  end

  # class - after

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterClassConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).after_include( :class ).extend( A )
        cluster( :cluster_name ).after_extend( :class ).extend( B )
        cluster( :cluster_name ).after_include_or_extend( :class ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == false
        is_a?( C ).should == false
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( A ).should == false
      instance.is_a?( B ).should == false
      instance.is_a?( C ).should == false

    end
  end

  # module

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeModuleConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).before_include( :module ).extend( A )
        cluster( :cluster_name ).before_extend( :module ).extend( B )
        cluster( :cluster_name ).before_include_or_extend( :module ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == false
        is_a?( C ).should == false
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( A ).should == false
      instance.is_a?( B ).should == false
      instance.is_a?( C ).should == false

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterModuleConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).after_include( :module ).extend( A )
        cluster( :cluster_name ).after_extend( :module ).extend( B )
        cluster( :cluster_name ).after_include_or_extend( :module ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == false
        is_a?( C ).should == false
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( A ).should == false
      instance.is_a?( B ).should == false
      instance.is_a?( C ).should == false

    end
  end

  # instance

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeInstanceConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        # meaningless
        cluster( :cluster_name ).before_include( :instance ).extend( A )
        cluster( :cluster_name ).before_extend( :instance ).extend( B )
        # meaningless for include - really just doubles for extend
        cluster( :cluster_name ).before_include_or_extend( :instance ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == false
        is_a?( C ).should == false
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end
      
      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( A ).should == false
      instance.is_a?( B ).should == true
      instance.is_a?( C ).should == true
      eigenclass = class << instance ; self ;end
      eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterInstanceConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        # meaningless
        cluster( :cluster_name ).after_include( :instance ).extend( A )
        cluster( :cluster_name ).after_extend( :instance ).extend( B )
        # meaningless for include - really just doubles for extend
        cluster( :cluster_name ).after_include_or_extend( :instance ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == false
        is_a?( C ).should == false
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end
      
      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( B ).should == true
      instance.is_a?( C ).should == true
      eigenclass = class << instance ; self ;end
      eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )

    end
  end

  # class or module

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeClassModuleConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).before_include( :class, :module ).extend( A )
        cluster( :cluster_name ).before_extend( :class, :module ).extend( B )
        cluster( :cluster_name ).before_include_or_extend( :class, :module ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( A ).should == false
      instance.is_a?( B ).should == false
      instance.is_a?( C ).should == false

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterClassModuleConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).after_include( :class, :module ).extend( A )
        cluster( :cluster_name ).after_extend( :class, :module ).extend( B )
        cluster( :cluster_name ).after_include_or_extend( :class, :module ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( A ).should == false
      instance.is_a?( B ).should == false
      instance.is_a?( C ).should == false

    end
  end

  # class or instance

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeClassInstanceConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).before_include( :class, :instance ).extend( A )
        cluster( :cluster_name ).before_extend( :class, :instance ).extend( B )
        cluster( :cluster_name ).before_include_or_extend( :class, :instance ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == false
        is_a?( C ).should == false
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( B ).should == true
      instance.is_a?( C ).should == true
      eigenclass = class << instance ; self ;end
      eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterClassInstanceConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).after_include( :class, :instance ).extend( A )
        cluster( :cluster_name ).after_extend( :class, :instance ).extend( B )
        cluster( :cluster_name ).after_include_or_extend( :class, :instance ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == false
        is_a?( C ).should == false
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( B ).should == true
      instance.is_a?( C ).should == true
      eigenclass = class << instance ; self ;end
      eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )

    end
  end

  # module or instance

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeModuleInstanceConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).before_include( :module, :instance ).extend( A )
        cluster( :cluster_name ).before_extend( :module, :instance ).extend( B )
        cluster( :cluster_name ).before_include_or_extend( :module, :instance ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == false
        is_a?( C ).should == false
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( B ).should == true
      instance.is_a?( C ).should == true
      eigenclass = class << instance ; self ;end
      eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterModuleInstanceConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).after_include( :module, :instance ).extend( A )
        cluster( :cluster_name ).after_extend( :module, :instance ).extend( B )
        cluster( :cluster_name ).after_include_or_extend( :module, :instance ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == false
        is_a?( C ).should == false
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == false
        is_a?( C ).should == false
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( B ).should == true
      instance.is_a?( C ).should == true
      eigenclass = class << instance ; self ;end
      eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )

    end
  end

  # class or module or instance (redundant with non-specification)

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeClassModuleInstanceConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).after_include( :class, :module, :instance ).extend( A )
        cluster( :cluster_name ).after_extend( :class, :module, :instance ).extend( B )
        cluster( :cluster_name ).after_include_or_extend( :class, :module, :instance ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( B ).should == true
      instance.is_a?( C ).should == true
      eigenclass = class << instance ; self ;end
      eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterClassModuleInstanceConditionalHookMock

      module A
      end
      module B
      end
      module C
      end

      module ClusterModuleMock

        extend ::Module::Cluster

        cluster( :cluster_name ).after_include( :class, :module, :instance ).extend( A )
        cluster( :cluster_name ).after_extend( :class, :module, :instance ).extend( B )
        cluster( :cluster_name ).after_include_or_extend( :class, :module, :instance ).extend( C )

      end
      
      module IncludeModuleMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      module ExtendModuleMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      class IncludeClassMock
        include ClusterModuleMock
        is_a?( A ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( C )
      end
      
      class ExtendClassMock
        extend ClusterModuleMock
        is_a?( B ).should == true
        is_a?( C ).should == true
        eigenclass = class << self ; self ;end
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
      end

      instance = Object.new
      instance.extend( ClusterModuleMock )
      instance.is_a?( B ).should == true
      instance.is_a?( C ).should == true
      eigenclass = class << instance ; self ;end
      eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )

    end
  end

  #############################
  #  cascading event actions  #
  #############################

  # cascade to any instance (class, subclass, module, instance)
  
  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeActionMock
      
      module A
      end
      module B
      end
      module C
      end
      module D
      end
      module E
      end
      module F
      end
            
      block_ran = false
      
      ClusterModuleMock = ::Module.new
      ClusterModuleMock.module_eval do        
        extend ::Module::Cluster
        
        cluster( :before_include_cluster_name ).before_include.cascade.extend( A ) do
          block_ran = true
        end
  
      end
      
      module IncludingModuleA
        include ClusterModuleMock
        is_a?( A ).should == true
      end

      block_ran.should == true
      
      block_ran = false

      module IncludingModuleB
        include IncludingModuleA
        is_a?( A ).should == true
      end

      block_ran.should == true
      
      block_ran = false

      module IncludingModuleC
        include IncludingModuleB
        is_a?( A ).should == true
      end

      block_ran.should == true
      
      block_ran = false

      module IncludingModuleD
        include IncludingModuleC
        is_a?( A ).should == true
      end

      block_ran.should == true
      
      block_ran = false
      
      class IncludingClassA
        include IncludingModuleC
        is_a?( A ).should == true
      end

      block_ran.should == true
      
      block_ran = false

      class IncludingClassB < IncludingClassA
        is_a?( A ).should == true
      end

      block_ran.should == true
      
      block_ran = false

      class IncludingClassC < IncludingClassB
        is_a?( A ).should == true
      end
      
    end
  end
  
  # cascade to class
  # this means to the first class, not subclasses

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToClassActionMock

      module A
      end
            
      block_ran = false
      
      ClusterModuleMock = ::Module.new
      ClusterModuleMock.module_eval do        
        extend ::Module::Cluster
        
        cluster( :before_include_cluster_name ).before_include.cascade( :class ).extend( A ) do
          block_ran = true
        end
  
      end
      
      module IncludingModuleA
        include ClusterModuleMock
        is_a?( A ).should == false
      end

      block_ran.should == false

      module IncludingModuleB
        include IncludingModuleA
        is_a?( A ).should == false
      end

      block_ran.should == false

      module IncludingModuleC
        include IncludingModuleB
        is_a?( A ).should == false
      end

      block_ran.should == false

      module IncludingModuleD
        include IncludingModuleC
        is_a?( A ).should == false
      end

      block_ran.should == false
      
      class IncludingClassA
        include IncludingModuleD
        is_a?( A ).should == true
      end

      block_ran.should == true
      
      block_ran = false

      class IncludingClassB < IncludingClassA
        is_a?( A ).should == true
      end

      block_ran.should == false
      
      block_ran = false

      class IncludingClassC < IncludingClassB
        is_a?( A ).should == true
      end

    end
  end

  # cascade to subclass

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToSubclassActionMock

      module A
      end
            
      block_ran = false
      
      ClusterModuleMock = ::Module.new
      ClusterModuleMock.module_eval do        
        extend ::Module::Cluster
        
        cluster( :before_include_cluster_name ).before_include.cascade( :subclass ).extend( A ) do
          block_ran = true
        end
  
      end
      
      module IncludingModuleA
        include ClusterModuleMock
        is_a?( A ).should == false
      end

      block_ran.should == false

      module IncludingModuleB
        include IncludingModuleA
        is_a?( A ).should == false
      end

      block_ran.should == false

      module IncludingModuleC
        include IncludingModuleB
        is_a?( A ).should == false
      end

      block_ran.should == false

      module IncludingModuleD
        include IncludingModuleC
        is_a?( A ).should == false
      end

      block_ran.should == false
      
      class IncludingClassA
        include IncludingModuleD
        is_a?( A ).should == false
      end

      block_ran.should == false
      
      block_ran = false

      class IncludingClassB < IncludingClassA
        is_a?( A ).should == true
      end

      block_ran.should == true
      
      block_ran = false

      class IncludingClassC < IncludingClassB
        is_a?( A ).should == true
      end

    end
  end
  
  # cascade to module

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToModuleActionMock

      module A
      end
            
      block_ran = false
      
      ClusterModuleMock = ::Module.new
      ClusterModuleMock.module_eval do        
        extend ::Module::Cluster
        
        cluster( :before_include_cluster_name ).before_include.cascade( :module ).extend( A ) do
          block_ran = true
        end
  
      end
      
      module IncludingModuleA
        include ClusterModuleMock
        is_a?( A ).should == true
      end

      block_ran.should == true

      block_ran = false

      module IncludingModuleB
        include IncludingModuleA
        is_a?( A ).should == true
      end

      block_ran.should == true

      block_ran = false

      module IncludingModuleC
        include IncludingModuleB
        is_a?( A ).should == true
      end

      block_ran.should == true

      block_ran = false

      module IncludingModuleD
        include IncludingModuleC
        is_a?( A ).should == true
      end

      block_ran.should == true

      block_ran = false
      
      class IncludingClassA
        include IncludingModuleD
        is_a?( A ).should == false
      end

      block_ran.should == false
      
      class IncludingClassB < IncludingClassA
        is_a?( A ).should == false
      end

      block_ran.should == false
      
      class IncludingClassC < IncludingClassB
        is_a?( A ).should == false
      end

    end
  end
  
  # cascade to class or subclass

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToClassOrSubclassActionMock

      module A
      end
            
      block_ran = false
      
      ClusterModuleMock = ::Module.new
      ClusterModuleMock.module_eval do        
        extend ::Module::Cluster
        
        cluster( :before_include_cluster_name ).before_include.cascade( :class, :subclass ).extend( A ) do
          block_ran = true
        end
  
      end
      
      module IncludingModuleA
        include ClusterModuleMock
        is_a?( A ).should == false
      end

      block_ran.should == false

      module IncludingModuleB
        include IncludingModuleA
        is_a?( A ).should == false
      end

      block_ran.should == false

      module IncludingModuleC
        include IncludingModuleB
        is_a?( A ).should == false
      end

      block_ran.should == false

      module IncludingModuleD
        include IncludingModuleC
        is_a?( A ).should == false
      end

      block_ran.should == false
      
      class IncludingClassA
        include IncludingModuleD
        is_a?( A ).should == true
      end

      block_ran.should == true
      
      block_ran = false

      class IncludingClassB < IncludingClassA
        is_a?( A ).should == true
      end

      block_ran.should == true
      
      block_ran = false

      class IncludingClassC < IncludingClassB
        is_a?( A ).should == true
      end

    end
  end
  
  #######################################
  #  suspend and resume named clusters  #
  #######################################
  
  it 'can suspend and resume named clusters' do
    module ::Module::Cluster::SuspendResumeMock

      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        module A
        end
        module B
        end
        module C
        end

        cluster( :cluster_name ).before_include.extend( A, B, C )

        module D
        end
        module E
        end
        module F
        end

        cluster( :other_cluster_name ).before_include.extend( D, E, F )
        
      end
      
      module IncludingModule
        
        include ClusterModuleMock
        
        is_a?( A ).should == true
        is_a?( B ).should == true
        is_a?( C ).should == true
        is_a?( D ).should == true
        is_a?( E ).should == true
        is_a?( F ).should == true
        
        eigenclass = class << self ; self ;end
        
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( B )
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
        eigenclass.ancestors.index( C ).should > eigenclass.ancestors.index( D )
        eigenclass.ancestors.index( D ).should > eigenclass.ancestors.index( E )
        eigenclass.ancestors.index( E ).should > eigenclass.ancestors.index( F )
        
      end
      
      module OtherIncludingModule
        
        ClusterModuleMock.cluster( :other_cluster_name ).disable
        
        include ClusterModuleMock
        
        is_a?( A ).should == true
        is_a?( B ).should == true
        is_a?( C ).should == true
        is_a?( D ).should == false
        is_a?( E ).should == false
        is_a?( F ).should == false
        
        eigenclass = class << self ; self ;end
        
        eigenclass.ancestors.index( A ).should > eigenclass.ancestors.index( B )
        eigenclass.ancestors.index( B ).should > eigenclass.ancestors.index( C )
        
      end
      
    end
    
  end
  
end
