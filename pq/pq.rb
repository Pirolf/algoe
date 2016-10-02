class PriorityQueue
  attr_reader :heap
  attr_reader :order

  def initialize(order = :max)
    @heap = []
    @order = order
  end

  def insert(x, k)
    @heap.push({val: x, key: k})
    heapify_up
  end

  def top
    return nil if @heap.empty?
    @heap.first[:val]
  end

  def set_key(i, k)
    @heap[i][:key] = k 
    heapify_up(i)
    heapify_down(i)
  end

  def extract
    top = @heap.shift
    if !@heap.empty? then heapify_down end
    return top if top.nil? 
    return top[:val]
  end

  def clear
    @heap.clear
  end

  private
    def heapify_up(i = @heap.length - 1)
      while i >= 0
        parentIndex = parent(i)
        if parentIndex < 0 || in_order(parentIndex, i)
          return
        end
        exchange(parentIndex, i)
        i = parentIndex
      end
    end

    def heapify_down(i = 0)
      left = left(i)
      right = right(i)

      if in_order(i, left) && in_order(i, right)
        return
      end

      if in_order(left, right)
        exchange(i, left)
        return heapify_down(left)
      end

      exchange(i, right)
      return heapify_down(right)
    end

    def key(i)
      if @heap[i].nil?
        return @order == :max ? -Float::INFINITY : Float::INFINITY 
      end
      @heap[i][:key]
    end

    def in_order(i, j)
      if @order == :max
        return key(i) > key(j)
      end
      key(i) < key(j)
    end

    def parent(i)
      (i-1)/2
    end

    def left(i)
      2*i + 1
    end

    def right(i)
      left(i) + 1
    end

    def exchange(i, j)
      temp = @heap[j]
      @heap[j] = @heap[i]
      @heap[i] = temp
    end
end
