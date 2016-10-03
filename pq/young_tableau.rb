def right(yt, r, c)
  return nil if c >= yt[0].length - 1
  yt[r][c+1]
end

def down(yt, r, c)
  return nil if r >= yt.length - 1
  yt[r+1][c]
end

def extract_min yt
  min = yt[0][0]
  r = 0
  c = 0
  
  while r < yt.length && c < yt[0].length
    right = right(yt, r, c)
    down = down(yt, r, c)
   
    go_down = false
    if right.nil?
      if down.nil?
        yt[r][c] = Float::INFINITY
        return min
      end
      go_down = true
    else 
      go_down = !down.nil? && down < right
    end
    
    if go_down
      yt[r][c] = down
      r += 1
    else
      yt[r][c] = right
      c += 1
    end
  end
end
