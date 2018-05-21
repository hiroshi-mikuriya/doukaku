PTN = { 'a' => [0, 1, 2, 0], 'b' => [0, 1, 0, 2, 0] }.freeze

def conv(buf, ab)
  buf.map { |n| PTN[ab].map { |a| (n + a) % 3 } }.flatten
end

def calc(src)
  s = src.split(',')
  pos = s.first.to_i - 1
  ab = s.last.chars
  count = ab.inject(1) { |a, e| a * (e == 'a' ? 4 : 5) }
  return 'x' if count <= pos
  d = 0
  ab.each do |a|
    ptn = PTN[a]
    ppos = pos * ptn.size / count
    count -= ptn.size * ppos
    d = (d + ptn[ppos]) % 3
    p [ptn, ppos, count, d]
  end
  # o = [0]
  # ab.each { |a| o = conv(o, a) }
  %w[0 + -][d]
end

DATA.each do |d|
  n, src, exp, _link = d.split
  act = calc(src)
  puts %(#{n} #{act} != #{exp}) unless act == exp
end

__END__
0	120,aabb	0	リンク
1	100,a	x	リンク
2	3,a	-	リンク
3	3,b	0	リンク
4	9,aa	-	リンク
5	10,bb	+	リンク
6	11,ab	-	リンク
7	12,ba	0	リンク
8	7,aaa	0	リンク
9	17,baa	+	リンク
10	28,bba	-	リンク
11	82,bba	+	リンク
12	35,baa	-	リンク
13	254,babb	+	リンク
14	462,abba	x	リンク
15	226,bbba	0	リンク
16	345,bbba	0	リンク
17	256,aaaa	0	リンク
18	11,aaab	-	リンク
19	241,abaab	-	リンク
20	490,aabaa	0	リンク
21	1305,bbbaa	0	リンク
22	1102,ababa	-	リンク
23	1077,abbab	-	リンク
24	281,aabaa	-	リンク
25	2218,abbaaa	+	リンク
26	4095,bbabbb	+	リンク
27	2750,abbaab	+	リンク
28	5573,bbaaba	+	リンク
29	6644,aaabba	x	リンク
30	8109,bbbbba	+	リンク
31	3860,aaaabbb	+	リンク
32	59222,bbbbbba	0	リンク
33	14956,baabbab	-	リンク
34	14894,ababbba	+	リンク
35	3163,aaaaaab	-	リンク
36	21917,babaaaa	+	リンク
37	178620,aabbbaab	x	リンク
38	96709,babbaaaa	0	リンク
39	74116,abababaa	-	リンク
40	22025,abbbbabb	0	リンク
41	8612,aaaabbaa	-	リンク
42	153868,bbbabbab	-	リンク
43	747769,abbabaaba	x	リンク
44	541589,baabbbbab	-	リンク
45	787443,ababbbbab	-	リンク
46	129549,ababaaaaa	0	リンク
47	837323,aabbbabab	x	リンク
48	140592,bbbbabbab	+	リンク
49	219669,ababbabbab	-	リンク
50	500261,bbababaabb	-	リンク
51	966503,aaabababbb	0	リンク
52	443603,baabaababb	+	リンク
53	3912,aabbababaa	0	リンク
54	2926358,bbabbbbaba	0	リンク
55	18104279,bbbaababbab	-	リンク
56	3849980,aaabaaaaaba	0	リンク
57	9276072,baabaabaaab	0	リンク
58	11202113,baaaaabbbba	0	リンク
59	5432578,abaabbaaaaa	-	リンク
60	17363025,bbaabababbb	0	リンク
61	24147656,baabaabbbbab	0	リンク
62	1078733,bbbaaaabbbbb	+	リンク
63	38623426,abaabababbaa	-	リンク
64	19312285,bbaababbaaba	+	リンク
65	11485959,baaaaababaaa	-	リンク
66	36831104,babbbbbbabab	+	リンク