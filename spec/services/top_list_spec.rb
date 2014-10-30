require_relative '../../app/services/top_list'

describe TopList do
  describe '#top' do
    it 'find the n most popular things' do
      things = [
        double(name: 'a'),
        double(name: 'b'),
        double(name: 'c'),
      ]
      top_list = TopList.new(things)

      expect(top_list.top(10, :name)).to eq ['c', 'b', 'a']
    end

    it 'does not return more than n things' do
      things = ('a'..'z').map { |letter| double(name: letter) }
      top_list = TopList.new(things)

      expect(top_list.top(8, :name).length).to eq 8
    end

    it 'returns an empty array when there are no things' do
      expect(TopList.new([]).top(10, :name)).to eq []
    end
  end
end
