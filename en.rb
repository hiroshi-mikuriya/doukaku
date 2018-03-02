def solve(src)
  { x: 172, y: 47, r:117 }
end

def test(data)
  src = data[:src]
  exp = data[:exp]
  act = solve(src)
  # puts %(#{exp} != #{act} #{src}) unless %i[x y r].all? { |s| exp[s] == act[s] }
  puts %i[x y r].all? { |s| exp[s] == act[s] } ? 'OK' : 'NG'
end

def make_data
  x, y, r = Array.new(3) { rand(256) }
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