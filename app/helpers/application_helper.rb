module ApplicationHelper

  def embedded_svg(filename, options={})
    
    file = File.read(Rails.root.join('app', 'assets', 'images', 'svgs', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"

    svg['viewBox'] = options[:viewBox] if options[:viewBox].present?
    svg['class'] = options[:class] if options[:class].present?

    raw doc
  end

end
