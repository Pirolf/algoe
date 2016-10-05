require_relative '../../pq/young_tableau.rb'

RSpec.describe 'Young Tableau' do
  before(:each) do
    @yt = [
      [1, 2, 4, 5],
      [3, 3, 6, 8],
      [4, 7, 8, 9]
    ]
  end

  fdescribe '#extract_min' do
    context 'when grid is 1x1' do
      it 'returns the number' do
        @yt = [[1]]
        expect(extract_min @yt).to be(1)
        expect(@yt).to eq []
      end

      it 'returns infinity' do
        @yt = [[Float::INFINITY]]
        expect(extract_min @yt).to be Float::INFINITY
        expect(@yt).to eq []
      end
    end

    it 'returns the smallest element and maintains table' do
      expect(extract_min @yt).to be(1)
      expect(@yt).to eq [
        [2, 3, 4, 5],
        [3, 6, 8, 9],
        [4, 7, 8, Float::INFINITY]
      ]
    end

    context 'when grid is not full' do
      before(:each) do
        @yt = [
          [1, 4, 5],
          [3, Float::INFINITY, Float::INFINITY],
          [4, Float::INFINITY, Float::INFINITY]
        ]
      end

      it 'returns the smallest element and maintains table' do
        expect(extract_min @yt).to be(1)
        expect(@yt).to eq [
          [3, 4, 5],
          [4, Float::INFINITY, Float::INFINITY],
        ]
      end

      it 'returns the smallest and clears a column if necessary' do
        @yt = [
          [1, 4, 5],
          [6, Float::INFINITY, Float::INFINITY],
          [7, Float::INFINITY, Float::INFINITY]
        ]

        expect(extract_min @yt).to be(1)
        expect(@yt).to eq [
          [4, 5],
          [6, Float::INFINITY],
          [7, Float::INFINITY]
        ]
      end
    end
  end

  fdescribe '#insert into a non full table' do
    before(:each) do
      @yt = [
        [1, 2, 4, 8],
        [5, 6, 6, 9],
        [4, 7, Float::INFINITY, Float::INFINITY]
      ]
    end

    context 'when the table is empty' do
      before(:each) do
        @yt = [[Float::INFINITY]]
      end

      it 'inserts a number and maintains table' do
        insert(@yt, 1)
        @ut = [[1]]
      end

      it 'inserts infinity and maintains table' do
        insert(@yt, Float::INFINITY)
        @ut = [[Float::INFINITY]]
      end
    end

    context 'a non min' do
      it 'inserts number and maintains table' do
        insert(@yt, 5)
        expect(@yt).to eq([
          [1, 2, 4, 8],
          [5, 5, 6, 9],
          [4, 6, 7, Float::INFINITY]
        ])
      end

      it 'inserts infinity and maintains table' do
        insert(@yt, Float::INFINITY)
        expect(@yt).to eq([
          [1, 2, 4, 8],
          [5, 6, 6, 9],
          [4, 7, Float::INFINITY, Float::INFINITY]
        ])
      end
    end

    context 'a min' do
      it 'maintains table' do
        insert(@yt, 0)
        expect(@yt).to eq([
          [0, 2, 4, 8],
          [1, 5, 6, 9],
          [4, 6, 7, Float::INFINITY]
        ])
      end
    end
  end

  describe '#sort' do
    before(:each) do
      @arr = [7,4,5,4,2,9,6,1,6]
      # @yt = [
      #   [1, 2, 4],
      #   [5, 6, 6],
      #   [4, 7, 9]
      # ]
    end

    it 'sorts' do
      expect(sort @arr).to eq([1,2,4,4,5,6,6,7,9])
    end
  end

  describe '#has' do
    before(:each) do
      @yt = [
        [1, 2, 4],
        [5, 6, 6],
        [4, 7, 9]
      ]
    end

    it 'returns true when it has the number' do
      expect(has(@yt, 5)).to be true
    end

    it 'returns false when it does not have the number' do
      expect(has(@yt, 8)).to be false
    end
  end
end
