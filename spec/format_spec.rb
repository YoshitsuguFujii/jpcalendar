# coding: utf-8
require 'spec_helper'
require 'json'

#TODO ひどいんで、ちゃんと書く。いずれ。きっと。多分。
describe Jpcalender::Format do
  extend Jpcalender

  #calender_table{{{
  describe "calender table" do
    context "対象月：2012年12月" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_table(Date.new(2012, 12, 1)).should eql @expect_str}
    end

    context "対象月：2012年2月(うるう年)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_table(Date.new(2012, 2, 29)).should eql @expect_str}
    end

    context "対象月：2013年2月(not うるう年)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_table(Date.new(2013, 2, 1)).should eql @expect_str}
    end

    context "対象月：2012年9月(月曜はじまり)" do
      before do
        @expect_str=""
      end
      it { Jpcalender.calender_table(Date.new(2012, 9, 15), start_with_monday: true).should eql @expect_str}
    end


    context "対象月：2012年9月(休日を出力しない)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_table(Date.new(2012, 9, 30),holiday_off: true).should eql @expect_str}
    end

    context "対象月：2006年9月(スペース詰め)" do
      before do
        @expect_str=""
      end
      it { Jpcalender.calender_table(Date.new(2006, 9, 9), padding: " ").should eql @expect_str}
    end

    context "対象月：2007年9月(月曜はじまり 休日を出さない  スペース詰め)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_table(Date.new(2007, 9, 1),holiday_off: true, padding: " ", start_with_monday: true).should eql @expect_str}
    end

    context "対象月：2012年12月(カスタムイベント設定)" do
      before do
        @expect_str=""
        @date_event = JSON.generate({"1" => "定例会", "9" => "ディズニーランド", "14" => "会社さぼってサーフィン", "23" => "小梅と遊ぶ", "24" => "クリスマスパーティー"})
      end

      it { Jpcalender.calender_table(Date.new(2012, 12, 1), date_event: @date_event ).should eql @expect_str}
    end

    context "対象月：2012年12月(月曜はじまり 休日を出さない  スペース詰め カスタムイベント設定)" do
      before do
        @expect_str=""
        @date_event = JSON.generate({"1" => "定例会", "9" => "ディズニーランド", "14" => "会社さぼってサーフィン", "23" => "小梅と遊ぶ", "24" => "クリスマスパーティー"})
      end
      it { Jpcalender.calender_table(Date.new(2012, 12, 1),holiday_off: true, padding: " ", start_with_monday: true, date_event: @date_event ).should eql @expect_str}
    end
  end
  #}}}

  # calender_div{{{
  describe "calender div" do
    context "対象月：2012年12月" do
      before do
        @expect_str=""
      end
      it { Jpcalender.calender_div(Date.new(2012, 12, 1)).should eql @expect_str}
    end

    context "対象月：2012年2月(うるう年)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_div(Date.new(2012, 2, 1)).should eql @expect_str}
    end

    context "対象月：2013年2月(not うるう年)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_div(Date.new(2013, 2, 1)).should eql @expect_str}
    end

    context "対象月：2012年9月(月曜はじまり)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_div(Date.new(2012, 9, 1), start_with_monday: true).should eql @expect_str}
    end


    context "対象月：2012年9月(休日を出力しない)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_div(Date.new(2012, 9, 1),holiday_off: true).should eql @expect_str}
    end

    context "対象月：2006年9月(スペース詰め)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_div(Date.new(2006, 9, 1), padding: " ").should eql @expect_str}
    end

    context "対象月：2007年9月(月曜はじまり 休日を出さない  スペース詰め)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender_div(Date.new(2007, 9, 1),holiday_off: true, padding: " ", start_with_monday: true).should eql @expect_str}
    end

    context "対象月：2012年12月(カスタムイベント設定)" do
      before do
        @expect_str=""
        @date_event = JSON.generate({"1" => "定例会", "9" => "ディズニーランド", "14" => "会社さぼってサーフィン", "23" => "小梅と遊ぶ", "24" => "クリスマスパーティー"})
      end
      it { Jpcalender.calender_div(Date.new(2012, 12, 1), date_event: @date_event ).should eql @expect_str}
    end

    context "対象月：2012年12月(月曜はじまり 休日を出さない  スペース詰め カスタムイベント設定)" do
      before do
        @expect_str=""
        @date_event = JSON.generate({"1" => "定例会", "9" => "ディズニーランド", "14" => "会社さぼってサーフィン", "23" => "小梅と遊ぶ", "24" => "クリスマスパーティー"})
      end
      it { Jpcalender.calender_div(Date.new(2012, 12, 1),holiday_off: true, padding: " ", start_with_monday: true, date_event: @date_event ).should eql @expect_str}
    end
  end
  #}}}

  # calender{{{
  describe "calender" do
    context "対象月：2008年9月 (本日が月初)" do
      before do
        @expect_str=""
      end

      it { Jpcalender.calender(Date.new(2012, 12, 1)).should eql @expect_str}
    end


    context "対象月：2008年9月 (本日が中間ぐらい)" do
      before do
        @expect_str=""
      end
      it { Jpcalender.calender(Date.new(2012, 12, 15)).should eql @expect_str}
    end


    context "対象月：2008年9月 (本日が月末)" do
      before do
        @expect_str=""
      end
      it { Jpcalender.calender(Date.new(2012, 12, 31)).should eql @expect_str}
    end

    context "対象月：2008年9月 (タグ指定なし)" do
      before do
        @expect_str=""
      end
      it { Jpcalender.calender(Date.new(2008, 9, 1)).should eql @expect_str}
    end

    context "対象月：2008年9月 (タグ指定あり)" do
      before do
        @options = {wrap_tag: :section, row_tag: :ul, header_cell_tag: :li, body_cell_tag: :li}
        @expect_str=""
      end
      it { Jpcalender.calender(Date.new(2008, 9, 1), @options).should eql @expect_str }
    end

    context "対象月：2008年9月 (スペース詰め)" do
      before do
        @options = {padding: " ",wrap_tag: :section, row_tag: :ul, header_cell_tag: :li, body_cell_tag: :li}
        @expect_str=""
      end

      it { Jpcalender.calender(Date.new(2013, 1, 20), @options).should eql @expect_str }
    end


    context "対象月：2008年9月 (nbsp詰め)" do
      before do
        @options = {padding: "&nbsp;",wrap_tag: :section, row_tag: :ul, header_cell_tag: :li, body_cell_tag: :li}
        @expect_str=""
      end

      it { Jpcalender.calender(Date.new(2013, 1, 20), @options).should eql @expect_str }
    end
  end
  #}}}
end
