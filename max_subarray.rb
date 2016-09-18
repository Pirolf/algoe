def buyStock prices
  low = 0
  high = 0
  maxProfit = -Float::INFINITY
  profit = 0

  prevPrice = prices[0]
  for i in 1..prices.length-1
    profit += prices[i] - prevPrice

    if profit < 0
      low = i
      high = i
    end

    if profit > maxProfit
      maxProfit = profit
      high = i
    end

    prevPrice = prices[i]
  end
  return [low, high]
end

# [1,2,3]
p buyStock([1,2,3]) == [0,2]
# [3,5,2,6]
p buyStock([3,5,2,6]) == [2,3]
# [5,3,9,8]
p buyStock([5,3,9,8]) == [1,2]
# [4,3,2]
p buyStock([4,3,2]) == [2,2]
