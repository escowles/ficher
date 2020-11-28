json.extract! page, :id, :title, :text, :row, :col, :sheet_id, :created_at, :updated_at
json.url page_url(page, format: :json)
