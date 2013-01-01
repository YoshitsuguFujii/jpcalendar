# coding: utf-8

#
# utilクラス
#
module Util
  module_function

  # tag_wrap {{{
  # 指定したタグでかこむ
  # ブロックが渡されてない時はただのタグを生成する
  # Railsのtagまたはcontent_tagでよかったんじゃないか説浮上。なぜ作ったのかはその時きっと疲れていたから
  def tag_wrap(tag,options={})
    attr_id = " id='#{options[:id]}'" if options[:id]
    attr_class = " class='#{options[:class]}'"  if options[:class]

    tag = tag.to_s if tag.is_a?(Symbol)
    if block_given?
      "<#{tag + (attr_id  || "") + (attr_class || "")}>#{yield}</#{tag}>"
    else
      "<#{tag} />"
    end
  end
  # }}}

  def is_numeric?(num) #{{{
    num.to_s =~ /^[0-9]+$/ || false
  rescue
    false
  end
  # }}}

  def expr_not_nil(value, &expression) #{{{
    return nil if value.nil? || value.empty?
    expression.call if expression
  end #}}}
end
