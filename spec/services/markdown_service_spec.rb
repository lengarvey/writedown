require 'spec_helper'

describe MarkdownService do

  it { should be_a MarkdownService }

  describe '#render_to_html' do
    let(:markdown) { '# this is a h1' }
    let(:markdown_engine) { double('Redcarpet') }

    before :each do
      Redcarpet::Markdown.stub(:new) { markdown_engine }
    end

    it 'should render markdown' do
      expect(markdown_engine).to receive(:render).with(markdown)
      MarkdownService.new.render_to_html(markdown)
    end
  end
end
