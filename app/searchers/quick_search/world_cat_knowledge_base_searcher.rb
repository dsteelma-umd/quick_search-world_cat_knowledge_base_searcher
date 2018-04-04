module QuickSearch
  # QuickSearch seacher for WorldCat Knowledge Base
  class WorldCatKnowledgeBaseSearcher < QuickSearch::Searcher
    def search
      raw_response = @http.get(base_url, parameters, headers)
      @response = JSON.parse(raw_response.body)
    end

    def results # rubocop:disable Metrics/MethodLength
      if results_list
        results_list
      else
        @results_list = []

        @response['entries'].each do |value|
          result = OpenStruct.new
          result.title = value['title']
          result.link = value['links'][2]['href']
          result.author = value['kb:publisher']
          result.date = published(value)
          @results_list << result
        end

        @results_list
      end
    end

    def base_url
      QuickSearch::Engine::WORLD_CAT_KNOWLEDGE_BASE_CONFIG['base_url']
    end

    def parameters
      {
        'q' => http_request_queries['not_escaped'],
        'itemsPerPage' => '3',
        'institution_id' => QuickSearch::Engine::WORLD_CAT_KNOWLEDGE_BASE_CONFIG['institution_id'],
        'wskey' => QuickSearch::Engine::WORLD_CAT_KNOWLEDGE_BASE_CONFIG['wskey']
      }
    end

    def headers
      {
        'Accept' => 'application/json'
      }
    end

    def total
      @response['os:totalResults']
    end

    def loaded_link
      QuickSearch::Engine::WORLD_CAT_KNOWLEDGE_BASE_CONFIG['loaded_link'] +
        http_request_queries['uri_escaped']
    end

    def published(value)
      datetime = value['published']
      d = Time.zone.parse(datetime)
      d.strftime('%Y')
    end
  end
end
