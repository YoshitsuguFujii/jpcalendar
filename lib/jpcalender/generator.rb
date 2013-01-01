# coding: utf-8
require 'json'

module Jpcalender
  #
  # データ作成クラス
  #
  module Generator

    # generator_feed{{{
    ###
    # 引数で指定した月のカレンダーをハッシュで取得
    # 戻り値:hash(:day => 日付,:class => "タグに付加される属性クラス")
    # Jpcalender.generator_feed(Date.today)
    def generator_feed(_date,options ={})

      start_with_monday = options[:start_with_monday] || false
      date_event   = options.delete(:date_event)   || ""

      date_event = if !date_event.empty? && date_event.is_a?(String)
                     JSON.parse(date_event)
                   else
                     {}
                   end


      calender_weekday = WeekdayScale::WeekDay.new(start_with_monday)

      date_feed =[]
      week_arr = []

      date = _date.to_date

      # 開始を取得
      start_date = date.beginning_of_month
      # 終了を取得
      end_date = date.end_of_month

      # headerの作成
      date_feed << make_header(calender_weekday)

      is_firstdate = true
      (start_date.to_date..end_date.to_date).each_with_index do |d, idx|

        turn_proc = Proc.new do
                      if d.wday == calender_weekday.last.number
                        date_feed << week_arr
                        week_arr = []
                      end
                    end

        if is_firstdate
          calender_weekday.each do |weekday|
            # 日付と曜日が一致したら、そこに日付を置く
            if calender_weekday.find_by_number(d.wday).number == weekday.number
              #TODO こことなんとかしたい
              # class 作成部分
              holiday = (calender_weekday.find_by_number(d.wday).enname == "sun" || ::HolidayJp::HOLIDAYS[d].try(:name))? "holiday" : ""
              class_hash = { class: "row_#{date_feed.size} col_#{week_arr.size} #{calender_weekday.find_by_number(d.wday).enname} #{holiday} day_#{d.day}"}

              # id 作成部分
              id_hash = make_id(d)

              # イベント名称
              event_name = date_event.fetch(d.day.to_s, nil)

              # 押し込む
              week_arr << CalenderDate.new(
                                            date_format(d.day, options),
                                            event_name,
                                            ::HolidayJp::HOLIDAYS[d].try(:name),
                                            id_hash.merge(class_hash)
                                          )

              # 折り返し
              turn_proc.call

              is_firstdate = false
              break
            # なかったら
            else
              week_arr << CalenderDate.new
            end

          end
        # 初日が決まったらあとは日付を置いていく。土曜日で折り返す
        else
          #TODO ここをなんとかしたい
          # class 作成部分
          holiday = (calender_weekday.find_by_number(d.wday).enname == "sun" || ::HolidayJp::HOLIDAYS[d].try(:name))? "holiday" : ""
          class_hash = { class: "row_#{date_feed.size} col_#{week_arr.size} #{calender_weekday.find_by_number(d.wday).enname} #{holiday} day_#{d.day}"}

          # id 作成部分
          id_hash = make_id(d)

          # イベント名称
          event_name = date_event.fetch(d.day.to_s, nil)

          # 押し込む
          week_arr << CalenderDate.new(
                                        date_format(d.day, options),
                                        event_name,
                                        ::HolidayJp::HOLIDAYS[d].try(:name),
                                        id_hash.merge(class_hash)
                                      )
          # 折り返し
          turn_proc.call
        end
      end

      date_feed << week_arr if week_arr.present?
      date_feed

    end
    #}}}generator_feed

    private #{{{
      # make_hearder{{{
      # header行のデータ作成
      def make_header(calender_weekday)
        calender_weekday.map.with_index(0) do |cal,idx|
          class_text = ["header header_#{idx}", cal.enname].join("\s")
          CalenderDate.new(cal.jpname, nil, nil, { class: class_text })
        end
      end
      #}}}

      def make_id(day) #{{{
        #id_hash = (_date.day == d.day)? {:id => "today"} : {}
        (Date.today == day)? {:id => "today"} : {}
      end #}}}

      class CalenderDate #{{{
        attr_accessor :text, :event, :attributes, :jp_holiday
        class AttributeTypeError < StandardError
          def initialize(msg = "CalenderDate attributes is only accept hash")
            super(msg)
          end
        end

        def initialize(_text = "", _event = nil, _jp_holiday = nil, _attributes = {})
          raise AttributeTypeError if _attributes.present? && !_attributes.is_a?(Hash)
          self.text       = _text
          self.event      = _event
          self.jp_holiday = _jp_holiday
          self.attributes = _attributes
        end
      end
      #}}}

      def get_patting_chr(options) #{{{
        options[:padding].gsub(/\s/,"&nbsp;") rescue "0"
      end
      # }}}

      ##  date_format {{{
      # 日付の整形
      def date_format(day, options)
        padding = get_patting_chr(options)
        if Util.is_numeric?(padding)
          sprintf("%#{padding}2d", day)
        else
          day >= 10? day.to_s : padding + day.to_s
        end
      end
      # }}}
      # end private }}}

  end
end
