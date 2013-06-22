require 'spec_helper'

describe Article do
  describe '#markdown=' do
    let(:article) { Article.new }
    let(:markdown) { '# this is a h1' }
    let(:markdown_service) { double('MarkdownService') }

    before :each do
      MarkdownService.stub(:new) { markdown_service }
    end

    it 'should convert the markdown to html' do
      expect(markdown_service).to receive(:render_to_html).with(markdown)
      article.markdown = markdown
    end
  end
end
