Rails.application.routes.draw do
  mount QuickSearchWorldCatKnowledgeBaseSearcher::Engine => '/quick_search-world_cat_knowledge_base_searcher'
end