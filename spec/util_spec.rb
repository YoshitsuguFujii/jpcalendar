# coding: utf-8
require 'spec_helper'

describe Util do

  describe "tag wrap" do #{{{

    describe "異常系" do #{{{
      context "引数なし blockなし" do
        it { lambda{ Util.tag_wrap }.should raise_error ArgumentError }
      end
    end #}}}

    describe "正常系" do #{{{
      context "引数文字列 blockなし" do
        it { Util.tag_wrap("br").should eql "<br />" }
      end

      context "引数シンボル blockなし" do
        it { Util.tag_wrap(:tr).should eql "<tr />" }
      end

      context "引数文字列 blockあり" do
        it { Util.tag_wrap("div"){"Lorem ipsum dolor sit amet"}.should eql "<div>Lorem ipsum dolor sit amet</div>" }
      end

      context "引数シンボル blockあり" do
        it { Util.tag_wrap(:div){"Lorem ipsum dolor sit amet"}.should eql "<div>Lorem ipsum dolor sit amet</div>" }
      end

      context "引数シンボル blockあり class指定あり" do
        it { Util.tag_wrap(:div,class: "mrgn"){"Lorem ipsum dolor sit amet"}.should eql "<div class='mrgn'>Lorem ipsum dolor sit amet</div>" }
      end

      context "引数シンボル blockあり id class指定あり" do
        it { Util.tag_wrap(:div,class: "mrgn", id: "tag_wrap"){"Lorem ipsum dolor sit amet"}.should eql "<div id='tag_wrap' class='mrgn'>Lorem ipsum dolor sit amet</div>" }
      end

      context "blockが空" do
        it { Util.tag_wrap(:div).should eql "<div />" }
      end
      context "blockがnil" do
        it { Util.tag_wrap(:div){ nil }.should eql "<div></div>" }
      end
    end #}}}
  end #}}}

  context "is_numeric?" do #{{{
    context "数値" do
      it { Util.is_numeric?("123456789").should be_true }
    end

    context "文字列" do
      it { Util.is_numeric?("abcあいう").should be_false }
    end

    context "数値文字列" do
      it { Util.is_numeric?("12345678abcあいう").should be_false }
    end
  end #}}}

  context "expression_not_nil" do
    let(:str) { "abcde" }
    it { Util.expr_not_nil(str).should be_nil  }
    it { Util.expr_not_nil(str){ "aaa/" + str + "/bbb"}.should eql "aaa/abcde/bbb"  }
  end #}}}

end
