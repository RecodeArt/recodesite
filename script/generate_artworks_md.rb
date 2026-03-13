# frozen_string_literal: true

require "cgi"

ROOT = File.expand_path("..", __dir__)
HTML_DIR = File.join(ROOT, "html")
OUT_DIR = File.join(ROOT, "_artworks")


def extract_first(content, regex)
  match = content.match(regex)
  return "" unless match

  match[1].to_s.strip
end


def sanitize_text(value)
  CGI.unescapeHTML(value.to_s)
    .gsub(/<[^>]+>/, " ")
    .gsub(/\s+/, " ")
    .strip
end


def yaml_quote(value)
  return "" if value.nil? || value.empty?

  escaped = value.gsub("\\", "\\\\").gsub('"', '\\"')
  "\"#{escaped}\""
end


def parse_description(content)
  block = extract_first(content, /description:\s*<\/br>\s*(.*?)\s*<\/br>\s*<\/br>/im)
  description = sanitize_text(block)
  return "" if description.casecmp("none").zero?

  description
end


def parse_position(photo_link)
  match = photo_link.match(%r{^cards/(v(\d+)n(\d+))/(\d+)\.(?:png|jpg|jpeg|gif)$}i)
  return 0 unless match

  volume = match[2].to_i
  issue = match[3].to_i
  image_index = match[4].to_i
  (volume * 1000) + (issue * 100) + image_index
end


def parse_slug(html_basename, source_id, photo_link)
  photo_match = photo_link.match(%r{^cards/(v\d+n\d+)/}i)
  prefix = photo_match ? photo_match[1] : source_id.to_s.strip

  return html_basename if prefix.empty?
  return "#{prefix}_#{html_basename[prefix.length..]}" if html_basename.downcase.start_with?(prefix.downcase)

  html_basename
end


html_files = Dir.glob(File.join(HTML_DIR, "*.html")).sort
generated = 0

html_files.each do |html_path|
  content = File.read(html_path)
  basename = File.basename(html_path, ".html")

  title = sanitize_text(extract_first(content, /<h2>(.*?)<\/h2>/im))
  artist = sanitize_text(extract_first(content, /<h3>(.*?)<\/h3>/im))
  source = sanitize_text(extract_first(content, /source:\s*(.*?)\s*<\/br>/im))

  source_match = content.match(/source document:\s*<a\s+href="([^"]+)"[^>]*>(.*?)<\/a>/im)
  source_id = source_match ? sanitize_text(source_match[2]) : ""

  photo_link = extract_first(content, /<img\s+src="\.\.\/static\/img\/(cards\/[^"]+)"/i)

  period_raw = extract_first(content, /date:\s*([^<\n\r]+)/i)
  period = period_raw.gsub(/\s+/, " ").strip

  description = parse_description(content)
  slug = parse_slug(basename, source_id, photo_link)
  position = parse_position(photo_link)

  md_content = <<~MD
    ---
    title: #{yaml_quote(title)}
    artist: #{yaml_quote(artist)}
    source: #{yaml_quote(source)}
    source_id: #{yaml_quote(source_id)}
    photo_link: #{yaml_quote(photo_link)}
    code_link:
    slug: #{yaml_quote(slug)}
    period: #{yaml_quote(period)}
    description: #{yaml_quote(description)}
    position: #{position}
    ---
  MD

  output_path = File.join(OUT_DIR, "#{basename}.md")
  File.write(output_path, md_content)
  generated += 1
end

puts "Generated #{generated} markdown files from #{html_files.size} HTML files."
