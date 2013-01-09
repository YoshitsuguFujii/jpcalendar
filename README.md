Jpcalendar
======================
日本の祝日に対応したカレンダーを出力します。

install
------  
`gem install jpcalendar`

もしくはGemfileに記載  
`gem 'jpcalendar'`

usage
------

###Class methods  
`calendar_table(date = Date.today, options ={})`  
table形式のカレンダーを生成します。

`calendar_div(date = Date.today, options ={})`  
div形式でカレンダーを生成します。

`calendar(date = Date.today, options ={})`  
任意の形式でカレンダーを生成します。

###example
出力例 その１  
カレンダー出力(table形式)  
```ruby
Jpcalendar.calendar_table(Date.new(2013,1,1))
```
```html
    <table>
      <tr class='header'>    <th class='header header_0 sun'>日</th>
        <th class='header header_1 mon'>月</th>
        <th class='header header_2 tue'>火</th>
        <th class='header header_3 wed'>水</th>
        <th class='header header_4 thu'>木</th>
        <th class='header header_5 fri'>金</th>
        <th class='header header_6 sat'>土</th>
      </tr>
      <tr class='row_0'>
        <td>
          <span class='day'></span>
        </td>
        <td>
          <span class='day'></span>
        </td>
        <td class='row_1 col_2 tue holiday day_1'>
          <span class='day'>01</span>
          <span class='holiday_name'>元日</span>
        </td>
        <td class='row_1 col_3 wed  day_2'>
          <span class='day'>02</span>
        </td>
        <td class='row_1 col_4 thu  day_3'>
          <span class='day'>03</span>
        </td>
        <td class='row_1 col_5 fri  day_4'>
          <span class='day'>04</span>
        </td>
        <td class='row_1 col_6 sat  day_5'>
          <span class='day'>05</span>
        </td>
      </tr>
      <tr class='row_1'>
        <td class='row_2 col_0 sun holiday day_6'>
          <span class='day'>06</span>
        </td>
        <td class='row_2 col_1 mon  day_7'>
          <span class='day'>07</span>
        </td>
        <td class='row_2 col_2 tue  day_8'>
          <span class='day'>08</span>
        </td>
        <td id='today' class='row_2 col_3 wed  day_9'>
          <span class='day'>09</span>
        </td>
        <td class='row_2 col_4 thu  day_10'>
          <span class='day'>10</span>
        </td>
        <td class='row_2 col_5 fri  day_11'>
          <span class='day'>11</span>
        </td>
        <td class='row_2 col_6 sat  day_12'>
          <span class='day'>12</span>
        </td>
      </tr>
      <tr class='row_2'>
        <td class='row_3 col_0 sun holiday day_13'>
          <span class='day'>13</span>
        </td>
        <td class='row_3 col_1 mon holiday day_14'>
          <span class='day'>14</span>
          <span class='holiday_name'>成人の日</span>
        </td>
        <td class='row_3 col_2 tue  day_15'>
          <span class='day'>15</span>
        </td>
        <td class='row_3 col_3 wed  day_16'>
          <span class='day'>16</span>
        </td>
        <td class='row_3 col_4 thu  day_17'>
          <span class='day'>17</span>
        </td>
        <td class='row_3 col_5 fri  day_18'>
          <span class='day'>18</span>
        </td>
        <td class='row_3 col_6 sat  day_19'>
          <span class='day'>19</span>
        </td>
      </tr>
      <tr class='row_3'>
        <td class='row_4 col_0 sun holiday day_20'>
          <span class='day'>20</span>
        </td>
        <td class='row_4 col_1 mon  day_21'>
          <span class='day'>21</span>
        </td>
        <td class='row_4 col_2 tue  day_22'>
          <span class='day'>22</span>
        </td>
        <td class='row_4 col_3 wed  day_23'>
          <span class='day'>23</span>
        </td>
        <td class='row_4 col_4 thu  day_24'>
          <span class='day'>24</span>
        </td>
        <td class='row_4 col_5 fri  day_25'>
          <span class='day'>25</span>
        </td>
        <td class='row_4 col_6 sat  day_26'>
          <span class='day'>26</span>
        </td>
      </tr>
      <tr class='row_4'>
        <td class='row_5 col_0 sun holiday day_27'>
          <span class='day'>27</span>
        </td>
        <td class='row_5 col_1 mon  day_28'>
          <span class='day'>28</span>
        </td>
        <td class='row_5 col_2 tue  day_29'>
          <span class='day'>29</span>
        </td>
        <td class='row_5 col_3 wed  day_30'>
          <span class='day'>30</span>
        </td>
        <td class='row_5 col_4 thu  day_31'>
          <span class='day'>31</span>
        </td>
      </tr>
    </table>
```

出力例 その２  
カレンダー出力(div形式/optionをたくさん指定)  
```ruby
date_event = JSON.generate({"1" => "定例会", "9" => "ディズニーランド", "14" => "サーフィン", "23" => "小梅と遊ぶ", "24" => "クリスマスパーティー"})
Jpcalendar.calendar_div(Date.new(2012, 12, 1),holiday_off: true, padding: " ", start_with_monday: true, date_event: @date_event )
```
```html
    <html>
      <div class='header'>
        <span class='header header_0 mon'>月</span>
        <span class='header header_1 tue'>火</span>
        <span class='header header_2 wed'>水</span>
        <span class='header header_3 thu'>木</span>
        <span class='header header_4 fri'>金</span>
        <span class='header header_5 sat'>土</span>
        <span class='header header_6 sun'>日</span>
      </div>
      <div class='row_0'>
        <span>
          <span class='day'></span>
        </span>
        <span>
          <span class='day'></span>
        </span>
        <span>
          <span class='day'></span>
        </span>
        <span>
          <span class='day'></span>
        </span>
        <span>
          <span class='day'></span>
        </span>
        <span class='row_1 col_5 sat day_1'>
          <span class='day'>&nbsp;1</span>定例会
        </span>
        <span class='row_1 col_6 sun holiday day_2'>
          <span class='day'>&nbsp;2</span>
        </span>
      </div>
      <div class='row_1'>
        <span class='row_2 col_0 mon day_3'>
          <span class='day'>&nbsp;3</span>
        </span>
        <span class='row_2 col_1 tue day_4'>
          <span class='day'>&nbsp;4</span>
        </span>
        <span class='row_2 col_2 wed day_5'>
          <span class='day'>&nbsp;5</span>
        </span>
        <span class='row_2 col_3 thu day_6'>
          <span class='day'>&nbsp;6</span>
        </span>
        <span class='row_2 col_4 fri day_7'>
          <span class='day'>&nbsp;7</span>
        </span>
        <span class='row_2 col_5 sat day_8'>
          <span class='day'>&nbsp;8</span>
        </span>
        <span class='row_2 col_6 sun holiday day_9'>
          <span class='day'>&nbsp;9</span>ディズニーランド
        </span>
      </div>
      <div class='row_2'>
        <span class='row_3 col_0 mon day_10'>
          <span class='day'>10</span>
        </span>
        <span class='row_3 col_1 tue day_11'>
          <span class='day'>11</span>
        </span>
        <span class='row_3 col_2 wed day_12'>
          <span class='day'>12</span>
        </span>
        <span class='row_3 col_3 thu day_13'>
          <span class='day'>13</span>
        </span>
        <span class='row_3 col_4 fri day_14'>
          <span class='day'>14</span>サーフィン
        </span>
        <span class='row_3 col_5 sat day_15'>
          <span class='day'>15</span>
        </span>
        <span class='row_3 col_6 sun holiday day_16'>
          <span class='day'>16</span>
        </span>
      </div>
      <div class='row_3'>
        <span class='row_4 col_0 mon day_17'>
          <span class='day'>17</span>
        </span>
        <span class='row_4 col_1 tue day_18'>
          <span class='day'>18</span>
        </span>
        <span class='row_4 col_2 wed day_19'>
          <span class='day'>19</span>
        </span>
        <span class='row_4 col_3 thu day_20'>
          <span class='day'>20</span>
        </span>
        <span class='row_4 col_4 fri day_21'>
          <span class='day'>21</span>
        </span>
        <span class='row_4 col_5 sat day_22'>
          <span class='day'>22</span>
        </span>
        <span class='row_4 col_6 sun holiday day_23'>
          <span class='day'>23</span>小梅と遊ぶ
        </span>
      </div>
      <div class='row_4'>
        <span class='row_5 col_0 mon holiday day_24'>
          <span class='day'>24</span>クリスマスパーティー
        </span>
        <span class='row_5 col_1 tue day_25'>
          <span class='day'>25</span>
        </span>
        <span class='row_5 col_2 wed day_26'>
          <span class='day'>26</span>
        </span>
        <span class='row_5 col_3 thu day_27'>
          <span class='day'>27</span>
        </span>
        <span class='row_5 col_4 fri day_28'>
          <span class='day'>28</span>
        </span>
        <span class='row_5 col_5 sat day_29'>
          <span class='day'>29</span>
        </span>
        <span class='row_5 col_6 sun holiday day_30'>
          <span class='day'>30</span>
        </span>
      </div>
      <div class='row_5'>
        <span class='row_6 col_0 mon day_31'>
          <span class='day'>31</span>
        </span>
      </div>
    </html>
```

Options
------
* 月曜はじまり  
`start_with_monday: ( true または false )`

* 休日を含まない  
`holiday_off: (true または false)`

* 一桁の日付を何でパディングするか  
`padding: 任意の文字列`

* カスタムイベント  
`date_event: json形式の文字列 または hash`

* 任意のタグ  

  * 全体を覆うタグ  
  `wrap_tag: タグのシンボル (例) :section`

  * 行を覆うタグ  
  `row_tag: タグのシンボル (例) :ul`

  * ヘッダ(月~日)までの各セルを覆うタグ  
  `header_cell_tag: タグのシンボル (例) :li`

  * 日付の各セルを覆うタグ  
  `body_cell_tag: タグのシンボル (例) :li`
