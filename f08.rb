def availables(status)
  seats = status.keys
  seats.each.with_object(0 => [], 1 => [], 2 => []) do |n, o|
    next unless status[n] == '-'
    i = seats.index { |s| s == n }
    left, right = [-1, 1].map { |a| status[seats[(i + a) % seats.size]] == '-' ? 0 : 1 }
    o[left + right].push(n)
  end
end

def push(status, c)
  a = availables(status)
  (0..2).each do |n|
    next unless a[n].size.positive?
    a[n].sort!
    seat = c <= 'M' ? a[n].first : a[n].last
    status[seat] = c
    break
  end
end

def calc(src)
  status = '135798642'.chars.each.with_object({}) { |n, o| o[n] = '-' }
  src.chars.each do |c|
    if c.upcase == c
      push(status, c)
    else
      seat = status.select { |_k, v| v == c.upcase }
      status[seat.keys[0]] = '-' unless seat.empty?
    end
  end
  status.map { |_k, v| v.to_s }.join
end

DATA.each do |d|
n, src, exp = d.split
act = calc(src)
puts %(#{n} #{act} != #{exp} (#{src})) unless act == exp
end

__END__
0   NABETanI    I-E--T-B-
1   A   A--------
2   Aa  ---------
3   Z   ----Z----
4   Zz  ---------
5   AaB     B--------
6   ABa     -------B-