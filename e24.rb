require 'json'

def calc(a, b)
  ''
end

DATA.each do |d|
  json = JSON.parse(d, symbolize_names: true)
  %i[event_id event_url].each { |s| p [s, json[s]] }
  json[:test_data].each do |a|
    act = calc(*a[:src].split(',').map(&:to_i))
    puts "#{a[:number]} #{act} != #{a[:expected]}" unless act == a[:expected]
  end
end

__END__
{"event_id":"E24","event_url":"https://yhpg.doorkeeper.jp/events/73080","test_data":[{"number":0,"src":"16,333","expected":"38e"},{"number":1,"src":"2,100","expected":"-"},{"number":2,"src":"2,1","expected":"1"},{"number":3,"src":"2,2","expected":"-"},{"number":4,"src":"11,8","expected":"8"},{"number":5,"src":"14,9","expected":"9"},{"number":6,"src":"11,12","expected":"13"},{"number":7,"src":"7,16","expected":"34"},{"number":8,"src":"20,16","expected":"g"},{"number":9,"src":"2,17","expected":"-"},{"number":10,"src":"8,26","expected":"56"},{"number":11,"src":"16,51","expected":"3c"},{"number":12,"src":"3,77","expected":"-"},{"number":13,"src":"2,100","expected":"-"},{"number":14,"src":"9,110","expected":"1347"},{"number":15,"src":"22,127","expected":"78"},{"number":16,"src":"24,142","expected":"79"},{"number":17,"src":"30,158","expected":"5s"},{"number":18,"src":"20,213","expected":"139"},{"number":19,"src":"6,216","expected":"-"},{"number":20,"src":"9,244","expected":"235678"},{"number":21,"src":"13,253","expected":"57c"},{"number":22,"src":"19,265","expected":"19c"},{"number":23,"src":"24,314","expected":"13k"},{"number":24,"src":"16,333","expected":"38e"},{"number":25,"src":"32,353","expected":"eo"},{"number":26,"src":"25,490","expected":"1dg"},{"number":27,"src":"26,498","expected":"1bd"},{"number":28,"src":"10,500","expected":"2456789"},{"number":29,"src":"10,543","expected":"-"},{"number":30,"src":"3,897","expected":"-"},{"number":31,"src":"11,1000","expected":"1345789a"},{"number":32,"src":"9,1307","expected":"-"},{"number":33,"src":"9,1412","expected":"-"},{"number":34,"src":"26,1678","expected":"79e"},{"number":35,"src":"8,1942","expected":"-"},{"number":36,"src":"12,1950","expected":"234589ab"},{"number":37,"src":"2,2245","expected":"-"},{"number":38,"src":"18,2670","expected":"5ace"},{"number":39,"src":"5,3013","expected":"-"},{"number":40,"src":"5,3048","expected":"-"},{"number":41,"src":"14,3099","expected":"157acd"},{"number":42,"src":"27,3440","expected":"13hm"},{"number":43,"src":"13,3698","expected":"235689ab"},{"number":44,"src":"36,5592","expected":"dqs"},{"number":45,"src":"10,9505","expected":"-"},{"number":46,"src":"27,9833","expected":"49ej"},{"number":47,"src":"16,10000","expected":"123467e"},{"number":48,"src":"24,14090","expected":"14bfk"},{"number":49,"src":"29,15270","expected":"5mnq"},{"number":50,"src":"17,20000","expected":"23458cg"},{"number":51,"src":"36,20000","expected":"37bc"},{"number":52,"src":"25,24346","expected":"256bk"},{"number":53,"src":"21,27815","expected":"146adi"},{"number":54,"src":"25,28030","expected":"2aflm"},{"number":55,"src":"25,34448","expected":"3cefi"},{"number":56,"src":"36,44811","expected":"abpu"}]}