# frozen_string_literal: true

require 'test_helper'

module QuickSearch
  class WorldCatKnowledgeBaseSearcher
    # WorldCatKnowledgeBaseSearch tests
    class Test < ActiveSupport::TestCase
      test 'truth' do
        assert_kind_of Module, QuickSearch::WorldCatKnowledgeBaseSearcher
      end
    end
  end
end
