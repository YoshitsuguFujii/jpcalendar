# coding: utf-8

module Jpcalendar
  #
  # 曜日判定用クラス
  #
  module WeekdayScale

    # WeekDayElem{{{
    class WeekDayElem
      attr_accessor :number, :jpname, :enname
      def initialize(_number, _jpname, _enname)
        self.number = _number
        self.jpname = _jpname
        self.enname = _enname
      end
    end
    #}}}WeekDayElem

    # WeekDay {{{
    class WeekDay

      WEEK_DAY = [
        WeekDayElem.new(0,"日","sun"),
        WeekDayElem.new(1,"月","mon"),
        WeekDayElem.new(2,"火","tue"),
        WeekDayElem.new(3,"水","wed"),
        WeekDayElem.new(4,"木","thu"),
        WeekDayElem.new(5,"金","fri"),
        WeekDayElem.new(6,"土","sat")
      ]

      def initialize(start_with_monday = false)
        @wdays = WEEK_DAY.dup
        change_start_monday!(start_with_monday)
      end

      ##
      # params: method_name メソッド名
      #         *args 第1引数 week_day_メソッドで呼ばれた場合は options
      #                       find_by_メソッドで呼ばれた場合は 検索対象の値
      # call example  week_day_jpname(WEEK_DAY)
      def method_missing(method_name,*args)
        if method_name =~ /^find_by_(.*)/
          unless respond_to?(method_name.to_sym)
            self.instance_eval %Q{
              def #{method_name}(id)
                if id.present?
                  @wdays.select{|wd| wd.#{$1} == id }.first
                end
              end
            }
          end

          return send(method_name, args[0] )
        end

        super
      end

      # もっとスマートにdeligateしたいなぁ
      def map
        if block_given?
          @wdays.map{|wday| yield wday}
        else
          @wdays.map
        end
      end

      def each
        if block_given?
          @wdays.each{|wday| yield wday}
        else
          @wdays.each
        end
      end

      def last
        @wdays.last
      end

      private

        # 月曜始まりに変更
        def change_start_monday!(start_with_monday = false)
          if start_with_monday
            sunday = @wdays.shift
            @wdays.push(sunday)
          end
        end
      # end private
    end
    #}}}

  end
end
