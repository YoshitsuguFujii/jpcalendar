# coding: utf-8

#
# カレンダークラス
#
module Jpcalendar
  require 'active_support/core_ext/date/calculations'
  require 'active_support/core_ext/time/calculations'

  require 'jpcalendar/generator'
  require 'jpcalendar/format'
  require 'jpcalendar/util'

  require 'jpcalendar/weekday_scale'

  require 'holiday_jp'

  extend Format
end
