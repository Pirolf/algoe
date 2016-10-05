def right(yt, r, c)
  return nil if c >= yt[0].length - 1
  yt[r][c+1]
end

def down(yt, r, c)
  return nil if r >= yt.length - 1
  yt[r+1][c]
end

def left(yt, r, c)
  return nil if c <= 0
  yt[r][c-1]
end

def up(yt, r, c)
  return nil if r <= 0
  yt[r-1][c]
end

def exchange(yt, r1, c1, r2, c2)
  temp = yt[r2][c2]
  yt[r2][c2] = yt[r1][c1]
  yt[r1][c1] = temp
end

def insert(yt, x)
  r = yt.length - 1
  c = yt[0].length - 1

  yt[r][c] = x

  while r >= 0 && c >= 0
    left = left(yt, r, c)
    up = up(yt, r, c)

    curr = yt[r][c]

    go_up = false
    if left.nil?
      return if up.nil? || curr >= up
      go_up = true
    else
      if !up.nil?
        return if curr >= up && curr >= left
        go_up = up > left
      end
    end

    if go_up
      exchange(yt, r, c, r-1, c)
      r -= 1
    else
      exchange(yt, r, c, r, c-1)
      c -= 1
    end
  end
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
        if yt[-1] && yt[-1].first == Float::INFINITY && yt[-1].last == Float::INFINITY
          yt.delete_at r
        end

        if yt.first && yt.first[-1] == Float::INFINITY && yt.last[-1] == Float::INFINITY
          (0..yt.length-1).each do |x|
            yt[x].pop
          end
        end
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
