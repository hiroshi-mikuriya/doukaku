def exist src, ptns
  ptns.each.any? do |ptn|
    ptn.each_char.all?{|c| !src.include? c}
  end
end

def proc src
  h = {
    14 =>%w(abc gc gh),
    15 =>%w(ab ge),
    16 =>%w(abc ghi gc),
    24 =>%w(dc h),
    25 =>%w(de),
    26 =>%w(hi dc),
    34 =>%w(bc fgc fgh),
    35 =>%w(b fge),
    36 =>%w(fghi bc fgc),
  }
  res = []
  h.each do |k,v|
    res.push k if exist(src, v)
  end
  res.empty? ? "-" : res.join(",")
end

DATA.each do |d|
  n, src, dst = d.split
  res = proc src
  puts "#{n} : #{src} : #{res} != #{dst}" unless res == dst
end

__END__
0   befi    14,16,24,26
1   abc 14,15,16,24,25,26,34,35,36
2   de  14,15,16,24,26,34,35,36
3   fghi    14,15,16,24,25,26,34,35,36
4   abcdefghi   -
5   ag  24,25,26,34,35,36
6   dh  14,15,16,34,35,36
7   bf  14,15,16,24,25,26
8   ch  15,25,35
9   be  14,16,24,26,34,36
10  ci  14,15,24,25,34,35