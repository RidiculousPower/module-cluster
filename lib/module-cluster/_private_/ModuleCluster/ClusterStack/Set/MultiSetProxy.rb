
class ::ModuleCluster::ClusterStack::Set::MultiSetProxy < Array

  ################
  #  initialize  #
  ################

  def initialize( *members )
    super( members )
  end

  ##########
  #  name  #
  ##########

  def name
    return collect {  |this_set| this_set.name }.flatten
  end

  ###########
  #  name=  #
  ###########

  def name=( set_name )

    self.each do |this_set|
      this_set.name = set_name
    end

    return set_name

  end

  #######################
  #  dependency_module  #
  #######################

  def dependency_module
    return collect { |this_set| this_set.dependency_module }.flatten
  end

  ########################
  #  dependency_module=  #
  ########################

  def dependency_module=( set_dependency_module )

    self.each do |this_set|
      this_set.dependency_module = set_dependency_module
    end

    return set_dependency_module
    
  end

  ############
  #  method  #
  ############
  
  def method
    return collect { |this_set| this_set.method }.flatten
  end

  #############
  #  method=  #
  #############
  
  def method=( set_method )

    self.each do |this_set|
      this_set.method = set_method
    end

    return set_method

  end

  ##################################
  #  module_class_instance_or_all  #
  ##################################
  
  def module_class_instance_or_all
    return collect { |this_set| this_set.module_class_instance_or_all }.flatten
  end

  ###################################
  #  module_class_instance_or_all=  #
  ###################################
  
  def module_class_instance_or_all=( symbol_module_class_instance_or_all )

    self.each do |this_set|
      this_set.module_class_instance_or_all = symbol_module_class_instance_or_all
    end

    return symbol_module_class_instance_or_all

  end

  #######################
  #  include_or_extend  #
  #######################
  
  def include_or_extend
    return collect { |this_set| this_set.method }.flatten
  end

  ########################
  #  include_or_extend=  #
  ########################
  
  def include_or_extend=( symbol_include_or_extend )

    self.each do |this_set|
      this_set.method = symbol_include_or_extend
    end

    return symbol_include_or_extend

  end
  
  #############
  #  modules  #
  #############

  def modules
    modules = Array.new
    self.each do |this_set|
      if this_set.is_a?( ::ModuleCluster::ClusterStack::Set::MultiSetProxy )
        modules.concat( this_set.modules )
      else
        modules.push( this_set.modules )
      end
    end
    return modules
  end

  ##############
  #  modules=  #
  ##############

  def modules=( array_of_modules )

    self.each do |this_set|
      this_set.modules = array_of_modules
    end

    return array_of_modules

  end

  #######################################
  #  runtime_includes_or_extends_block  #
  #######################################
  
  def runtime_includes_or_extends_block
    return collect { |this_set| this_set.runtime_includes_or_extends_block }.flatten
  end

  ########################################
  #  runtime_includes_or_extends_block=  #
  ########################################
  
  def runtime_includes_or_extends_block=( runtime_includes_or_extends_proc )

    self.each do |this_set|
      this_set.runtime_includes_or_extends_block = runtime_includes_or_extends_proc
    end

    return runtime_includes_or_extends_proc

  end

  ###############
  #  suspended  #
  ###############
  
  def suspended
    return collect do |this_set|
      if this_set.is_a?( ::ModuleCluster::ClusterStack::Set::MultiSetProxy )
        this_set.suspended
      else
        this_set.suspended ? true : false
      end
    end.flatten
  end

  ################
  #  suspended=  #
  ################
  
  def suspended=( true_or_false )

    self.each do |this_set|
      this_set.suspended = true_or_false
    end

    return true_or_false

  end

  #############
  #  suspend  #
  #############

  def suspend
    self.suspended = true
  end

  ############
  #  resume  #
  ############

  def resume
    self.suspended = false
  end

  ################
  #  suspended?  #
  ################
  
  def suspended?
    return suspended
  end

  ################
  #  hooks_with  #
  ################
  
  def hooks_with( descriptor_hash )
    
    matched_hooks = self.class.new
    
    # for each set
    self.each do |this_set|
      
      if this_set.respond_to?( __method__ )
        
        matched_hooks.concat( this_set.hooks_with( descriptor_hash ) )
      
      else

        # see if set matches descriptor
        matched = false
        descriptor_hash.each do |descriptor, description|
          case descriptor

            when :dependency_module
              if description.is_a?( Array )
                matched = description.include?( this_set.dependency_module )
              else
                matched = ( this_set.dependency_module == description )
              end
              break unless matched

            when :method
              if description.is_a?( Array )
                matched = description.include?( this_set.method )
              else
                matched = ( this_set.method == description )
              end
              break unless matched

            when :module_class_instance_or_all
              case this_set.module_class_instance_or_all
              when :all, :module_or_class_or_instance, :module_and_class_and_instance, 
                   :module_class_or_instance, :module_class_and_instance, :module_class_instance
                  matched = true
                when :module_or_class, :module_and_class, :module_class
                  case description
                    when :module, :class
                      matched = true
                    else
                      matched = false
                  end
                when :module_or_instance, :module_and_instance, :module_instance
                  case description
                    when :module, :instance
                      matched = true
                    else
                      matched = false
                  end
                when :class_or_instance, :class_and_instance, :class_instance
                  case description
                    when :class, :instance
                      matched = true
                    else
                      matched = false
                  end
                when :module, :class, :instance
                  matched = ( this_set.module_class_instance_or_all == description )
              end
              break unless matched

            when :include_or_extend
              case this_set.include_or_extend
                when :include_and_extend
                  matched = true
                else
                  matched = ( this_set.include_or_extend == description )
              end
              break unless matched

            when :modules
              if description.is_a?( Array )
                matched = this_set.modules.include?( *description )
              else
                matched = this_set.modules.include?( description )
              end
              break unless matched

            when :runtime_includes_or_extends_block
              break unless matched = ( this_set.runtime_includes_or_extends_block == description )

            when :suspended
              break unless matched = ( ( this_set.suspended ||= false ) == description )

            when :name
              if description.is_a?( Array )
                matched = description.include?( this_set.name )
              else
                matched = ( this_set.name == description )
              end
              break unless matched

          end
        end
        # if it does, add it to our return set
        matched_hooks.push( this_set ) if matched
      end
      
    end
    
    return matched_hooks
    
  end

  ###########
  #  hooks  #
  ###########
  
  def hooks( hook_name )

    matched_hooks = self.class.new
    
    # for each set
    self.each do |this_set|
      if this_set.is_a?( ::ModuleCluster::ClusterStack::Set::MultiSetProxy )
        matched_hooks.concat( this_set.hooks( hook_name ) )
      else
        matched_hooks.push( this_set ) if this_set.name == hook_name
      end
    end

    return matched_hooks
    
  end
  
end
