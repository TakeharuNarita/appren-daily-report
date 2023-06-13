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
  regexp = /(_明日の目標（TODO 目標\/できるようになりたいこと）_\n)([^!]+)(\n<!-- end -->)/
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

_本日の目標（TODO 目標/できるようになりたいこと）_
#{tomotodo}
<br>

## <li>為した事</li>

_目標振り返り（TODO 進捗/できるようになりたいこと振り返り）_

- 
- 
- 
- 

<br>

## <li>情報技術に関する事を行った時間(20 時〆)</li>

_学習時間_

- 10h
  - 昨日レポート後 h
  - 起床後 6.5h
  - コーヒーナップ後 5.5h

<br>

## <li>成った事</li>

- 

<br>

## <li>成らなかった事</li>

_詰まっていること（実現したいこと/現状/行ったこと/仮説）_

- 
- 
- 

<br>

## <li>情報</li>

_学んだこと（新しい気付き、学び）_

- 
- 

<br>

## <li>感想</li>

_感想（一日の感想、雑談）_

- 
- 
- 

<br>

## <li>明日為すべき事</li>

_明日の目標（TODO 目標/できるようになりたいこと）_

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