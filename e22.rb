class Node
  def initialize(rng, h)
    @rng = rng.to_a
    @h = h
    @pos = nil
    @child = Node.new((0..rng.last), @h - 1) if @h > 1
  end

  def end?
    @pos && @rng.size <= @pos
  end

  def get
    raise 'bug' if end?
    if @pos.nil?
      @pos = 0
      return ''
    end
    if defined? @child
      if @child.end?
        @pos += 1
        return '' if end?
        @child = Node.new(@n, @h - 1)
      end
      @rng[@pos].to_s(@rng.last) + @child.get
    else
      r = @pos
      @pos += 1
      @rng[r].to_s(@rng.last)
    end
  end
end

node = Node.new((1..2), 3)
p node.get until node.end?
exit

def calc(m, n, b, x)
  aa = (m..n).map { |a| a.to_s(b) }.sort
  aa[x - 1].to_i(b)
end

def calc2(m, n, b, x)
  k = Math.log(n + 1, b).ceil.to_i
  node = Node.new(b, k)
  count = 0
  until node.end?
    a = node.get
    next if a.empty? || a[0].to_i.zero?
    dec = a.to_i(b)
    next unless (m..n).cover? dec
    count += 1
    return dec if count == x
  end
  raise 'failed'
end

DATA.each do |d|
  n, src, exp = d.split.yield_self { |a, b, c| [a.to_i, b.split(',').map(&:to_i), c.to_i] }
  act = calc2(*src)
  puts "#{n} " + (act == exp ? 'ok' : "ng #{act} != #{exp} #{src}")
end

__END__
0	2,15,3,8	14
1	6,8,8,1	8
2	6,6,5,1	6
3	4,11,5,2	6
4	9,17,8,2	10
5	73,82,18,5	77
6	70,149,2,48	95
7	82,119,15,26	107
8	40,127,26,47	86
9	851,950,31,89	939
10	660,807,34,143	802
11	962,1227,34,186	1075
12	544,1258,25,245	869
13	1208,7380,2,803	4630
14	2,100000000,10,1	10
15	1642,6626,3,4354	2029
16	8623,15873,2,4188	12810
17	7013,16409,17,3919	10931
18	7222,13243,19,3623	10844
19	4421,87412,5,62080	60697
20	51812,61593,22,2957	54768
21	44260,67742,17,15128	59387
22	90929,696974,36,84356	175284
23	1,100000000,2,50000000	92108858
24	101262,924931,7,341846	358105
25	211114,675661,33,312769	523882
26	1,100000000,36,50000000	11855060
27	1,100000000,10,100000000	99999999
28	826566,1444644,36,186226	1012791
29	6687091,6985458,4,251580	6938670
30	4219082,6179401,12,538113	4757194
31	7781931,8634872,23,217457	7999387
32	818218,64845924,12,57752258	30039084
33	4987258,11760092,32,6741567	11728824
34	7075964,28431054,22,11548591	18624554
35	26065964,66252692,18,29196596	63208819
36	66097362,104618756,16,32740764	98838125