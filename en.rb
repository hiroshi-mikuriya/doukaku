def length(pt1, pt2)
  %i[x y].map { |s| (pt1[s] - pt2[s])**2 }.inject(&:+)**0.5
end

def solve(src)
  src.length.times do |i1|
    ((i1 + 1)...src.length).each do |i2|
      pt1 = src[i1]
      pt2 = src[i2]
      c = { x: (pt1[:x] + pt2[:x]) / 2, y: (pt1[:y] + pt2[:y]) / 2 }
      c[:r] = length(c, pt1)
      return c if src.all? { |pt| (length(pt, c) - c[:r]).abs <= 1 }
    end
  end
  { x: 0, y: 0, r: 0 }
end

def test(data)
  src = data[:src]
  exp = data[:exp]
  act = solve(src)
  # puts %(#{exp} != #{act} #{src}) unless %i[x y r].all? { |s| exp[s] == act[s] }
  puts %i[x y r].all? { |s| (exp[s] - act[s]).abs < 0.1 } ? 'OK' : %(#{exp} != #{act} #{src.length} points)
end

def make_data
  x, y, r = Array.new(3) { rand(2560) / 10.0 }
  count = (10...20).to_a.shuffle[0]
  src = count.times.with_object([]) do |i, o|
    an = 2 * Math::PI / count * i
    xx = x + r * Math.sin(an)
    yy = y + r * Math.cos(an)
    o.push(x: xx, y: yy)
  end
  exp = { x: x, y: y, r: r }
  { src: src, exp: exp }
end

srand(0)
10.times do |i|
  data = make_data
  print %(TEST [#{i}] )
  test(data)
end
