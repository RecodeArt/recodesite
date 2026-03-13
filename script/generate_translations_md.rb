# frozen_string_literal: true

require "cgi"
require "fileutils"

ROOT = File.expand_path("..", __dir__)
SOURCE_DIRS = [
  File.join(ROOT, "old", "translation"),
  File.join(ROOT, "old", "translations")
].uniq
OUT_DIR = File.join(ROOT, "_translations", "pde")


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
  escaped = value.to_s.gsub("\\", "\\\\").gsub('"', '\\"')
  "\"#{escaped}\""
end


def normalize_href(href)
  decoded = CGI.unescapeHTML(href.to_s.strip)
  return "" if decoded.empty?

  match = decoded.match(%r{\Ahttps?://web\.archive\.org/web/\d+/(https?://.+)\z}i)
  match ? match[1] : decoded
end


def parse_runs_in_browser(text)
  normalized = text.to_s.downcase

  return false if normalized.match?(/this\s+(?:sketch|code|script)[^.]*does\s+not\s+run[^.]*browser/)
  return false if normalized.match?(/this\s+(?:sketch|code|script)[^.]*not\s+run[^.]*browser/)
  return false if normalized.match?(/this\s+(?:sketch|code|script)[^.]*cannot\s+run[^.]*browser/)
  return true if normalized.match?(/this\s+(?:sketch|code|script)[^.]*is\s+running[^.]*browser/)
  return true if normalized.match?(/this\s+(?:sketch|code|script)[^.]*runs?[^.]*browser/)

  nil
end


def normalize_description(text)
  description = text.to_s.gsub(/\s+/, " ").strip
  description = description.gsub(/this\s+(?:sketch|code|script)[^.]*browser\.?/i, "").strip
  description = description.sub(/\Ano description provided\b[:\-\s]*/i, "").strip
  description
end


def extract_artwork_href(info_block)
  href = extract_first(info_block, /<strong>\s*Based on:\s*<\/strong>\s*<a[^>]*href="([^"]+)"/im)
  return href unless href.empty?

  extract_first(info_block, /href="([^"]*artworks?\/[^"]*)"/im)
end


def parse_artwork_slug(href)
  decoded = CGI.unescapeHTML(href.to_s)
  return "" if decoded.empty?

  match = decoded.match(%r{artworks?/([^"?#]+)}i)
  match ||= decoded.match(%r{artwork/([^"?#]+)}i)
  return "" unless match

  segment = match[1].to_s
  slug = segment.split("/").last.to_s
  slug.gsub!(/\.html?$/i, "")
  slug.gsub!(/^(v[0-9]+n[0-9]+)/i, "\\1-")
  slug
end


def parse_translation(html_path)
  content = File.read(html_path)
  basename = File.basename(html_path, ".html")

  info_block = extract_first(content, /<div id="basic-info"[^>]*>(.*?)<\/div>\s*<\/div>/im)
  info_block = content if info_block.empty?

  title = sanitize_text(extract_first(info_block, /<h2[^>]*>(.*?)<\/h2>/im))
  translator = sanitize_text(extract_first(info_block, /<h3[^>]*>(.*?)<\/h3>/im))
  translator_url = normalize_href(extract_first(info_block, /<h3[^>]*>\s*<a[^>]*href="([^"]*)"/im))
  translator_url = "" if translator_url.to_s.match(/recodeproject\.com|\/none/im)


  category_raw = sanitize_text(extract_first(info_block, /<strong>\s*Category:\s*<\/strong>\s*(.*?)\s*<\/p>/im))
  category = category_raw.downcase

  description_block = extract_first(info_block, /<p>\s*<strong>\s*Description:\s*<\/strong>\s*<\/p>\s*(.*?)\s*<hr/im)
  description_raw = sanitize_text(description_block)
  runs_in_browser = parse_runs_in_browser(description_raw)
  description = normalize_description(description_raw)

  artwork_href = normalize_href(extract_artwork_href(info_block))
  artwork_slug = parse_artwork_slug(artwork_href)

  code_html = extract_first(content, /<div id="orig-code"[^>]*>.*?<pre[^>]*>(.*?)<\/pre>/im)
  code = CGI.unescapeHTML(code_html).gsub(/\r\n?/, "\n")
  code = code.gsub(/\A\n+/, "").rstrip

  {
    title: title,
    translator: translator,
    translator_url: translator_url,
    slug: basename,
    artwork_slug: artwork_slug,
    category: category,
    description: description,
    runs_in_browser: runs_in_browser,
    code: code
  }
end


def build_markdown(data)
  runs_value = data[:runs_in_browser].nil? ? "" : data[:runs_in_browser].to_s

  <<~MD
    ---
    title: #{yaml_quote(data[:title])}
    translator: #{yaml_quote(data[:translator])}
    translator_url: #{yaml_quote(data[:translator_url])}
    slug: #{yaml_quote(data[:slug])}
    artwork_slug: #{yaml_quote(data[:artwork_slug])}
    category: #{yaml_quote(data[:category])}
    description: #{yaml_quote(data[:description])}
    runs_in_browser: #{runs_value}
    ---
    #{data[:code]}
  MD
end


FileUtils.mkdir_p(OUT_DIR) unless Dir.exist?(OUT_DIR)

html_files = SOURCE_DIRS
  .select { |dir| Dir.exist?(dir) }
  .flat_map { |dir| Dir.glob(File.join(dir, "*.html")) }
  .uniq
  .sort

if html_files.empty?
  warn "No translation HTML files found in: #{SOURCE_DIRS.join(', ')}"
  exit 1
end

generated = 0

html_files.each do |html_path|
  data = parse_translation(html_path)
  output_path = File.join(OUT_DIR, "#{File.basename(html_path, '.html')}.md")
  File.write(output_path, build_markdown(data))
  generated += 1
end

puts "Generated #{generated} markdown files from #{html_files.size} translation HTML files."
