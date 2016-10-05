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

def bottom_right(yt, r, c)
  return nil if r >= yt.length - 1 || c >= yt[0].length-1
  yt[r+1][c+1]
end


def exchange(yt, r1, c1, r2, c2)
  temp = yt[r2][c2]
  yt[r2][c2] = yt[r1][c1]
  yt[r1][c1] = temp
end

def binary_search(a, x, i_start = 0, i_end = a.length)
  return false if i_end - i_start <= 0

  middle = (i_start + i_end)/2
  val = a[middle]
  return true if val == x

  if x > val
    return binary_search(a, x, middle+1, i_end)
  end
  return binary_search(a, x, i_start, middle)
end

def has(yt, x)
  r = 0
  c = 0

  return false if yt.empty?
  can_search = false
  while r < yt.length && c < yt[0].length
    return true if yt[r][c] == x
    max = bottom_right(yt, r, c)
    if !max.nil? && max <= x
      r += 1
      c += 1
    else
      can_search = true
      break
    end
  end

  return false if !can_search
  row = yt[r]
  in_right = binary_search(row, x, c)
  return true if in_right

  col = (0..yt.length-1).map {|n| yt[n][c]}
  return binary_search(col, x, r+1)
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
