# coding: utf-8

module Jpcalendar

  extend Generator

  #
  # 出力用整形クラス
  #
  module Format

    ##
    # テーブル版
    # options: padding 一桁の日付を何で埋めるか。デフォルトは0 => 01とか
    #          start_with_monday 月曜ではじめるかどうか。　デフォルトはfalse
    #          @holiday_off       trueの場合は休日を出力しない
    #          date_event        日付に対応するイベント情報(hash、またはjsonでparseできる文字列)
    #
    def calendar_table(_date = Date.today,options = {})
      options.merge!(wrap_tag: :table, row_tag: :tr, header_cell_tag: :th, body_cell_tag: :td)
      calendar(_date, options)
    end

    ##
    # div版
    # options: padding 一桁の日付を何で埋めるか。デフォルトは0 => 01とか
    #          start_with_monday 月曜ではじめるかどうか。　デフォルトはfalse
    #          @holiday_off       trueの場合は休日を出力しない
    #          date_event        日付に対応するイベント情報(hash、またはjsonでparseできる文字列)
    #
    def calendar_div(_date = Date.today,options = {})
      options.merge!(wrap_tag: :html, row_tag: :div, header_cell_tag: :span, body_cell_tag: :span)
      calendar(_date, options)
    end

    ##
    # カレンダー出力
    # options: padding 一桁の日付を何で埋めるか。デフォルトは0 => 01とか
    #          start_with_monday 月曜ではじめるかどうか。　デフォルトはfalse
    #          @holiday_off       trueの場合は休日を出力しない
    #          date_event        日付に対応するイベント情報(hash、またはjsonでparseできる文字列)
    #
    def calendar(_date = Date.today,options = {})
      print(_date, options)
    end

    private

      def print(_date, options) #{{{
        set_options(options)
        feeds = generator_feed(_date,  options)

        table = ""
        table << to_header(feeds)
        table << to_body(feeds)

        Util.tag_wrap(@wrap_tag){table}
      end #}}}

      def set_options(options) #{{{
        @holiday_off     = options.delete(:holiday_off)     || false
        @wrap_tag        = options.delete(:wrap_tag)        || :table
        @row_tag         = options.delete(:row_tag)         || :tr
        @header_cell_tag = options.delete(:header_cell_tag) || :th
        @body_cell_tag   = options.delete(:body_cell_tag)   || :td
      end #}}}

      def to_header(feeds) #{{{
        weekdays = feeds.shift

        Util.tag_wrap(@row_tag, class: "header") do
          table_header = ""
          weekdays.each do | weekday |
            table_header << Util.tag_wrap(@header_cell_tag, {class: weekday.attributes[:class] } ){weekday.text}
          end
          table_header
        end
      end #}}}

      def to_body(feeds) #{{{
        table = ""
        feeds.each_with_index do |days, idx|
          table << Util.tag_wrap(@row_tag,  class: "row_#{idx}" ) do
            table_data = ""

            days.each do |day|
              if @holiday_off
                table_data << Util.tag_wrap(@body_cell_tag, id: day.attributes[:id],  class: day.attributes[:class]){ [output_day(day.text) , day.event].compact.join }
              else
                table_data << Util.tag_wrap(@body_cell_tag, id: day.attributes[:id],  class: day.attributes[:class]){ [output_day(day.text),  Util.expr_not_nil(day.jp_holiday){ Util.tag_wrap(:span, class: "holiday_name"){day.jp_holiday} },  day.event].compact.join }
              end
            end
            table_data
          end
        end
        table
      end #}}}

      def output_day(day) #{{{
        Util.tag_wrap(:span, class: "day" ){ day }
      end #}}}
    # end private

  end
end
