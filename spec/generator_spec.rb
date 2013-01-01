# coding: utf-8
require 'spec_helper'

describe Jpcalender::Generator do

  before :each do
    extend Jpcalender::Generator
  end

  context "generator_feed" do
    context "引数なし" do
      it { lambda{ generator_feed }.should raise_error ArgumentError }
    end
  end

  # あとはformatクラスでテストしてるから、いいんじゃないかと
end
