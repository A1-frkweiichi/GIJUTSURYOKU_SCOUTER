module ApplicationHelper
  def default_meta_tags
    {
      site: '技術力 スカウター',
      title: 'ぎ...技術力...○○だと...!?',
      reverse: true,
      charset: 'utf-8',
      description: 'あなたの技術力を数値化します',
      keywords: 'エンジニア,GitHub,コントリビューション,コミット',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@',
        image: image_url('ogp.png')
      }
    }
  end
end
