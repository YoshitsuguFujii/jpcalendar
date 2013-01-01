# coding: utf-8

#
# カレンダークラス
#
module Jpcalender
  require 'active_support/core_ext/date/calculations'
  require 'active_support/core_ext/time/calculations'

  require 'jpcalender/generator'
  require 'jpcalender/format'
  require 'jpcalender/util'

  require 'jpcalender/weekday_scale'

  require 'holiday_jp'

  extend Format
end
