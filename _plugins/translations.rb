require "cgi"

module Jekyll
  # Translations live in _translations/<language>/<slug>.md, one file per
  # language. This generator:
  #  - extracts the raw script of each translation,
  #  - groups the translations of a same slug into a single page
  #    (/translations/:slug) that offers a language selector,
  #  - creates a redirection page /translations/<language>/:slug for each
  #    translation, pointing to /translations/:slug#<language>,
  #  - exposes the list of pages in site.data["translations_index"].
  class TranslationsGenerator < Generator
    safe true

    def generate(site)
      languages = site.data["languages"] || {}
      collection = site.collections["translations"]
      return unless collection

      groups = {}
      collection.docs.each do |doc|
        language = doc.data["language"] || doc.relative_path.split("/")[1]
        unless languages.key?(language)
          Jekyll.logger.warn "Translations:", "Unknown language '#{language}' for #{doc.relative_path}"
          next
        end

        script = doc.content.to_s.gsub(/<script[^>]*>/, "").gsub(/<\/script>/, "").strip
        if script.empty?
          Jekyll.logger.warn "Translations:", "No script found for #{doc.data["slug"]} (#{language})"
          next
        end

        slug = doc.data["slug"]
        (groups[slug] ||= {})[language] = { "doc" => doc, "script" => script }
      end

      index = []
      groups.each do |slug, by_language|
        # languages in the order of languages.yml
        ids = languages.keys.select { |id| by_language.key?(id) }
        main = by_language[ids.first]["doc"].data

        entries = ids.map do |id|
          {
            "id" => id,
            "name" => languages[id]["name"],
            "cm" => languages[id]["cm"],
            "runnable" => languages[id]["runnable"] == true,
            "script" => by_language[id]["script"]
          }
        end

        # p5_version is declared in the front matter of the runnable translation
        runner = ids.find { |id| languages[id]["runnable"] }
        p5_version = runner && by_language[runner]["doc"].data["p5_version"]

        data = {
          "layout" => "translation",
          "title" => main["title"],
          "translator" => main["translator"],
          "translator_url" => main["translator_url"],
          "slug" => slug,
          "artwork_slug" => main["artwork_slug"],
          "category" => main["category"],
          "description" => main["description"],
          "p5_version" => p5_version,
          "languages" => entries,
          "body_id" => "translation"
        }

        page = PageWithoutAFile.new(site, site.source, "translations", "#{slug}.html")
        page.data.merge!(data)
        page.data["permalink"] = "/translations/#{slug}"
        site.pages << page

        ids.each do |id|
          redirect = PageWithoutAFile.new(site, site.source, "translations/#{id}", "#{slug}.html")
          redirect.data.merge!(
            "layout" => "redirect",
            "title" => main["title"],
            "redirect_to" => "/translations/#{slug}",
            "redirect_lang" => id,
            "permalink" => "/translations/#{id}/#{slug}",
            "sitemap" => false
          )
          site.pages << redirect
        end

        index << data.reject { |k, _| k == "languages" }.merge(
          "url" => "/translations/#{slug}",
          "language_ids" => ids
        )
      end

      site.data["translations_index"] = index.sort_by { |t| t["title"].to_s.downcase }
    end
  end
end
