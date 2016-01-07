# coding: utf-8
require 'json'
require 'date'

module Jpcalendar
  #
  # データ作成クラス
  #
  module Generator

    # generator_feed{{{
    ###
    # 引数で指定した月のカレンダーをハッシュで取得
    # 戻り値:hash(:day => 日付,:class => "タグに付加される属性クラス")
    # Jpcalendar.generator_feed(Date.today)
    def feed(_date,options ={})

      start_with_monday = options[:start_with_monday] || false
      date_event   = options.delete(:date_event)   || ""

      date_event = if !date_event.empty? && date_event.is_a?(String)
                     JSON.parse(date_event)
                   elsif date_event.is_a?(Hash)
                     date_event
                   else
                     {}
                   end


      calendar_weekday = WeekdayScale::WeekDay.new(start_with_monday)

      date_feed =[]
      week_arr = []

      date = _date.to_date

      # 開始を取得
      start_date = date.beginning_of_month
      # 終了を取得
      end_date = date.end_of_month

      # headerの作成
      date_feed << make_header(calendar_weekday)

      is_firstdate = true
      (start_date.to_date..end_date.to_date).each_with_index do |d, idx|

        turn_proc = Proc.new do
                      if d.wday == calendar_weekday.last.number
                        date_feed << week_arr
                        week_arr = []
                      end
                    end

        if is_firstdate
          calendar_weekday.each do |weekday|
            # 日付と曜日が一致したら、そこに日付を置く
            if calendar_weekday.find_by_number(d.wday).number == weekday.number
              #TODO こことなんとかしたい
              # class 作成部分
              holiday = (calendar_weekday.find_by_number(d.wday).enname == "sun" || ::HolidayJp.holiday?(d)) ? "holiday" : ""
              class_hash = { class: "row_#{date_feed.size} col_#{week_arr.size} #{calendar_weekday.find_by_number(d.wday).enname} #{holiday} day_#{d.day}"}

              # id 作成部分
              id_hash = make_id(d)

              # イベント名称
              event_name = date_event.fetch(d.day.to_s, nil)

              # 押し込む
              week_arr << CalenderDate.new(
                                            d,
                                            date_format(d.day, options),
                                            event_name,
                                            ::HolidayJp.holiday?(d).try(:name),
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
          holiday = (calendar_weekday.find_by_number(d.wday).enname == "sun" || ::HolidayJp.holiday?(d)) ? "holiday" : ""
          class_hash = { class: "row_#{date_feed.size} col_#{week_arr.size} #{calendar_weekday.find_by_number(d.wday).enname} #{holiday} day_#{d.day}"}

          # id 作成部分
          id_hash = make_id(d)

          # イベント名称
          event_name = date_event.fetch(d.day.to_s, nil)

          # 押し込む
          week_arr << CalenderDate.new(
                                        d,
                                        date_format(d.day, options),
                                        event_name,
                                        ::HolidayJp.holiday?(d).try(:name),
                                        id_hash.merge(class_hash)
                                      )
          # 折り返し
          turn_proc.call
        end
      end

      date_feed << week_arr if week_arr.present?


      if options[:fill_other_days]
        # 第1週の日付のないところに前月の日付をいれていく
        blank_date =  date_feed[1].take_while{|first_week_day| first_week_day.date == "" }
        blank_date.size.times do |idx|
          prev_month_day = start_date - (blank_date.size - idx + 1)
          date_feed[1][idx].date = prev_month_day
          date_feed[1][idx].text = date_format(prev_month_day.day, options)
          date_feed[1][idx].attributes = {:class => "other-month-day prev-month-day"}
          date_feed[1][idx].jp_holiday = ::HolidayJp.holiday?(prev_month_day).try(:name)
        end

        # 最終週の日付のないところに前月の日付をいれていく
        index = 0
        7.times do |idx|
          if date_feed.last[idx].nil?
            next_month_day = start_date.next_month + index
            index += 1
            date_feed.last << CalenderDate.new(
                                                next_month_day,
                                                date_format(next_month_day.day, options),
                                                "",
                                                ::HolidayJp.holiday?(next_month_day).try(:name),
                                                {:class => "other-month-day prev-month-day"}
                                              )
          end
        end
      end

      date_feed
    end
    alias_method :generator_feed, :feed
    #}}}generator_feed

    private #{{{
      # make_hearder{{{
      # header行のデータ作成
      def make_header(calendar_weekday)
        calendar_weekday.map.with_index(0) do |cal,idx|
          class_text = ["header header_#{idx}", cal.enname].join("\s")
          CalenderDate.new("", cal.jpname, nil, nil, { class: class_text })
        end
      end
      #}}}

      def make_id(day) #{{{
        #id_hash = (_date.day == d.day)? {:id => "today"} : {}
        (Date.today == day)? {:id => "today"} : {}
      end #}}}

      class CalenderDate #{{{
        attr_accessor :date, :text, :event, :attributes, :jp_holiday
        class AttributeTypeError < StandardError
          def initialize(msg = "CalenderDate attributes is only accept hash")
            super(msg)
          end
        end

        def initialize(_date = "", _text = "", _event = nil, _jp_holiday = nil, _attributes = {})
          raise AttributeTypeError if _attributes.present? && !_attributes.is_a?(Hash)
          self.date       = _date
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
