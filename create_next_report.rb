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
  regexp = /(\|TODO\|備考\|)([^!]+)(<!-- end -->)/
  str =~ regexp
  Regexp.last_match(2)
end

f = File.open(latest_file.pash, "r")
tomotodo = pic_tomorrows f.read
f.close

tomotodo.gsub!(/\|[^\|]{2,}\|$/, '||')

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


## 1. TODO

- *本日の目標（TODO目標/できるようになりたいこと）*

|前日引き継ぎTODO|進捗|#{tomotodo}
|当日追加TODO|進捗|
|-|-|
|                                ||
|                                ||
|                                ||
|                                ||
|                                ||
|                                ||
|                                ||
|                                ||


<br>

## 2. TODOまとめ
*目標振り返り（TODO進捗/できるようになりたいこと振り返り）*

  - 
  - 
  - 

<br>


## 3. 情報技術に関する事を行った時間(20時〆)

*学習時間*

  - h
    - 昨日レポート後 h
    - 起床後 h
    - コーヒーナップ h


<br>


## 4. 本日行った問題解決

  - 
  - 
  - 


<br>


## 5. 未解決の問題
*詰まっていること（実現したいこと/現状/行ったこと/仮説）*

  - 
  - 
  - 


<br>


## 6. 進捗に寄与した新たな情報
*学んだこと（新しい気付き、学び）*

  - 
  - 
  - 


<br>

## 7. 感想
- *感想（一日の感想、雑談）*

  - 
  - 
  - 


<br>


## 8. 明日への引き継ぎTODO
*明日の目標（TODO目標/できるようになりたいこと）*

|TODO|備考|
|-|-|

<!-- end -->

<br>


## 9. 明日への引き継ぎコメント

none


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