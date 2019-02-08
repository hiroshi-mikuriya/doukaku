def calc(src)
  alpha = 'abcdefghijklmnopqrstuvwxy'.freeze
  c = alpha.chars.each_slice(5).to_a.zip(src.split('/')).map { |a, b| a.zip(b.chars) }
  i = src.delete('/').index('Y')
  beg = [i % 5, i / 5]
  pos = beg
  dst = []
  d = [0, -1]
  loop do
    p0 = c[pos[1]][pos[0]]
    dst.push(p0[0])
    pos = [0, 1].map { |i0| pos[i0] + d[i0] }
    break unless pos.all? { |a| (0...5).cover? a }
    p1 = c[pos[1]][pos[0]]
    case p1[1]
    when '0' then d = d.reverse # \
    when '1' then d = d.map(&:-@).reverse # /
    when 'x' then break
    end
    break if pos == beg && d == [0, -1]
  end
  dst.sort.uniq.join
end

DATA.each do |d|
  n, src, exp = d.split
  act = calc(src)
  puts "#{n} #{act} != #{exp}" if act != exp
end

__END__
0	x...x/.1.0./..0../.Y.../0..x.	ghilnqs	リンク
1	..Y../...../...../...../.....	c	リンク
2	..x../..Y../...../...../.....	h	リンク
3	..Y.x/..1x0/11.../....0/1..1.	c	リンク
4	....1/....Y/...../...../.....	ej	リンク
5	.10../x.1../x.1x./.Y.1./...0.	bcghlq	リンク
6	0.x10/00..x/x0x.0/....0/...Y1	deinsx	リンク
7	1.01./01Y.1/..1.1/..10./0.0..	abcfgh	リンク
8	x..../x1x../0...0/....Y/.1..0	klmnot	リンク
9	...../..10./.1Y1./.01../.....	hilmnqr	リンク
10	...../..10./x.11./...../..Y..	hilmnrw	リンク
11	...../x.10x/...../x.Y1x/.....	himnqrs	リンク
12	..010/...Y1/..0../0.x../.....	defghij	リンク
13	1.0../...../.0x../Y.1x./..1..	abcfhkp	リンク
14	...../101../0.0../..Y../.....	fgklmqrv	リンク
15	1.0../00.../.x..0/0.Y1./...10	abcfghmr	リンク
16	x101./1..../.Y.x./..01./.00.1	bcghlmrs	リンク
17	x11../x.x../.0.01/..x../...Y.	bcglmnsx	リンク
18	..1.0/x0.x./0.0../x...Y/.10.1	cdehjmnot	リンク
19	..x.0/.0.../1..0x/1..1./Y.00.	klmnpqrsu	リンク
20	0.1.0/.0.xY/0...0/01..1/x00.x	cdehjmrwx	リンク
21	...0./.0.0./..101/...10/..01Y	mnpqrstwxy	リンク
22	10..0/.Y.0./0..1./....x/000..	abfghiklmn	リンク
23	10..1/...../.1010/110.1/x..Yx	lmnopqrstx	リンク
24	110../....1/x1..x/0.0.0/....Y	bcghlmrsty	リンク
25	x.101/1..../..001/010Yx/..1.1	cdehijmnos	リンク
26	x.111/x10../...0./00.1x/x.Y.1	ghklmnqrsw	リンク
27	11.../....0/11..1/1.1../.Y..1	fghijlmnoqv	リンク
28	...x1/.1.0./11.1./.01../Y..x.	cghiklmnpqru	リンク
29	.0.../110x./11..0/01.x./..Y.x	ghklmnopqrtw	リンク
30	.01.0/.110x/0...0/.01Y./x.1x.	cdeghilmnqrs	リンク
31	.1100/..1.0/1.11Y/0..1./.0..0	hijklmnopqrs	リンク
32	1..00/..11./.100./1..Y1/.....	abcdfhikmnps	リンク
33	1.0../.11x0/.00.x/Y.10./.10x0	abcfghklmpqr	リンク
34	11110/11.../.x.../.0111/0.Y0.	deijnorstwxy	リンク
35	...1./.1.0x/10..0/0Y.11/.0.x0	ghiklmnopqrst	リンク
36	...10/x111./0x.11/.0.../0.0Y.	dehijmnorswxy	リンク
37	.1x../.x1.0/0x.x./x11.1/x0Y.1	hijmoqrstvwxy	リンク
38	x.x../x110./1.1.0/0.Y.1/0.00x	hiklmnopqrstx	リンク
39	...0./11.00/10..x/..0.1/Y0.10	ghiklmnpqsuvwx	リンク
40	.110./....0/x..../.0001/11.Y.	cdfghijmnorstx	リンク
41	1.00./....1/.1.../0...0/0..1Y	abcfhkmpqrstwy	リンク
42	.1.01/..x../..100/..Y../...01	bcdgilmnoqrstvxy	リンク
43	1...0/Y..../...../...../0...1	abcdefjkoptuvwxy	リンク
44	x1..0/1..0./.Yx../0...1/.0.1.	bcdefghijklnopqrstvwx	リンク
45	1...0/.1.0./..1../..01./Y0..1	abcdefghijklmnopqrstuvwxy	リンク