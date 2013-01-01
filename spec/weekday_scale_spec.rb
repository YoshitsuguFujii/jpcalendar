# coding: utf-8
require 'spec_helper'

describe Jpcalender::WeekdayScale do

  # WeekDayElem{{{
  context "WeekDayElem" do
    before do
      @wde = Jpcalender::WeekdayScale::WeekDayElem.new(0,'日曜日','sunday')
    end

    subject{@wde}
    its(:number){ should eql 0}
    its(:jpname){ should eql '日曜日'}
    its(:enname){ should eql 'sunday'}

    context "再設定" do
      before do
        @wde.number = 1
        @wde.jpname = '月曜日'
        @wde.enname = 'monday'
      end

      its(:number){ should eql 1}
      its(:jpname){ should eql '月曜日'}
      its(:enname){ should eql 'monday'}
    end
  end
  #}}}

  context "Weekday" do #{{{

    context "日曜始まり(デフォルト)" do #{{{
      before do
        @wd = Jpcalender::WeekdayScale::WeekDay.new
      end

      context "find_by_*" do
        context "number" do
          subject{ @wd.find_by_number(2) }
          its(:number) { should eql  2}
          its(:jpname) { should eql  "火"}
          its(:enname) { should eql  "tue"}
        end

        context "jpname" do
          subject{ @wd.find_by_jpname("木") }
          its(:number) { should eql  4}
          its(:jpname) { should eql  "木"}
          its(:enname) { should eql  "thu"}
        end

        context "enname" do
          subject{ @wd.find_by_enname('sat') }
          its(:number) { should eql  6}
          its(:jpname) { should eql  "土"}
          its(:enname) { should eql  "sat"}
        end

        context "存在しない要素の呼び出し" do
          it { lambda{ @wd.find_by_hoge('hoge') }.should raise_error NoMethodError }
        end

        context "もしも検索にひっかからなかったら" do
          it { @wd.find_by_number(-1).should be_nil  }
        end
      end

      context 'map' do
        subject{@wd}

        its(:map){ should be_an_instance_of Enumerator }
        it{ @wd.map.with_index{|wd,idx| wd }.should have(7).items }
        it{ @wd.map{|wd,idx| wd }.should have(7).items }
      end

      context "each" do
        subject{@wd}

        its(:each){ should be_an_instance_of Enumerator }
        it{ @wd.each.with_index{|wd,idx| wd }.should have(7).items }
        it{ @wd.each{|wd,idx| wd }.should have(7).items }
      end

      context "last" do
        subject{@wd}
        its("last.number"){ should eql 6 }
        its("last.jpname"){ should eql "土" }
        its("last.enname"){ should eql "sat" }
      end
    end
    #}}}

    context "月曜始まり" do #{{{
      before do
        @wd = Jpcalender::WeekdayScale::WeekDay.new(true)
      end

      context "find_by_*" do
        context "number" do
          subject{ @wd.find_by_number(2) }
          its(:number) { should eql  2}
          its(:jpname) { should eql  "火"}
          its(:enname) { should eql  "tue"}
        end

        context "jpname" do
          subject{ @wd.find_by_jpname("木") }
          its(:number) { should eql  4}
          its(:jpname) { should eql  "木"}
          its(:enname) { should eql  "thu"}
        end

        context "enname" do
          subject{ @wd.find_by_enname('sat') }
          its(:number) { should eql  6}
          its(:jpname) { should eql  "土"}
          its(:enname) { should eql  "sat"}
        end

        context "存在しない要素の呼び出し" do
          it { lambda{ @wd.find_by_hoge('hoge') }.should raise_error NoMethodError }
        end

        context "もしも検索にひっかからなかったら" do
          it { @wd.find_by_number(-1).should be_nil  }
        end
      end

      context 'map' do
        subject{@wd}

        its(:map){ should be_an_instance_of Enumerator }
        it{ @wd.map.with_index{|wd,idx| wd }.should have(7).items }
        it{ @wd.map{|wd,idx| wd }.should have(7).items }
      end

      context "each" do
        subject{@wd}

        its(:each){ should be_an_instance_of Enumerator }
        it{ @wd.each.with_index{|wd,idx| wd }.should have(7).items }
        it{ @wd.each{|wd,idx| wd }.should have(7).items }
      end

      context "last" do
        subject{@wd}
        its("last.number"){ should eql 0 }
        its("last.jpname"){ should eql "日" }
        its("last.enname"){ should eql "sun" }
      end
    end
    # }}}

  end
  #}}}

end
