def match_count(t, reg)
  cnt = 0
  while t =~ reg
    cnt += 1
    i = t.index($1)
    t = t[i + 1, t.size - i - 1]
  end
  cnt
end

def num_count(t)
  regh = /(\D{2}.{7}\D\d{2}\D.{7}\D{2})/
  regv = /(\D.{8}\D\d\D.{7}\D\d\D.{8}\D)/
  [regh, regv].map { |reg| match_count(t, reg) }.inject { |a, e| a + e }
end

def wb_count(src)
  t = ['a' * 10, src.split('/').map { |a| 'a%08ba' % a.hex }, 'a' * 10].flatten.join
  %w[1 0].map { |a| num_count(t.gsub(a, 'a')) }.join(',')
end

DATA.each do |d|
  n, src, exp, _link = d.split
  act = wb_count(src)
  puts %(#{n} : #{src}  #{act} != #{exp}) if act != exp
end

__END__
0   dc/bc/a7/59/03/d5/d4/ea     2,3     リンク
1   ff/ff/ff/ff/ff/ff/ff/ff     0,0     リンク
2   00/00/00/00/00/00/00/00     0,0     リンク
3   cc/33/cc/33/cc/33/cc/33     16,16   リンク
4   aa/aa/55/55/aa/aa/55/55     16,16   リンク
5   ac/a3/5c/53/ca/3a/c5/35     8,8     リンク
6   db/00/db/00/db/00/aa/aa     0,13    リンク
7   24/24/db/24/24/db/24/24     0,12    リンク
8   d7/d7/e9/f1/f7/de/60/56     3,2     リンク
9   17/7d/64/9b/a5/39/53/a6     2,2     リンク
10  bb/8f/18/fb/89/c2/c7/35     1,2     リンク
11  6d/63/20/08/54/cd/32/4f     2,2     リンク
12  a9/ca/cd/46/99/e6/f0/30     2,2     リンク
13  5b/70/fd/45/e2/a1/ab/9a     1,2     リンク
14  24/e4/a8/12/e1/a6/3f/f3     2,1     リンク
15  79/32/2e/07/d5/10/e7/9d     2,2     リンク
16  60/bc/ab/ec/1f/eb/63/2c     4,2     リンク
17  a5/dd/92/4e/67/c6/dc/34     6,1     リンク
18  aa/96/6d/67/d2/a8/ac/90     3,2     リンク
19  95/72/7d/5c/47/dc/ef/99     4,0     リンク
20  17/d6/6a/27/1f/25/26/b8     2,1     リンク
21  f0/f3/76/c5/31/ca/6b/ae     1,2     リンク
22  01/59/26/fa/8c/70/12/cd     1,4     リンク
23  1a/c3/1f/0b/83/b6/81/0d     0,5     リンク
24  4c/49/05/cf/54/bb/1f/da     1,2     リンク
25  eb/7c/d5/09/2a/c2/14/6b     0,7     リンク
26  b4/d3/4c/c4/ed/19/e8/63     1,3     リンク
27  bd/bc/6d/60/9b/00/9a/32     2,4     リンク
28  94/97/3f/e3/c7/06/15/c0     2,2     リンク
29  5f/1d/67/16/b8/f7/0a/2a     2,2     リンク
30  df/e6/f9/4f/59/e9/1f/ee     3,0     リンク
31  5a/53/9a/9a/73/b4/37/07     3,2     リンク
32  bd/87/7c/e7/c0/37/82/da     2,3     リンク
33  3d/c0/13/ac/57/3d/15/78     2,2     リンク
34  63/64/54/3a/40/28/4e/4e     0,3     リンク
35  f6/81/c9/15/00/4c/a0/a8     1,4     リンク
36  19/41/df/f8/e3/74/6b/9b     4,2     リンク
37  d5/0b/dd/35/3b/d2/0b/6b     1,5     リンク
38  08/b7/91/f3/6e/3c/74/a0     0,0     リンク
39  b8/a8/b4/a6/93/2c/94/3f     0,0     リンク
40  88/22/21/ee/dc/19/43/01     0,0     リンク
41  e1/ee/35/bc/fc/00/8e/fe     0,0     リンク
42  3c/42/63/5f/27/47/07/90     0,0     リンク