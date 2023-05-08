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
  regexp = /(\*明日の目標（TODO目標\/できるようになりたいこと）\*\n)([^!]+)(\n<!-- end -->)/
  str =~ regexp
  Regexp.last_match(2)
end

f = File.open(latest_file.pash, "r")
tomotodo = pic_tomorrows f.read
f.close

# tomotodo.gsub!(/\|[^\|]{2,}\|$/, '||')

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


<ol>

## <li>為さねばならぬ事</li>

*本日の目標（TODO目標/できるようになりたいこと）*
#{tomotodo}
<br>

## <li>為した事</li>

*目標振り返り（TODO進捗/できるようになりたいこと振り返り）*

  - 
  - 
  - 
  - 

<br>


## <li>情報技術に関する事を行った時間(20時〆)</li>

*学習時間*

  - 10h
    - 昨日レポート後 h
    - 起床後 6.5h
    - コーヒーナップ後 5.5h

<br>


## <li>成った事</li>

  - 

<br>


## <li>成らなかった事</li>

*詰まっていること（実現したいこと/現状/行ったこと/仮説）*

  - 
  - 
  - 

<br>


## <li>ソース</li>

*学んだこと（新しい気付き、学び）*

  - 
  - 

<br>


## <li>感想</li>

*感想（一日の感想、雑談）*

  - 
  - 
  - 

<br>


## <li>明日為すべき事</li>

*明日の目標（TODO目標/できるようになりたいこと）*

  - 
  - 
  - 

<!-- end -->

<br>

</ol>


EOS


f = File.new("#{File.dirname(__FILE__)}/#{latest_file.name_int+1}.md", 'w')
puts "File.write(tmpl) -> \"#{f.path}\""
f.write(tmpl)
f.close

# rubocop:enable all