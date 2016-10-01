class PriorityQueue
  def initialize
    @heap = []
  end

  def insert(x, k)
    @heap.push({val: x, key: k})
    insert_heapify
  end

  def maximini
    return nil if @heap.empty?
    @heap.first[:val]
  end

  def changeKey(i, k)
    setKey(k)
    heapify
  end

  def extract
    top = @heap.shift
    if !@heap.empty? then heapify end
    return top if top.nil? 
    return top[:val]
  end

  def clear
    @heap.clear
  end

  private
    def insert_heapify
      i = @heap.length - 1

      while i >= 0
        parentIndex = parent(i)
        break if parentIndex < 0
        break if key(parentIndex) >= key(i)
        exchange(parentIndex, i)
        i = parentIndex
      end
    end

    def heapify(i = 0)
      left = left(i)
      right = right(i)
      if left > @heap.length - 1
        return
      end

      if right > @heap.length - 1
        if key(i) > key(left)
          return
        end
        exchange(i, left)
        return heapify(left)
      end

      if key(i) > key(left) && key(i) > key(right)
        return
      end

      if key(left) > key(right)
        exchange(i, left)
        return heapify(left)
      end

      exchange(i, right)
      return heapify(right)
    end

    def key(i)
      @heap[i][:key]
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

    def setKey(i, k)
      @heap[i][:key] = k
    end
end
