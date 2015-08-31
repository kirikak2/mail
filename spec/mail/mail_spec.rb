# encoding: utf-8 
require 'spec_helper'

describe "mail" do
  
  it "should be able to be instantiated" do
    expect { Mail }.not_to raise_error
  end
  
  it "should be able to make a new email" do
    expect(Mail.new.class).to eq Mail::Message
  end
  
  it "should accept headers and body" do
    # Full tests in Message Spec
    message = Mail.new do
      from    'mikel@me.com'
      to      'mikel@you.com'
      subject 'Hello there Mikel'
      body    'This is a body of text'
    end
    expect(message.from).to      eq ['mikel@me.com']
    expect(message.to).to        eq ['mikel@you.com']
    expect(message.subject).to   eq 'Hello there Mikel'
    expect(message.body.to_s).to eq 'This is a body of text'
  end

  it "should read a file" do
    wrap_method = Mail.read(fixture('emails', 'plain_emails', 'raw_email.eml')).to_s
    file_method = Mail.new(File.open(fixture('emails', 'plain_emails', 'raw_email.eml'), 'rb', &:read)).to_s
    expect(wrap_method).to eq file_method
  end

  context "when multicharset mail" do
    before do
      @mail = Mail.new(File.read(fixture('emails', 'multi_charset', 'japanese_iso_2022.eml')).to_s, :no_header_formatted => true)
    end

    it{ expect(@mail.to_s).to be_include("charset=iso-2022-jp") }

    context "when rewrite body" do
      before do
        @mail.rewrite_body("書き換えテスト")
      end

      it{ expect(@mail.to_s).to be_include("charset=iso-2022-jp") }
    end
  end
end
