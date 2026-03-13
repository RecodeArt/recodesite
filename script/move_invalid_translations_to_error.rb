# frozen_string_literal: true

require "cgi"
require "fileutils"

ROOT = File.expand_path("..", __dir__)
SOURCE_DIR = File.join(ROOT, "old", "translation")
ERROR_DIR = File.join(SOURCE_DIR, "error")
REPORT_PATH = File.join(ERROR_DIR, "invalid_files.txt")


def extract_code_from_html(content)
  match = content.match(%r{<div id="orig-code"[^>]*>.*?<pre[^>]*>(.*?)</pre>}im)
  return "" unless match

  CGI.unescapeHTML(match[1].to_s).gsub(/\r\n?/, "\n")
end


def meaningful_lines(lines)
  lines.reject do |line|
    stripped = line.strip
    stripped.empty? ||
      stripped == "*/" ||
      stripped.start_with?("//") ||
      stripped.start_with?("/*") ||
      stripped.start_with?("*")
  end
end


def invalid_translation_code?(code)
  lines = code.lines.map(&:rstrip)

  pause_idx = lines.index do |line|
    line.match?(/@pjs\s+pauseOnBlur\s*=\s*["']?true["']?\s*;/i)
  end
  return false if pause_idx.nil?

  tail_lines = lines[(pause_idx + 1)..] || []
  no_code_after_pause = meaningful_lines(tail_lines).empty?
  only_few_lines = meaningful_lines(lines).length <= 12

  no_code_after_pause && only_few_lines
end


unless Dir.exist?(SOURCE_DIR)
  warn "Source directory not found: #{SOURCE_DIR}"
  exit 1
end

html_files = Dir.glob(File.join(SOURCE_DIR, "*.html")).sort
invalid_files = html_files.select do |path|
  content = File.read(path)
  code = extract_code_from_html(content)
  invalid_translation_code?(code)
end

if invalid_files.empty?
  puts "No invalid translation files found."
  exit 0
end

FileUtils.mkdir_p(ERROR_DIR)

invalid_files.each do |path|
  target_path = File.join(ERROR_DIR, File.basename(path))
  FileUtils.mv(path, target_path)
end

File.write(REPORT_PATH, invalid_files.map { |p| File.basename(p) }.join("\n") + "\n")

puts "Moved #{invalid_files.length} invalid files to #{ERROR_DIR}."
puts "Report written to #{REPORT_PATH}."
