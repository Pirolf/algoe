require_relative '../../pq/pq.rb'

RSpec.describe PriorityQueue do
  before(:each) do
    @pq = PriorityQueue.new
  end
  
  context 'when queue is empty' do
    it 'top of queue is nil' do
      expect(@pq.top).to be_nil
    end
    
    it 'extract returns nil' do
      expect(@pq.extract).to be_nil
    end

    it 'delete returns nil' do
      expect(@pq.extract).to be_nil
    end
  end

  context 'when it is a max heap' do
    context 'when queue has items' do
      before(:each) do
        @pq.insert(1, 2)
      end

      context 'when there is 1 item' do
        it 'top of the queue is the item' do
          expect(@pq.top).to be(1)
        end

        it 'delete' do
          expect(@pq.delete(0)).to be(1)
          expect(@pq.extract).to be_nil
        end

        it 'extract returns the item' do
          extract_all [1]
        end
      end

      context 'insert an item in order' do
        it 'retains the order' do
          @pq.insert(2, 0)
          extract_all([1, 2])
        end
      end

      context 'insert an item out of order' do
        it 'sorts by key' do
          @pq.insert(2, 3)
          extract_all [2, 1]
        end
      end

      context 'when heap is full' do 
        before(:each) do
          @pq.insert(2, 0)
          expect(@pq.top).to be(1)
        end

        context 'delete' do
          before(:each) do
            @pq.insert(3, -2)
            @pq.insert(4, -4)
            @pq.insert(5, -6)
            expect(@pq.heap).to eq([
              {key: 2, val: 1},
              {key: 0, val: 2},
              {key: -2, val: 3},
              {key: -4, val: 4},
              {key: -6, val: 5}
            ])
          end

          context 'root' do
            it 'sorts' do
              expect(@pq.delete(0)).to be(1)
              extract_all [2, 3, 4, 5]
            end
          end

          context 'non root or leaf' do
            it 'sorts' do
              expect(@pq.delete(1)).to be(2)
              extract_all [1, 3, 4, 5]
            end
          end

          context 'leaf' do
            it 'sorts' do
              expect(@pq.delete(3)).to be(4)
              extract_all [1, 2, 3, 5]
            end
          end
        end

        context 'set key' do
          before(:each) do
            @pq.insert(3, -2)
            @pq.insert(4, -4)
            @pq.insert(5, -6)
            expect(@pq.heap).to eq([
              {key: 2, val: 1}, 
              {key: 0, val: 2}, 
              {key: -2, val: 3}, 
              {key: -4, val: 4}, 
              {key: -6, val: 5}, 
            ])
          end

          context 'of root' do
            context 'to become a medium node' do
              it 'sorts' do
                @pq.set_key(0, -1)
                extract_all [2, 1, 3, 4, 5]
              end
            end

            context 'to become a leaf node' do
              it 'sorts' do
                @pq.set_key(0, -3)
                extract_all [2, 3, 1, 4, 5]
              end
            end

            context 'stay root' do
              before(:each) do
                @pq.set_key(0, 3)
              end

              it 'updates the key' do
                expect(@pq.heap[0][:key]).to be(3)
              end

              it 'queue is the same' do
                extract_all [1, 2, 3, 4, 5]
              end
            end
          end

          context 'of leaf' do
            context 'to be root' do
              it 'sorts' do
                @pq.set_key(4, 3)
                extract_all [5, 1, 2, 3, 4]
              end
            end

            context 'to beome a medium node' do
              it 'sorts' do
                @pq.set_key(4, -1)
                extract_all [1, 2, 5, 3, 4]
              end
            end

            context 'stay leaf' do
              it 'sorts' do
                @pq.set_key(3, -7)
                extract_all [1, 2, 3, 5, 4]
              end
            end
          end

          context 'of medium node' do
            context 'to become root' do
              it 'sorts' do
                @pq.set_key(2, 3)
                extract_all [3, 1, 2, 4, 5]
              end
            end

            context 'to stay medium' do
              it 'sorts' do
                @pq.set_key(2, 1)
                extract_all [1, 3, 2, 4, 5]
              end
            end

            context 'to become leaf' do
              it 'sorts' do
                @pq.set_key(2, -5)
                extract_all [1, 2, 4, 3, 5]
              end
            end
          end
        end

        context 'new item has medium key' do
          it 'sorts the items by key' do
            @pq.insert(3, 1)
            extract_all [1, 3, 2]
          end
        end

        context 'new item has the smallest key' do
          it 'sorts the items by key' do
            @pq.insert(3, -1)
            extract_all [1, 2, 3]
          end
        end

        context 'new item has the largest key' do
          it 'sorts the items by key' do
            @pq.insert(3, 3)
            extract_all [3, 1, 2]
          end
        end

        context 'when order is reversed' do
          before(:each) do
            @pq.clear
          end

          it 'sorts the items by key' do
            @pq.insert(1, 0)
            @pq.insert(2, 1)
            @pq.insert(3, 2)
            extract_all [3, 2, 1]
          end
        end
      end

      context 'when heap is not full' do
        before(:each) do
          @pq.insert(2, 0)
          @pq.insert(3, -2)
        end

        context 'new item has the smallest key' do
          it 'sorts the items by key' do
            @pq.insert(4, -4)
            extract_all [1, 2, 3, 4]
          end
        end

        context 'new item has the second smallest key' do
          it 'sorts the items by key' do
            @pq.insert(4, -1)
            extract_all [1, 2, 4, 3]
          end
        end

        context 'new item has the second largest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 1)
            extract_all [1, 4, 2, 3]
          end
        end

        context 'new item has the largest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 3)
            extract_all [4, 1, 2, 3]
          end
        end

        context 'when order is reversed' do
          before(:each) do
            @pq.clear
          end

          it 'sorts the items by key' do
            @pq.insert(1, 2)
            @pq.insert(2, 3)
            @pq.insert(3, 4)
            @pq.insert(4, 5)
            extract_all [4, 3, 2, 1]
          end
        end
      end
    end
  end 

  context 'when it is a min heap' do
    before(:each) do
      @pq = PriorityQueue.new(:min)
    end

    context 'when queue has items' do
      before(:each) do
        @pq.insert(1, 10)
      end

      context 'when there is 1 item' do
        it 'top of the queue is the item' do
          expect(@pq.top).to be(1)
        end

        it 'extract returns the item' do
          extract_all [1]
        end

        it 'set key does not affect the queue' do
          @pq.set_key(0, 8)
          extract_all [1]
        end
      end

      context 'insert an item in order' do
        it 'retains the order' do
          @pq.insert(2, 11)
          extract_all [1, 2]
        end
      end

      context 'insert an item out of order' do
        it 'sorts by key' do
          @pq.insert(2, 9)
          extract_all [2, 1]
        end
      end

      context 'when heap is full' do 
        before(:each) do
          @pq.insert(2, 12)
          expect(@pq.top).to be(1)
        end

        context 'new item has medium key' do
          it 'sorts the items by key' do
            @pq.insert(3, 11)
            extract_all [1, 3, 2]
          end
        end

        context 'new item has the largest key' do
          it 'sorts the items by key' do
            @pq.insert(3, 13)
            extract_all [1, 2, 3]
          end
        end

        context 'new item has the smallest key' do
          it 'sorts the items by key' do
            @pq.insert(3, 9)
            extract_all [3, 1, 2]
          end
        end

        context 'when order is reversed' do
          before(:each) do
            @pq.clear
          end

          it 'sorts the items by key' do
            @pq.insert(1, 2)
            @pq.insert(2, 1)
            @pq.insert(3, 0)
            extract_all [3, 2, 1]
          end
        end
      end

      context 'when heap is not full' do
        before(:each) do
          @pq.insert(2, 12)
          @pq.insert(3, 14)
        end

        context 'new item has the smallest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 9)
            extract_all [4, 1, 2, 3]
          end
        end

        context 'new item has the second smallest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 11)
            extract_all [1, 4, 2, 3]
          end
        end

        context 'new item has the second largest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 13)
            extract_all [1, 2, 4, 3]
          end
        end

        context 'new item has the largest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 15)
            extract_all [1, 2, 3, 4]
          end
        end

        context 'when order is reversed' do
          before(:each) do
            @pq.clear
          end

          it 'sorts the items by key' do
            @pq.insert(1, 5)
            @pq.insert(2, 4)
            @pq.insert(3, 3)
            @pq.insert(4, 2)
            extract_all [4, 3, 2, 1]
          end
        end
      end
    end
  end

  def extract_all(expectations)
    expectations.each do |x|
      expect(@pq.extract).to be(x)
    end
    expect(@pq.extract).to be_nil
  end
end
