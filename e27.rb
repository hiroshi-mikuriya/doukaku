def group_by_story(cards)
  dst = []
  cards.group_by { |a| a[0] }.each do |cc|
    tmp = nil
    pairs = []
    cc[1].sort_by { |b| b[1] }.each.with_index do |c, i|
      if i.positive? && tmp[1].to_i == c[1].to_i - 1
        pairs.push c
      else
        dst.push pairs if pairs.size > 1
        pairs = [c]
      end
      tmp = c
    end
    dst.push pairs if pairs.size > 1
  end
  dst
end

def group_by_kind(cards)
  cc = cards.map { |a| "#{(a[1].to_i + 65).chr}#{a[0].ord - 65}" }
  b = group_by_story(cc)
  b.map do |c|
    c.map { |a| "#{(a[1].to_i + 65).chr}#{a[0].ord - 65}" }
  end
end

def calc(src)
  cards = src.split(',')
  pairs = []
  loop do
    story = group_by_story(cards)
    kind = group_by_kind(cards)
    a = story.concat(kind)
    break if a.size.zero?
    b = a.max_by(&:size)
    pairs.push b
    b.each { |c| cards.delete(c) }
  end
  p pairs
  score = pairs.map { |a| (a.size - 1)**2 }.inject(&:+) || 0
  score.zero? ? '-' : score.to_s
end

DATA.each do |d|
  n, src, exp = d.split
  act = calc(src)
  puts "#{n} #{act} != #{exp} (#{src})" if act != exp
end

__END__
0	A1,A2,A3,A4,B3,C3,D5,E5	11	A1A2A3A4  /  B3C3  /  D5E5	リンク
1	A1,B2,C3,D4,E5,F6,G7,A8	-	n/a	リンク
2	A3,A5,A4,A6,A7,A1,A2,A8	49	A1A2A3A4A5A6A7A8	リンク
3	G2,G1,A1,F1,C1,E1,B1,D1	26	A1B1C1D1E1F1  /  G1G2	リンク
4	E3,G3,D4,F3,D3,C3,B3,A3	9	A3B3C3  /  E3F3G3  /  D3D4	リンク
5	A1,C1,C2,E3,B1,B2,A2,D3	9	A1B1C1  /  A2B2C2  /  D3E3	リンク
6	D2,E2,C1,B2,C2,B1,A2,A1	20	A2B2C2D2E2  /  A1B1C1	リンク
7	C2,B3,B4,A1,A2,B2,B1,C1	11	B1B2B3B4  /  A1A2  /  C1C2	リンク
8	D1,B1,D3,C3,D2,B2,C1,B3	4	B1B2  /  B3C3  /  C1D1  /  D2D3	リンク
9	C1,F5,F6,B2,C2,D2,F4,C3	-	n/a	リンク
10	D2,A2,C2,E2,F2,B2,C3,C1	9	C1C2C3  /  D2E2F2  /  A2B2	リンク
11	D6,E7,D8,F7,C7,G7,D7,D5	-	n/a	リンク
12	B2,B3,B4,D5,D2,D4,D3,C3	-	n/a	リンク
13	C3,D3,B2,B1,E4,E5,D4,C2	4	B1B2  /  C2C3  /  D3D4  /  E4E5	リンク
14	D3,E4,E2,C1,F4,D2,E3,C2	4	C1C2  /  D2E2  /  D3E3  /  E4F4	リンク
15	B4,C3,D5,C4,A4,C5,B5,B6	4	A4B4  /  B5B6  /  C3C4  /  C5D5	リンク
16	E9,D8,D9,D7,F8,F9,E8,E7	9	D8E8F8  /  D9E9F9  /  D7E7	リンク
17	F9,C9,D7,D9,D8,E7,E9,F8	-	n/a	リンク
18	D4,C5,B5,B6,D3,D2,D5,B7	11	D2D3D4D5  /  B5C5  /  B6B7	リンク
19	B8,D8,D7,A7,A8,D9,C8,A9	9	A7A8A9  /  D7D8D9  /  B8C8	リンク
20	F3,E3,F7,E5,E6,E4,E7,F6	11	E4E5E6E7  /  E3F3  /  F6F7	リンク
21	A9,G9,B8,A7,G7,C8,A8,G8	9	A7A8A9  /  G7G8G9  /  B8C8	リンク
22	G8,G2,G3,G9,G6,G4,G5,G7	49	G2G3G4G5G6G7G8G9	リンク
23	E9,E1,B9,D1,C9,G9,D9,F9	26	B9C9D9E9F9G9  /  D1E1	リンク
24	B9,B7,G3,A7,G4,B1,B8,B2	4	A7B7  /  B1B2  /  B8B9  /  G3G4	リンク
25	A1,B4,B3,A4,A2,B5,A3,A5	20	A1A2A3A4A5  /  B3B4B5	リンク
26	B3,D3,F3,G2,C3,A3,E3,G3	26	A3B3C3D3E3F3  /  G2G3	リンク
27	E8,D8,E7,D7,G8,G7,F7,F8	18	D7E7F7G7  /  D8E8F8G8	リンク
28	D4,B3,E4,A3,C4,E3,D3,C3	20	A3B3C3D3E3  /  C4D4E4	リンク
29	B7,B5,E4,B6,D4,A4,B4,C4	20	A4B4C4D4E4  /  B5B6B7	リンク
30	B2,B1,B7,C8,F2,B9,B8,F1	-	n/a	リンク
31	C4,C3,C5,E3,E1,E2,E4,C2	18	C2C3C4C5  /  E1E2E3E4	リンク
32	G1,E1,D1,A1,F1,A2,B1,C1	26	B1C1D1E1F1G1  /  A1A2	リンク
33	E4,C5,C4,B4,D4,D5,E5,F5	18	B4C4D4E4  /  C5D5E5F5	リンク
34	D4,G4,A4,F4,C4,A3,E4,B4	26	B4C4D4E4F4G4  /  A3A4	リンク
35	B3,A9,G4,F4,A8,B4,G8,A3	-	n/a	リンク
36	B4,E3,F4,E4,G3,A4,G4,F3	9	E3F3G3  /  E4F4G4  /  A4B4	リンク
37	E4,B3,E3,C3,A3,G3,F3,A2	4	A2A3  /  B3C3  /  E3E4  /  F3G3	リンク
38	C5,C4,C6,C8,C1,C2,C7,C3	49	C1C2C3C4C5C6C7C8	リンク
39	C4,D4,E4,F3,E3,F4,D3,G4	20	C4D4E4F4G4  /  D3E3F3	リンク
40	F2,F6,F9,F7,F5,F3,F8,F4	49	F2F3F4F5F6F7F8F9	リンク
41	A9,A3,A8,A2,B9,B8,A7,A1	9	A1A2A3  /  A7A8A9  /  B8B9	リンク
42	G9,A8,G8,A6,A9,G6,G7,A7	18	A6A7A8A9  /  G6G7G8G9	リンク
43	B8,C4,D5,D4,C8,D8,E8,B4	11	B8C8D8E8  /  B4C4  /  D4D5	リンク
44	B1,B2,F6,E4,C1,C2,F4,F5	4	B1C1  /  B2C2  /  E4F4  /  F5F6	リンク
45	B4,B3,B5,B1,B7,B8,B6,B2	49	B1B2B3B4B5B6B7B8	リンク
46	G8,A8,G7,A7,F7,G6,A6,F8	9	A6A7A8  /  G6G7G8  /  F7F8	リンク
47	B7,E7,D7,G7,C7,A7,F7,E8	11	A7B7C7D7  /  E7E8  /  F7G7	リンク
48	F3,D7,B7,D3,C3,G3,E3,D9	-	n/a	リンク
49	B3,A6,C5,A3,A4,A2,B5,A5	-	n/a	リンク
50	A8,D6,B8,C8,D7,C7,D8,E8	4	A8B8  /  C7C8  /  D6D7  /  D8E8	リンク
51	B4,D9,C4,E9,E2,G9,F9,D2	11	D9E9F9G9  /  B4C4  /  D2E2	リンク
52	B3,G9,A9,G1,A1,F1,F9,A3	-	n/a	リンク
53	G1,B1,A2,G2,B2,A1,A4,A3	11	A1A2A3A4  /  B1B2  /  G1G2	リンク
54	A7,A6,C7,B7,B5,G5,A5,F5	4	A5B5  /  A6A7  /  B7C7  /  F5G5	リンク
55	D1,D9,D4,E4,E8,B4,F8,F4	-	n/a	リンク
56	B4,A8,C8,G8,B7,A3,B3,C7	-	n/a	リンク
57	D3,G3,D7,F3,D9,B7,E3,C3	-	n/a	リンク
58	B9,B1,F2,B7,B2,C8,F1,B8	-	n/a	リンク
59	F6,E4,F4,F5,B1,B2,C1,C2	4	B1C1  /  B2C2  /  E4F4  /  F5F6	リンク
60	A5,G5,B5,B4,G6,C4,G7,A6	-	n/a	リンク
61	C4,G3,F4,B7,A1,G4,D4,D5	-	n/a	リンク
62	D7,G2,A4,A3,A7,A5,A6,F7	-	n/a	リンク
63	F7,E5,E4,E3,E7,F3,F6,E6	11	E4E5E6E7  /  E3F3  /  F6F7	リンク
64	C1,E9,D4,G5,A5,C5,C6,B5	-	n/a	リンク
65	E4,B6,A4,B4,B7,B5,C4,D4	20	A4B4C4D4E4  /  B5B6B7	リンク
66	G9,B4,D9,D2,E2,C4,F9,E9	11	D9E9F9G9  /  B4C4  /  D2E2	リンク
67	B9,B2,B7,B1,G3,A7,B8,G4	4	A7B7  /  B1B2  /  B8B9  /  G3G4	リンク
68	B2,C1,E7,E6,A2,D2,C2,A1	-	n/a	リンク
69	A4,B4,F4,G4,E3,G3,E4,F3	9	E3F3G3  /  E4F4G4  /  A4B4	リンク
70	A8,D8,D6,D7,C8,B8,E8,C7	4	A8B8  /  C7C8  /  D6D7  /  D8E8	リンク