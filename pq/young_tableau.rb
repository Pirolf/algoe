def right(yt, r, c)
  return Float::INFINITY if c >= yt[0].length - 1
  yt[r][c+1]
end

def down(yt, r, c)
  return Float::INFINITY if r >= yt.length - 1
  yt[r+1][c]
end

def extract_min yt
  min = yt[0][0]
  r = 0
  c = 0
  
  while r < yt.length && c < yt[0].length
    right = right(yt, r, c)
    down = down(yt, r, c)

    if right < down
      yt[r][c] = right
      c ++
    else
      yt[r][c] = down
      r ++
    end
  end
end
