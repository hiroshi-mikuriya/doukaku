class Guruguru
  def initialize(b, x, y)
    @b = b.to_i
    @x, @y = [x, y].map { |a| a.to_i(@b) }
    @keta = { min: x.size, max: y.size }.freeze
  end

  def calc
    @count = 0
    (1...@b).each { |n| countup(n.to_s(@b)) }
    @count
  end

  private

  def countup(src)
    @count += 1 if @keta[:min] <= src.size && (@x..@y).cover?(src.to_i(@b))
    return if @keta[:max] <= src.size

    n0 = src[-1].to_i(@b)
    @b.times do |n|
      countup(src + n.to_s(@b)) if n0 == n || (n0 + 1) % @b == n
    end
  end
end

DATA.each do |d|
  n, src, exp = d.split
  act = Guruguru.new(*src.split(',')).calc
  if act == exp.to_i
    puts "#{n} OK"
  else
    puts "#{n} ng #{src} #{act} != #{exp}"
  end
end

__END__
0	4,1313,3012	12
1	10,100,110	0
2	36,zoo,zyz	0
3	4,1300000,2222221	0
4	2,1,1	1
5	2,1000,1110	7
6	4,21,132	8
7	10,28,79	10
8	36,q,1r	12
9	28,bjb,g9a	16
10	20,2i9d,5id4	24
11	5,12000,24141	24
12	6,1245,5145	28
13	36,1,z	35
14	14,277,dc1	42
15	35,9iy,l5p	44
16	17,7be,19b1	44
17	18,96f,236g	52
18	23,b1f,1k81	56
19	6,143424,353115	64
20	5,3401,40123	67
21	4,321,123022	102
22	13,1b0,8a72	108
23	20,62,339f	124
24	24,f8h,bcn0	124
25	31,do3,78no	124
26	17,727,ced4	136
27	5,14,222243	154
28	16,3c5,100bb	168
29	9,353,80016	200
30	21,h7d,34504	220
31	11,20a,78926	224
32	12,b0,77996	238
33	3,212,11112012	254
34	22,6f2,789hd	340
35	36,5l6,tvmw	352
36	25,db8,99b08	376
37	32,hpi,556a7	376
38	29,1cl,456d2	396
39	34,dli,455u7	404
40	15,ced,3345c1	424
41	30,601,7780o	428
42	3,22,22000021	445
43	5,440,4012303	446
44	27,hg,aaamk	480
45	33,suv,defn7	480
46	2,11,111101110	492
47	35,60e,9aamd	528
48	7,33,3445635	542
49	4,120,22330013	550
50	23,8fk,lm066	564
51	6,142,5001252	568
52	8,111,3344567	572
53	26,4na,klmib	600
54	19,32a,6678g3	672
55	7,605,6011223	680
56	6,15,11235050	692
57	9,664,5567833	746
58	10,909,4556846	746
59	10,991,5555766	769
60	8,757,7700001	812
61	36,6pku,27wr28	856
62	35,6n89a,j1dlik	1024
63	34,7gehm,m0anuo	1088
64	10,3268665,134217728	1856
65	11,571016a,47352388a	2624
66	4,10030022033,10203020123103	21504
67	3,22111101011101,11021122211120221	100352
68	2,101001011010110000110101,110101110001110110110101	3240321