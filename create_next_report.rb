# rubocop:disable all
def relative_ls = Dir[File.dirname(__FILE__) + "/*"]

class IntFilesLatest
  attr_reader :name_int,:name
  def initialize(ls,extension)
    regexp = /(\d+)\.#{extension}$/
    int_ar = ls.map do
      _1 =~ regexp
      lm = Regexp.last_match(1)
      lm ? lm.to_i : 0
    end

    @ls = ls
    @extension = extension
    @name_int = int_ar.max
    @name = "#{@name_int}.#{extension}"
  end

  def pash = @ls.find{_1.match? /#{name}$/}
end

latest_file = IntFilesLatest.new(relative_ls,"md")

def pic_tomorrows str
  regexp = /(- \*明日の目標（TODO目標\/できるようになりたいこと）\*)([^!]+)(<!-- end -->)/
  str =~ regexp
  Regexp.last_match(2)
end

f = File.open(latest_file.pash, "r")
tomotodo = pic_tomorrows f.read
f.close
# puts tomotodo

def yyMMdd_split(dateint) = {
  yy:("%02d" % (dateint/10000%100)),
  MM:("%02d" % (dateint/100%100)),
  dd:("%02d" % (dateint%100))
}

df = yyMMdd_split(latest_file.name_int+1)

# EOD (End of Documentの略)
# EOF (End of Fileの略)
# EOL (End of Lineの略)
# EOM (End of Messageの略)
# EOS (End of Stringの略)
# EOT (End of Textの略)
tmpl = <<"EOS"
# 日報 #{df[:MM]}/#{df[:dd]}
[^1](#remarks)[^2](#remarks)


- *本日の目標（TODO目標/できるようになりたいこと）*#{tomotodo}

<br>


- *学習時間*

  - h 
    - 昨日レポート後 h
    - 起床後 h


<br>


- *目標振り返り（TODO進捗/できるようになりたいこと振り返り）*

  - 
  - 
  - 


<br>


- 解決済の問題

  - privateの日報もつけるようにしてより仮説的なこと出来たらやりたいみたいな事を保存できるようにした
  - 
  - 


<br>


- 未解決の問題 *詰まっていること（実現したいこと/現状/行ったこと/仮説）*

  - 
  - 
  - 


<br>


- *学んだこと（新しい気付き、学び）*

  - 
  - 
  - 


<br>


- *感想（一日の感想、雑談）*

  - 
  - 
  - 


<br>


- *明日の目標（TODO目標/できるようになりたいこと）*

  - 
  - 
  - 
  - 
  

<!-- end -->

<br>


<span id="remarks" style="font-size:x-small">
  Remarks<br>
  ^1 <br>
  ^2 <br>
</span>


<br>

EOS


f = File.new("#{File.dirname(__FILE__)}/#{latest_file.name_int+1}.md", 'w')
puts "File.write(tmpl) -> \"#{f.path}\""
f.write(tmpl)
f.close

# rubocop:enable all