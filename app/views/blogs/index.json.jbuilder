json.array!(@blogs) do |blog|
  json.extract! blog, :id, :titulo, :descripcion, :imagen, :documento, :estado
  json.url blog_url(blog, format: :json)
end
