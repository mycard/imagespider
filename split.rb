#encoding: UTF-8
class PAPAPA
 def load_lays
    require 'sqlite3'
    require 'json'
    db = SQLite3::Database.new("cards.cdb")
    json = JSON.parse(File.open("images_wikia.json","r:UTF-8"){|f| f.read})
    ans = {}
    for key in json.keys
    	id = key.to_i
    	ar = db.execute("select id from texts where name=(select name from texts where id = #{id} limit 1)")
    	for pas in ar
    		ans[pas.to_s] = json[key]
    	end
    	puts "Multi Image for #{id} " if ar.size > 1
    end
    return ans
  end
end

ans = PAPAPA.new.load_lays
open('wiki.json', 'w:UTF-8'){|f|f.write ans.to_json}