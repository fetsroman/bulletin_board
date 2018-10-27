module ApplicationHelper
	def markdown(content)
		renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
		options = {
			autolink: true,
			superscript: true,
			strikethrough: true
		}
		Redcarpet::Markdown.new(renderer, options).render(content).html_safe
	end
end
