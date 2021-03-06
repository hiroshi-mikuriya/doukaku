SYM = %i[x y].freeze

def dup(s0, s1)
  res = SYM.map { |s| s0[s].to_a & s1[s].to_a }
  return nil if res.any?(&:empty?)

  SYM.zip(res.map { |xy| (xy.min...(xy.max + 1)) }).to_h
end

def calc(src)
  # puts src
  src_sq = src.split('/').map do |a|
    s = a.chars.map { |b| b.to_i(36) }
    x = (s[0]...s[2])
    y = (s[1]...s[3])
    SYM.zip([x, y]).to_h
  end.freeze
  # puts ['src_sq', src_sq]
  all_sq = src_sq.each_with_object([]) do |s0, o|
    o.push(s0)
    src_sq.each do |s1|
      d = dup(s0, s1)
      o.push(d) if d
      # TODO: 6のケースを拾えていない
    end
  end.uniq.freeze
  # puts ['all_sq', all_sq]
  correct_sq = all_sq.select do |s0|
    all_sq.all? do |s1|
      a = dup(s0, s1)
      a.nil? || a == s0
    end
  end.freeze
  area = correct_sq.map { |a| a[:x].size * a[:y].size }
  area.sort.map(&:to_s).join(',')
end

# p dup({x:(0...2), y:(0...2)}, {x:(0...5), y:(0...5)})
# p dup({x:(0...2), y:(0...2)}, {x:(1...5), y:(1...5)})
# p dup({x:(0...2), y:(0...2)}, {x:(1...5), y:(2...5)})
# p dup({x:(0...2), y:(0...2)}, {x:(2...5), y:(2...5)})
# p dup({:x=>2...31, :y=>19...30}, {:x=>22...31, :y=>19...30})

t = Time.now
DATA.each do |d|
  n, src, exp = d.split
  # next if n.to_i != 6
  act = calc(src)
  if act == exp
    puts "#{n} OK"
  else
    puts "#{n} ng #{src} #{act} != #{exp}"
  end
end
p Time.now - t

__END__
0	43gw/d7qq/mlop	8,57	リンク
1	034a	28	リンク
2	06qr/8pnq	15	リンク
3	c1th/b2qy	210	リンク
4	c8wz/gbsg/i0xd	20	リンク
5	97uv/2g5x/eihv	39,51	リンク
6	254d/2jvu/mjvu	16,99,220	リンク
7	ggiu/ggzu/g5ig	22,28,238	リンク
8	jbnc/i7xe/i7je/icje	2,4,5	リンク
9	3cey/0fzo	27,33,99,110,189	リンク
10	00ab/p0zd/0ofz/87rs	8,12,28	リンク
11	1dsy/2d9s/2s9y	21,42,105,399	リンク
12	28db/d0lm/d1i8/l0w5	33,35,55	リンク
13	3aen/4fir/1lev	2,20,40,48,60	リンク
14	j7ou/3rms/m4vs	3,10,16,42,60	リンク
15	336a/3rkw/jlor/3akw	6,21,24,85	リンク
16	21om/87bv/67cv	9,15,18,27,30,45	リンク
17	4hhx/056u/4rvu	6,20,33,39,42,110	リンク
18	b0sh/pgxt/88lq/amux	3,20,35,44,90	リンク
19	c0hc/h6md/fdmk/4cfj	2,35,49,60,77	リンク
20	0liz/ilvz/0lvr/0rvz	78,104,108,144	リンク
21	81ib/q1zb/8cir/qczr	90,100,135,150	リンク
22	h7t8/t8ye/g8he/hetz	6,12,30,72,252	リンク
23	b5qy/o6qc/21tb/qoyu/b5eu	2,10,18,48,57	リンク
24	eajn/jkln/j8ua/nkun/u4wy	6,21,22,60,65	リンク
25	wwzz/nfuw/nfzz/41vw/l1r2/nfrg	4,6,9,17	リンク
26	46rb/t6xb/m7zk/4hrj/thxj	4,8,10,16,20,36	リンク
27	olwx/ogul/ogwx/ogux/agux	10,24,30,72,238	リンク
28	b7un/c3hv/fiyo/h6xm	2,10,12,13,16,20,52,143	リンク
29	d6qa/o4qr/tcur/9bto	2,4,6,8,15,26,39,44,195	リンク
30	2lsx/54hf/k3yi/8dhw/bhny	3,12,18,24,33,60,66	リンク
31	apcx/a8pv/7uwx/a2c8/c8pu	2,4,9,10,12,13,34,286	リンク
32	7yjz/jywz/7ejz/j5wy/bejz/jewy	4,8,13,80,117,160,260	リンク
33	d0wk/5dqu/6lqs/77ae/f4mq/56bm	3,4,5,7,14,18,28,35,49,63	リンク
34	d4gn/94in/d4rs/94xu/97xn	6,9,12,18,27,32,48,64,70,96,144	リンク
35	l5wh/wdxn/60xs/c5fd/jpwx/mgqx	4,9,10,12,15,18,20,24,30,32	リンク
36	5178/58xk/uixk/71u8/71uk/71ui/51ui	4,6,14,20,30,46,161,230	リンク
37	m8sp/mosp/2imp/i8sp/2isp/i8si/misp/iosp	4,6,24,36,40,60,112	リンク
38	34d5/253k/f4m5/m5rk/2o3u/3udy/fumy/moru	6,7,10,15,28,30,40,75	リンク
39	2ilw/mbnc/n9wj/9dmy/6qwy/2ekh/9dkh	1,6,11,18,21,33,72,80,90,96	リンク
40	j0le/10uo/q6ue/jeqt/jelf/l6xf	2,4,5,27,28,32,35,36,40,54,63,432	リンク
41	j4mu/31r5/qeyf/0f5h/r0v5/00qi/j5kf/jlru	3,4,8,9,10,10,20,27,45,52	リンク
42	g8kc/dbuv/gbkc/dbgv/evuw/dbui/d8kw	1,4,6,9,10,12,21,24,39,52,70,130	リンク
43	apry/a0ry/a0hx/60hp/6xhy/a0hp/a0hy/6phy/6phx	4,7,32,56,90,100,175,250	リンク
44	1eok/33by/d0kz/1rnw	10,10,12,12,14,15,16,21,24,35,40,42,48,49,56,88,98	リンク
45	0qbs/6cws/l6xj/659q/03lc/bclp/96dj/96wc	10,12,13,14,14,21,24,42,48,66,77	リンク
46	q8sr/98yu/clyn/s8yl/9lqr/0rsu/0l9m/0n9u	4,8,9,12,26,27,28,36,42,57,78,221	リンク
47	5sjy/jbsy/8dgp/gkvp/gdvh/jhvp/i2vk	3,4,6,8,9,12,15,15,18,27,36,45,81,84,96	リンク
48	42va/10nf/23l6/c2uw/3hpo/4ofu/m7sv	3,5,6,8,8,15,18,20,21,24,27,32,48,50,63,70	リンク
49	84lj/10j1/wcxd/ljnl/1njx/01xd/00x1/81wq/1c8q	1,1,4,7,11,14,18,21,33,70,78,117,126	リンク
50	kfvg/76vq/136d/6gvq/6g7q/137g/7dmz/63m6/m3vz	2,3,9,10,27,45,50,81,81,90,105,135,150	リンク
51	4eht/38jt/jeym/htjv/eeyv/eejt/3myv/h1jt/hejm	4,6,7,12,14,14,16,21,22,24,70,80,120,135	リンク
52	smuz/04c7/28zc/83ri/cihu/8flm/masw/8ivo	2,4,6,8,10,10,12,16,16,20,22,24,24,30,30,36,39,48	リンク
53	7fuu/17fd/6cpg/fghu/ahnt/adww/rhxz/4hxl/0pby	1,2,2,2,3,3,4,4,4,5,8,8,9,10,12,12,12,12,15,15,16,16,20,24,27,30,32,48	リンク