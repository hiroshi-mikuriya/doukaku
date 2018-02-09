def calc(src)
  a = '123456789'.chars
  yoko = proc do |i, t|
    next if t.nil?
    x = i % 3 + t * 3
    y = (i + 1) % 3 + t * 3
    a[x], a[y] = a[y], a[x]
  end
  tate = proc do |i, t|
    next if t.nil?
    x = i * 3 + t
    y = ((i + 1) % 3) * 3 + t
    a[x], a[y] = a[y], a[x]
  end
  src.chars.each do |c|
    2.times { |i| yoko.call(i, 'abc'.index(c)) }
    2.times.reverse_each { |i| tate.call(i, 'def'.index(c)) }
    2.times.reverse_each { |i| yoko.call(i, 'ghi'.reverse.index(c)) }
    2.times { |i| tate.call(i, 'jkl'.reverse.index(c)) }
  end
  a.each_slice(3).to_a.map(&:join).join('/')
end

DATA.each do |d|
  n, src, exp, _link = d.split
  act = calc src
  puts %(#{n} #{exp} != #{act}) unless act == exp
end

__END__
0 	aegj 	286/435/971 	リンク
1 	a 	231/456/789 	リンク
2 	e 	183/426/759 	リンク
3 	g 	123/456/978 	リンク
4 	j 	126/459/783 	リンク
5 	bb 	123/645/789 	リンク
6 	jjj 	123/456/789 	リンク
7 	bd 	723/164/589 	リンク
8 	ah 	231/645/789 	リンク
9 	bj 	124/569/783 	リンク
10 	db 	723/561/489 	リンク
11 	dh 	723/615/489 	リンク
12 	dl 	123/456/789 	リンク
13 	hc 	123/645/897 	リンク
14 	gf 	128/453/976 	リンク
15 	hl 	623/745/189 	リンク
16 	ja 	261/459/783 	リンク
17 	ld 	123/456/789 	リンク
18 	ki 	315/486/729 	リンク
19 	lfa 	294/753/186 	リンク
20 	kga 	531/486/972 	リンク
21 	dbi 	372/561/489 	リンク
22 	che 	193/625/847 	リンク
23 	iea 	823/416/759 	リンク
24 	gbl 	523/964/178 	リンク
25 	egj 	186/425/973 	リンク
26 	jcf 	127/456/839 	リンク
27 	djh 	726/915/483 	リンク
28 	hld 	123/645/789 	リンク
29 	leeh 	453/678/129 	リンク
30 	heja 	851/629/743 	リンク
31 	cakh 	251/649/837 	リンク
32 	bhjik 	652/489/713 	リンク
33 	eabji 	483/269/751 	リンク
34 	cdbch 	823/156/974 	リンク
35 	ckgajc 	536/492/817 	リンク
36 	ggchha 	231/564/978 	リンク
37 	gfbkeg 	128/534/697 	リンク
38 	agfbcbf 	239/148/765 	リンク
39 	ekahijf 	123/645/789 	リンク
40 	hajdjbe 	789/432/615 	リンク
41 	elgililj 	976/325/814 	リンク
42 	chffefif 	317/629/845 	リンク
43 	ilbbihak 	462/587/319 	リンク
44 	abcdefghijkl 	123/456/789 	リンク
45 	hkijbglfaced 	768/125/493 	リンク
46 	dfkbjiechlga 	256/387/419 	リンク
47 	hgfkbidlajce 	186/745/239 	リンク
48 	baciefjhgkdl 	153/482/796 	リンク