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
    		ans[pas[0]] = json[key]
    	end
    	puts "Multi Image for #{id} " if ar.size > 1
    end
    return ans
  end
end

class BABABA
    def load_lays
        require 'sqlite3'
        require 'json'
        db = SQLite3::Database.new("cards.cdb")
        json = JSON.parse(File.open("images_wikia.json","r:UTF-8"){|f| f.read})
        pas = {}
        data = Hash[db.execute 'select id,name from texts']
        for id in data.keys
            name = data[id]
            pas[name] = [] if pas[name] == nil
            pas[name].push id
        end
        ids = pas.values
        #f = File.open("CHECK.txt","w")
        #for id in ids
        #    f.write(id)
        #    f.write("\n")
        #end
        #f.close
        ans = {}
        for key in json.keys
            id = key.to_i
            for idgroup in ids
                if idgroup.include?(id)
                    idgroup.each{|i| ans[i] = json[key]} 
                    next             # 优雅？什么东西？能当饭吃么？
                end
            end
        end
        return ans
    end
end


ans = BABABA.new.load_lays
open('wiki.json', 'w:UTF-8'){|f|f.write ans.to_json}