# coding: utf-8
require 'spec_helper'

describe Jpcalendar::Generator do

  before :each do
    extend Jpcalendar::Generator
  end

  context "generator_feed" do
    context "引数なし" do
      it { lambda{ generator_feed }.should raise_error ArgumentError }
    end
  end

  # あとはformatクラスでテストしてるから、いいんじゃないかと
end
