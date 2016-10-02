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

        it 'extract returns the item' do
          expect(@pq.extract).to be(1)
          expect(@pq.extract).to be_nil
        end
      end

      context 'insert an item in order' do
        it 'retains the order' do
          @pq.insert(2, 0)
          expect(@pq.extract).to be(1)
          expect(@pq.extract).to be(2)
          expect(@pq.extract).to be_nil
        end
      end

      context 'insert an item out of order' do
        it 'sorts by key' do
          @pq.insert(2, 3)
          expect(@pq.extract).to be(2)
          expect(@pq.extract).to be(1)
          expect(@pq.extract).to be_nil
        end
      end

      context 'when heap is full' do 
        before(:each) do
          @pq.insert(2, 0)
          expect(@pq.top).to be(1)
        end

        context 'new item has medium key' do
          it 'sorts the items by key' do
            @pq.insert(3, 1)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be_nil
          end
        end

        context 'new item has the smallest key' do
          it 'sorts the items by key' do
            @pq.insert(3, -1)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be_nil
          end
        end

        context 'new item has the largest key' do
          it 'sorts the items by key' do
            @pq.insert(3, 3)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be_nil
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
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be_nil
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
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be(4)
            expect(@pq.extract).to be_nil
          end
        end

        context 'new item has the second smallest key' do
          it 'sorts the items by key' do
            @pq.insert(4, -1)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(4)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be_nil
          end
        end

        context 'new item has the second largest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 1)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(4)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be_nil
          end
        end

        context 'new item has the largest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 3)
            expect(@pq.extract).to be(4)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be_nil
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
            expect(@pq.extract).to be(4)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(1)
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
          expect(@pq.extract).to be(1)
          expect(@pq.extract).to be_nil
        end
      end

      context 'insert an item in order' do
        it 'retains the order' do
          @pq.insert(2, 11)
          expect(@pq.extract).to be(1)
          expect(@pq.extract).to be(2)
          expect(@pq.extract).to be_nil
        end
      end

      context 'insert an item out of order' do
        it 'sorts by key' do
          @pq.insert(2, 9)
          expect(@pq.extract).to be(2)
          expect(@pq.extract).to be(1)
          expect(@pq.extract).to be_nil
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
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be_nil
          end
        end

        context 'new item has the largest key' do
          it 'sorts the items by key' do
            @pq.insert(3, 13)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be_nil
          end
        end

        context 'new item has the smallest key' do
          it 'sorts the items by key' do
            @pq.insert(3, 9)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be_nil
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
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be_nil
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
            expect(@pq.extract).to be(4)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be_nil
          end
        end

        context 'new item has the second smallest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 11)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(4)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be_nil
          end
        end

        context 'new item has the second largest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 13)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(4)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be_nil
          end
        end

        context 'new item has the largest key' do
          it 'sorts the items by key' do
            @pq.insert(4, 15)
            expect(@pq.extract).to be(1)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be(4)
            expect(@pq.extract).to be_nil
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
            expect(@pq.extract).to be(4)
            expect(@pq.extract).to be(3)
            expect(@pq.extract).to be(2)
            expect(@pq.extract).to be(1)
          end
        end
      end
    end
  end
end
