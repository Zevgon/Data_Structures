# class Queue
#   def initialize
#     @store = []
#   end
#
#   def enqueue(item)
#     @store << item
#   end
#
#   def dequeue
#     @store.shift
#   end
#
#   def peek
#     @store[-1]
#   end
#
#   def size
#     @store.length
#   end
#
#   def empty?
#     store.empty?
#   end
# end
#
class Stack
  def initialize(store = [])
    @store = store
  end

  def push(item)
    @store << item
  end

  alias_method :<<, :push

  def pop
    @store.pop unless empty?
  end

  def peek
    @store[-1]
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

# class StackQueue
#   def initialize
#     @in = Stack.new
#     @out = Stack.new
#   end
#
#   def enqueue(item)
#     @in << item
#   end
#
#   def empty?
#     @in.empty? && @out.empty?
#   end
#
#   def size
#     @in.length + @out.length
#   end
#
#   def dequeue
#     queueify if @out.empty?
#     @out.pop
#   end
#
#   private
#   def queueify
#     @out << @in.pop until @in.empty?
#   end
# end

class MinMaxStack
  def initialize
    @store = Stack.new
  end

  def empty?
    @store.empty?
  end

  def push(val)
    @store << {
      max: new_max(val),
      min: new_min(val),
      val: val
    }
  end

  alias_method :<<, :push

  def max
    @store.peek[:max] unless empty?
  end

  def min
    @store.peek[:min]
  end

  def pop
    @store.pop
  end

  def size
    @store.size
  end

  private
  def new_max(val)
    empty? ? val : [max, val].max
  end

  def new_min(val)
    empty? ? val : [min, val].min
  end
end

class MinMaxStackQueue
  def initialize(max_size = 2)
    @in = MinMaxStack.new
    @out = MinMaxStack.new
    @max_size = max_size
  end

  def enqueue(val)
    dequeue if size == @max_size
    debugger
    @in << val
    val
  end

  def dequeue
    queueify if @out.empty?
    @out.pop[:val]
  end

  alias_method :<<, :enqueue
  alias_method :shift, :dequeue

  def empty?
    @in.empty? && @out.empty?
  end

  def size
    @in.size + @out.size
  end


  def max
    if empty?
      nil
    elsif @in.empty?
      @out.max
    elsif @out.empty?
      @in.max
    else
      [@in.max, @out.max].max
    end
  end

  def min
    if empty?
      nil
    elsif @in.empty?
      @out.min
    elsif @out.empty?
      @in.min
    else
      [@in.min, @out.min].min
    end
  end

  private
  def queueify
    until @in.empty?
      @out << @in.pop[:val]
    end
  end
end
