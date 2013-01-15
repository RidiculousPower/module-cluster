
class BlockState

  ################
  #  initialize  #
  ################

  def initialize
    @block_ran = false
  end

  ###########
  #  block  #
  ###########

  attr_accessor :block
  
  ###########
  #  clear  #
  ###########

  def clear
    @block_ran = false
  end

  ################
  #  block_ran!  #
  ################

  def block_ran!
    @block_ran = true
  end

  ################
  #  block_ran?  #
  ################

  def block_ran?
    block_ran = @block_ran
    @block_ran = false
    return block_ran
  end

end
