def area_num(n)
  area = 1
  loop do
    max = Array.new(area) { |a| a * 2 + 1 }.inject(&:+)
    return area if n <= max
    area += 1
  end
end

def pos(n)
  area = area_num(n)
  mid = 1 + Array.new(area) { |a| a * 2 }.inject(&:+)
  d = mid - n
  p0 = [area, area]
  if area.odd?
    d.positive? ? [p0[0], p0[1] - d] : [p0[0] + d, p0[1]]
  else
    d.positive? ? [p0[0] - d, p0[1]] : [p0[0], p0[1] + d]
  end
end

def num(p0)
  return '-' unless p0.all?(&:positive?)
  area = p0.max
  mid = 1 + Array.new(area) { |a| a * 2 }.inject(&:+)
  if area.odd?
    p0.first == area ? mid - area + p0.last : mid + area - p0.first
  else
    p0.first == area ? mid + area - p0.last : mid - area + p0.first
  end
end

def calc(src)
  c = pos(src)
  u = num([c[0], c[1] - 1])
  d = num([c[0], c[1] + 1])
  l = num([c[0] - 1, c[1]])
  r = num([c[0] + 1, c[1]])
  [u, d, l, r].map(&:to_s).join(',')
end

DATA.each do |d|
  n, src, exp = d.split
  act = calc(src.to_i)
  puts %(#{n} #{act} != #{exp}) unless act == exp
end


__END__
0	10	9,25,-,11
1	1	-,2,-,4
2	2	1,9,-,3
3	4	-,3,1,5
4	26	25,49,-,27
5	43	42,56,44,58
6	72	71,73,57,93
7	82	81,121,-,83
8	91	92,112,90,110
9	100	-,99,65,101
10	122	121,169,-,123
11	141	142,140,104,148
12	145	-,146,144,196
13	320	321,319,261,329
14	504	503,505,465,557
15	563	564,562,498,590
16	906	905,907,895,1019
17	1047	1046,1048,1002,1134
18	1111	1068,1204,1110,1112
19	1338	1257,1401,1339,1337
20	1613	1612,1614,1588,1752
21	1845	1686,1854,1846,1844
22	1921	1922,1920,1780,1952
23	2517	2516,2518,2484,2688
24	2670	2671,2669,2535,2739
25	2798	2613,2821,2799,2797
26	2841	2778,2994,2840,2842
27	2896	2897,2895,2725,2937
28	3050	3001,3225,3049,3051
29	3354	3355,3353,3147,3375
30	3563	3564,3562,3402,3638
31	4454	4261,4525,4455,4453
32	5397	5262,5558,5396,5398
33	5592	5363,5659,5593,5591
34	6122	6121,6123,6047,6363
35	6772	6771,6773,6677,7009